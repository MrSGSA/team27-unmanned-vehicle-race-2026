# 🚀 快速开始指南

## 1分钟快速部署

### Step 1: 准备环境

```bash
# 确保安装了Python 3.8+
python --version

# 设置API Key
set DASHSCOPE_API_KEY=sk-your-api-key-here
```

### Step 2: 启动Sysplorer

双击打开 **Sysplorer 2026a** 软件（必须保持运行状态）

### Step 3: 启动服务器

**方式1：双击启动（推荐）**
```
双击 start_server.bat
```

**方式2：命令行启动**
```bash
python simple_server.py
```

### Step 4: 测试

看到以下输出表示成功：

```
============================================================
Sysplorer AI Copilot Server
============================================================
从sysplorer_api.py加载了15个函数
成功加载17个工具

🚀 服务器启动于 http://127.0.0.1:8000
📝 工具数量：17
💡 访问 http://127.0.0.1:8000/health 检查状态
```

---

## 核心文件说明

### 📄 simple_server.py
**主服务器程序**（450行）

核心功能：
- ✅ 解析 `sysplorer_api.py` 接口文档
- ✅ 生成 OpenAI Function Schema
- ✅ 实现自主工具调用循环
- ✅ 通过 `mworks.sysplorer` 执行实际操作

### 📄 sysplorer_api.py
**接口文档**（仅供参考，不能import）

包含的API示例：
- `FindSysplorer()` - 查找运行实例
- `NewModel()` - 创建模型
- `AddComponent()` - 添加组件
- `ConnectPort()` - 连接端口
- `SaveModel()` - 保存模型
- ...

### 📄 README.md
完整使用说明文档

### 📄 ARCHITECTURE.md
架构设计和实现细节

---

## 使用示例

### 示例1：创建简单模型

**前端输入：**
```
创建一个名为Test1的模型，添加一个Constant组件
```

**AI自动执行：**
```
1. sys_initialize() → 连接Sysplorer
2. NewModel(modelName='Test1', restriction='Sysblock') → 创建模型
3. sys_search_component(keyword='Constant') → 查找组件
4. AddComponent(...) → 添加组件
5. SaveModel(modelName='Test1') → 保存
```

**结果：**
✅ 在Sysplorer中成功创建了包含Constant组件的Test1模型

---

### 示例2：PID控制系统

**前端输入：**
```
帮我搭建一个PID控制系统：
- 模型名：PID_Control
- 组件：Constant输入、PID控制器、Gain增益、Sum求和
- 自动连接各组件
```

**AI执行流程：**
```
1. sys_initialize()
2. NewModel(modelName='PID_Control', ...)
3. 查找并添加4个组件
4. ConnectPort连接组件
5. SaveModel保存
```

**预期耗时：** 15-20秒

---

## 工作原理

### 完整流程图

```
用户输入
   ↓
前端 → POST /chat → 服务器
                      ↓
                  解析sysplorer_api.py
                      ↓
                  生成工具Schema
                      ↓
            ┌─────────────────────┐
            │   自主循环（最多10轮） │
            │                     │
            │  LLM分析任务         │
            │    ↓                │
            │  输出文本/工具调用    │
            │    ↓                │
            │  执行工具            │
            │    ↓                │
            │  返回结果给LLM       │
            │    ↓                │
            │  判断：需要继续？     │
            └─────────────────────┘
                      ↓
              调用mworks.sysplorer
                      ↓
              Sysplorer软件执行
                      ↓
              返回结果给用户
```

---

## 关键代码片段

### 1. 解析API文档

```python
def parse_api_file(filepath):
    """从sysplorer_api.py提取函数定义"""
    with open(filepath, 'r', encoding='utf-8') as f:
        source = f.read()
    
    tree = ast.parse(source)  # 抽象语法树解析
    
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef):
            yield (node.name, ast.get_docstring(node), extract_params(node))
```

### 2. 工具执行

```python
def make_executor(func_name, param_list):
    def executor(**kwargs):
        import mworks.sysplorer as eng
        method = getattr(eng, func_name)
        return method(**kwargs)
    return executor

TOOLS_MAP["NewModel"] = make_executor("NewModel", ...)
```

### 3. 自主循环

```python
while current_turn < max_turns:
    response = llm.chat(messages, tools=TOOLS_SCHEMA)
    
    if response.tool_calls:
        for tool in response.tool_calls:
            result = TOOLS_MAP[tool.name](**tool.args)
            messages.append({"role": "tool", "content": result})
        continue
    else:
        break
```

---

## 常见问题

### Q1: "未找到运行中的Sysplorer实例"

**原因：** Sysplorer软件未启动

**解决：** 启动Sysplorer 2026a软件

---

### Q2: "mworks.sysplorer库未安装"

**原因：** 未安装Sysplorer Python API

**解决：** 
1. 找到安装包：`D:\Programs\Sysplorer 2026a\...\Tools\sysplorer_python_api\`
2. 按照安装手册安装

---

### Q3: 工具调用失败

**可能原因：**
- 参数类型错误 → 系统会自动转换
- Sysplorer软件状态异常 → 重启软件
- 工作路径不存在 → 使用ChangeDirectory指定路径

**调试方法：**
查看服务器控制台的 `[执行]` 和 `[结果]` 日志

---

## 高级功能

### 自定义组件库

编辑 `simple_server.py`：

```python
COMPONENT_DB = {
    "pid": "SysplorerEmbeddedCoder.Discrete.DiscretePIDController",
    "我的组件": "自定义.库路径.组件名",
    # 添加更多...
}
```

### 添加新API

编辑 `sysplorer_api.py`：

```python
def MyNewFunction(param1: str, param2: int):
    """
    我的新功能
    
    输入参数
        param1 - 参数1说明
        数据类型：str
        
        param2 - 参数2说明
        数据类型：int
    """
    pass
```

重启服务器，自动加载！

---

## 性能优化建议

### 当前配置（开发模式）
- 最大轮次：10轮
- 超时时间：120秒
- 无缓存

### 生产环境建议
```python
# simple_server.py
max_turns = 20  # 增加复杂任务支持
timeout = 300   # 5分钟超时
# 添加结果缓存
# 添加请求限流
```

---

## 技术栈

| 组件 | 技术 |
|------|------|
| HTTP服务器 | Python ThreadingHTTPServer |
| LLM | 阿里云通义千问（qwen-plus）|
| 代码解析 | Python AST |
| 建模引擎 | Sysplorer Python API |
| 协议 | OpenAI Function Calling |

---

## 下一步

1. ✅ 基础功能已完成
2. 🔄 测试复杂建模任务
3. 🔄 优化提示词
4. ⏳ 添加日志系统
5. ⏳ 实现会话管理
6. ⏳ 前端界面优化

---

## 获取帮助

查看详细文档：
- `README.md` - 完整使用指南
- `ARCHITECTURE.md` - 架构设计
- `test_client.py` - 测试示例

---

**版本：** 1.0  
**最后更新：** 2024-02-05
