# Sysplorer AI Copilot 使用说明

## 📁 文件结构

```
.
├── simple_server.py          # 主服务器（简化版）
├── sysplorer_api.py          # API接口文档（不能直接import）
├── sysplorer_tools.py        # 辅助工具函数
└── README.md                 # 本文件
```

## 🚀 快速启动

### 1. 环境准备

确保已安装：
- Python 3.8+
- mworks.sysplorer 库（Sysplorer的Python API）

设置环境变量：
```bash
set DASHSCOPE_API_KEY=your_api_key_here
```

### 2. 启动服务器

```bash
python simple_server.py
```

服务器将在 `http://127.0.0.1:8000` 启动。

### 3. 测试健康检查

访问：`http://127.0.0.1:8000/health`

应返回：
```json
{"status": "ok", "pid": 12345}
```

## 📡 API接口

### POST /chat

与AI进行对话，自动执行建模任务。

**请求示例：**

```json
{
  "model": "qwen-plus",
  "base_url": "https://dashscope.aliyuncs.com/compatible-mode/v1",
  "api_key": "your_api_key",
  "messages": [
    {
      "role": "user",
      "content": "帮我创建一个PID控制器模型"
    }
  ]
}
```

**响应：** 流式文本输出

## 🎯 核心功能

### 1. 自动工具调用

服务器会自动：
1. 解析 `sysplorer_api.py` 中的函数定义
2. 为每个函数生成OpenAI Function Schema
3. 通过 `mworks.sysplorer` 执行实际操作

### 2. 组件搜索

内置组件知识库，支持关键词搜索：

```python
# 用户说："添加一个PID控制器"
# AI自动调用：
sys_search_component(keyword="PID")
# 返回：SysplorerEmbeddedCoder.Discrete.DiscretePIDController
```

### 3. 自主规划

AI会自动规划建模步骤：

```
用户："创建一个包含PID和Gain的模型"

AI执行流程：
1. sys_initialize()
2. NewModel(modelName='Model1', restriction='Sysblock')
3. sys_search_component(keyword='PID')
4. AddComponent(typeName='...DiscretePIDController', ...)
5. sys_search_component(keyword='Gain')
6. AddComponent(typeName='...Gain', ...)
7. SaveModel(modelName='Model1')
```

## 🔧 关键实现

### Schema生成

```python
def create_tool_schema(func_name, doc, params, param_docs):
    """从函数签名和文档生成OpenAI Function Schema"""
    # 1. 提取函数描述
    # 2. 解析参数类型和说明
    # 3. 标记必需参数
    # 4. 返回标准Schema
```

### 工具执行

```python
def make_executor(name, param_list):
    """创建工具执行函数"""
    def executor(**kwargs):
        # 1. 特殊处理（如强制Sysblock）
        # 2. 类型转换（字符串转int/float）
        # 3. 调用mworks.sysplorer.function()
        # 4. 返回结果
    return executor
```

### 自主循环

```python
while current_turn < max_turns:
    # 1. 调用LLM
    # 2. 流式输出文本
    # 3. 收集tool_calls
    # 4. 执行工具
    # 5. 将结果添加到messages
    # 6. 继续下一轮（如果有工具调用）
```

## 📝 示例对话

### 示例1：创建简单模型

**用户：** "创建一个名为Test1的模型，添加一个Constant组件"

**AI执行：**
1. ✅ sys_initialize() → "成功连接到Sysplorer实例"
2. ✅ NewModel(modelName='Test1', restriction='Sysblock') → True
3. ✅ sys_search_component(keyword='Constant') → {...path: "SysplorerEmbeddedCoder.Sources.Constant"}
4. ✅ AddComponent(typeName='SysplorerEmbeddedCoder.Sources.Constant', modelName='Test1', name='const1', x=100, y=100) → True
5. ✅ SaveModel(modelName='Test1') → True

**AI回复：** "已成功创建模型Test1并添加了Constant组件！"

### 示例2：完整PID控制系统

**用户：** "帮我搭建一个PID控制系统，包含输入、PID控制器、被控对象和输出"

**AI执行：**
1. sys_initialize()
2. NewModel(modelName='PID_System', restriction='Sysblock')
3. 添加Inport组件（输入）
4. 添加DiscretePIDController组件
5. 添加TransferFunction组件（被控对象）
6. 添加Outport组件（输出）
7. ConnectPort连接各组件
8. SaveModel

## ⚙️ 配置说明

### 修改端口

```python
# simple_server.py
PORT = 8000  # 改为你想要的端口
```

### 添加组件库

```python
# simple_server.py
COMPONENT_DB = {
    "自定义关键词": "完整库路径",
    # 例如：
    "lowpass": "SysplorerEmbeddedCoder.Filters.LowPassFilter"
}
```

### 调整最大轮次

```python
# simple_server.py - ChatHandler.do_POST()
max_turns = 10  # 默认10轮，可根据需要调整
```

## 🐛 调试

### 查看工具调用

服务器控制台会打印：

```
[执行] NewModel({'modelName': 'Test1', 'restriction': 'Sysblock'})
[结果] True

[执行] AddComponent({'typeName': '...', 'modelName': 'Test1', ...})
[结果] True
```

### 前端显示

前端会收到：

```
🔧 [执行工具] NewModel...
✅ [结果] True

🔧 [执行工具] AddComponent...
✅ [结果] True
```

## 🔄 与原server.py的区别

| 功能 | 原版 | 简化版 |
|------|------|--------|
| 代码行数 | ~700行 | ~450行 |
| 插件系统 | 支持动态插件 | 仅Sysplorer |
| 单例检测 | 支持 | 移除 |
| 日志系统 | 完整 | 简化 |
| 核心功能 | 完全相同 | 完全相同 |

## 📌 注意事项

1. **必须先启动Sysplorer软件**，否则sys_initialize()会失败
2. **sysplorer_api.py是文档**，不要尝试import它
3. **工作目录**：如需指定，在对话中告诉AI路径
4. **模型类型**：系统强制使用"Sysblock"模板
5. **组件路径**：必须使用完整的库路径（通过sys_search_component获取）

## 🎓 扩展开发

### 添加新工具

1. 在 `sysplorer_api.py` 中添加函数定义（带完整文档）
2. 重启服务器，自动加载

### 自定义辅助工具

```python
# simple_server.py
def my_custom_tool(param1: str):
    """工具说明"""
    # 实现逻辑
    return result

# 在load_tools()中注册
TOOLS_MAP["my_custom_tool"] = my_custom_tool
TOOLS_SCHEMA.append({...})
```

## 📞 故障排查

| 问题 | 解决方法 |
|------|----------|
| "未找到运行中的Sysplorer实例" | 启动Sysplorer软件 |
| "mworks.sysplorer库未安装" | 安装Sysplorer Python API |
| "缺少API Key" | 设置DASHSCOPE_API_KEY环境变量 |
| 工具调用失败 | 检查参数类型和Sysplorer软件状态 |

## 🏆 最佳实践

1. **明确指令**：告诉AI具体要创建什么
2. **提供路径**：如需指定工作目录，在对话中说明
3. **逐步验证**：可以让AI先规划，再执行
4. **错误处理**：AI会自动重试和修正参数

---

**版本：** 1.0  
**更新日期：** 2024
