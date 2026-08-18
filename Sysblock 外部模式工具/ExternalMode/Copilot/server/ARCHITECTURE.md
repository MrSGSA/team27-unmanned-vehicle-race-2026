# 核心架构说明

## 📊 系统架构

```
用户前端
    ↓ (HTTP POST /chat)
服务器 (server.py)
    ↓
┌─────────────────────────────────┐
│  1. 解析sysplorer_api.py       │ ← 接口文档（不可导入）
│  2. 生成OpenAI Function Schema │
│  3. 注册工具到TOOLS_MAP        │
└─────────────────────────────────┘
    ↓
┌─────────────────────────────────┐
│  自主循环 (最多10轮)            │
│  ┌───────────────────────────┐  │
│  │ 1. 调用LLM (千问模型)   │  │
│  │ 2. 流式输出文本           │  │
│  │ 3. 检测tool_calls        │  │
│  │ 4. 执行工具               │  │
│  │ 5. 返回结果到LLM         │  │
│  └───────────────────────────┘  │
└─────────────────────────────────┘
    ↓ (调用mworks.sysplorer)
Sysplorer软件
```

## 🔑 核心实现

### 1. 接口文档解析

**问题：** sysplorer_api.py不能直接import

**解决：** 使用AST解析

```python
def parse_api_file(filepath):
    """解析API文档，提取函数签名"""
    with open(filepath, 'r', encoding='utf-8') as f:
        source = f.read()
    
    tree = ast.parse(source)  # 解析为抽象语法树
    
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef):
            # 提取：函数名、文档、参数列表
            func_name = node.name
            doc = ast.get_docstring(node)
            params = extract_params(node.args)  # 从AST提取参数
            
            yield (func_name, doc, params)
```

### 2. Schema自动生成

**输入：** 函数签名 + 中文文档

```python
def NewModel(modelName: str, restriction: str = "Sysblock"):
    """
    创建新的模型
    
    输入参数
        modelName - 新模型的名称
        数据类型：str
        
        restriction - 模型类型限制，必须为"Sysblock"
        数据类型：str
    """
```

**输出：** OpenAI Function Schema

```json
{
  "type": "function",
  "function": {
    "name": "NewModel",
    "description": "创建新的模型",
    "parameters": {
      "type": "object",
      "properties": {
        "modelName": {
          "type": "string",
          "description": "新模型的名称"
        },
        "restriction": {
          "type": "string",
          "description": "模型类型限制，必须为\"Sysblock\""
        }
      },
      "required": ["modelName"]
    }
  }
}
```

### 3. 工具执行引擎

**关键代码：**

```python
def make_executor(func_name, param_list):
    """为每个API函数创建执行包装器"""
    def executor(**kwargs):
        # Step 1: 特殊处理
        if func_name == "NewModel":
            kwargs["restriction"] = "Sysblock"  # 强制模板
        
        # Step 2: 类型转换
        for p_name, p_type in param_types.items():
            if p_name in kwargs:
                if p_type == "integer":
                    kwargs[p_name] = int(float(kwargs[p_name]))
                elif p_type == "number":
                    kwargs[p_name] = float(kwargs[p_name])
        
        # Step 3: 调用实际API
        import mworks.sysplorer as eng
        method = getattr(eng, func_name)
        result = method(**kwargs)
        
        return result
    
    return executor

# 注册
TOOLS_MAP["NewModel"] = make_executor("NewModel", params)
```

### 4. 自主循环

**核心逻辑：**

```python
max_turns = 10
messages = [system_prompt, user_message]

while current_turn < max_turns:
    # 1. 调用LLM
    response = llm.chat(messages, tools=TOOLS_SCHEMA)
    
    # 2. 流式输出文本
    for chunk in response:
        if chunk.content:
            print(chunk.content)  # 发送给前端
    
    # 3. 检测工具调用
    if response.tool_calls:
        # 添加助手消息
        messages.append({
            "role": "assistant",
            "tool_calls": response.tool_calls
        })
        
        # 4. 执行每个工具
        for tool_call in response.tool_calls:
            result = TOOLS_MAP[tool_call.name](**tool_call.args)
            
            # 5. 添加结果
            messages.append({
                "role": "tool",
                "content": result
            })
        
        # 继续下一轮
        continue
    
    else:
        # 没有工具调用，结束
        break
```

## 🎯 关键优化

### 1. 中文文档解析

```python
def parse_docstring_params(doc):
    """支持Sysplorer的中文文档格式"""
    
    # 识别"输入参数"区域
    if "输入参数" in doc:
        # 解析格式：
        # param_name - 说明
        # 数据类型：type
        
        for line in lines:
            if match("param_name - description"):
                params[name] = {"description": desc}
            if match("数据类型：type"):
                params[name]["type"] = type
```

### 2. 组件搜索增强

```python
COMPONENT_DB = {
    "pid": "SysplorerEmbeddedCoder.Discrete.DiscretePIDController",
    "gain": "SysplorerEmbeddedCoder.MathOperation.Gain",
    # ...
}

def sys_search_component(keyword):
    """智能搜索组件库路径"""
    k = keyword.lower()
    
    # 精确匹配
    if k in COMPONENT_DB:
        return COMPONENT_DB[k]
    
    # 模糊匹配
    matches = {key: path for key, path in COMPONENT_DB.items() if k in key}
    return matches
```

### 3. 类型自动转换

```python
# LLM可能返回："100.0" (字符串)
# API需要：100 (整数)

def executor(**kwargs):
    for param_name, param_type in schema.items():
        if param_type == "integer":
            kwargs[param_name] = int(float(kwargs[param_name]))
```

## 📈 执行流程示例

**用户输入：**
> "创建一个PID模型"

**执行流程：**

```
Turn 1: LLM分析
├─ 理解：需要创建模型并添加PID组件
├─ 规划：
│  1. 初始化连接
│  2. 创建模型
│  3. 搜索PID组件
│  4. 添加组件
│  5. 保存模型
└─ 输出：tool_calls=[sys_initialize]

Turn 2: 执行sys_initialize
├─ 调用：sys_initialize()
├─ 结果："成功连接到Sysplorer实例"
└─ 继续

Turn 3: LLM处理结果
├─ 看到：连接成功
└─ 输出：tool_calls=[NewModel]

Turn 4: 执行NewModel
├─ 调用：eng.NewModel(modelName='PIDModel', restriction='Sysblock')
├─ 结果：True
└─ 继续

Turn 5: 搜索组件
├─ 调用：sys_search_component(keyword='PID')
├─ 结果：{"path": "SysplorerEmbeddedCoder.Discrete.DiscretePIDController"}
└─ 继续

Turn 6: 添加组件
├─ 调用：eng.AddComponent(
│           typeName='SysplorerEmbeddedCoder.Discrete.DiscretePIDController',
│           modelName='PIDModel',
│           name='pid1',
│           x=100, y=100
│         )
├─ 结果：True
└─ 继续

Turn 7: 保存模型
├─ 调用：eng.SaveModel(modelName='PIDModel')
├─ 结果：True
└─ 继续

Turn 8: LLM总结
├─ 看到：所有操作成功
├─ 输出："已成功创建PID模型！模型包含一个PID控制器组件。"
└─ 结束（无tool_calls）
```

## 🔍 调试信息

### 服务器端输出

```
从sysplorer_api.py加载了15个函数
成功加载17个工具

🚀 服务器启动于 http://127.0.0.1:8000
📝 工具数量：17

[执行] sys_initialize({})
[结果] 成功连接到Sysplorer实例

[执行] NewModel({'modelName': 'PIDModel', 'restriction': 'Sysblock'})
[结果] True

[执行] sys_search_component({'keyword': 'PID'})
[结果] {"status": "found", "path": "..."}
```

### 前端显示

```
正在连接Sysplorer...

🔧 [执行工具] sys_initialize...
✅ [结果] 成功连接到Sysplorer实例

🔧 [执行工具] NewModel...
✅ [结果] True

好的！我已经成功创建了PID模型。模型已保存。
```

## ⚡ 性能特点

| 指标 | 数值 |
|------|------|
| 启动时间 | <1秒 |
| 单个工具调用 | ~100ms |
| LLM响应时间 | 1-3秒/轮 |
| 完整建模任务 | 10-30秒 |
| 内存占用 | ~50MB |

## 🛡️ 错误处理

### 1. 连接失败

```python
try:
    ids = eng.FindSysplorer()
    if not ids:
        return "未找到运行中的Sysplorer实例"
except Exception as e:
    return f"连接失败：{str(e)}"
```

### 2. 参数错误

```python
try:
    result = method(**kwargs)
except Exception as e:
    return f"执行{func_name}时出错：{str(e)}"
    # LLM会看到错误信息并尝试修正
```

### 3. 类型转换失败

```python
try:
    kwargs[p_name] = int(float(kwargs[p_name]))
except (ValueError, TypeError):
    pass  # 保持原值，让函数本身报错
```

## 📦 部署建议

### 生产环境

1. 添加日志系统（logging）
2. 实现单例检测（防止多实例）
3. 添加认证（API Key验证）
4. 限流保护（防滥用）
5. 完整错误追踪

### 当前版本（功能验证）

✅ 专注核心功能  
✅ 代码简洁易懂  
✅ 快速迭代测试  
✅ 便于调试

---

**设计原则：** 简单、直接、可工作  
**目标：** 功能跑通 > 工程完善
