# 前端适配版本说明

## 🔄 主要修改点

### 1. **消息历史处理** ✅

**前端发送格式：**
```javascript
// script.js Line 156
fetch('http://127.0.0.1:8000/chat', {
    body: JSON.stringify({
        messages: payload.messages,  // ← 完整的聊天历史数组
        message: payload.message,    // ← 当前消息（fallback）
        model: payload.model,
        base_url: payload.baseUrl,
        api_key: payload.apiKey,
        stream: true
    })
})
```

**后端修改：**
```python
# 优先使用messages数组
messages = body.get("messages", [])
# 如果没有messages，才用单个message
if not messages and body.get("message"):
    messages = [{"role": "user", "content": body.get("message")}]
```

---

### 2. **纯文本流式输出** ✅

**前端期望：**
```javascript
// script.js - appendStreamChunk()
// 前端直接接收纯文本，不需要 "data:" 前缀
const chunk = decoder.decode(value, { stream: true });
appendStreamChunk(chunk);  // 直接处理文本
```

**后端修改：**
```python
# ❌ 旧版（SSE格式）
self.wfile.write(f"data: {content}\n\n".encode("utf-8"))

# ✅ 新版（纯文本）
self.wfile.write(content.encode("utf-8"))
```

---

### 3. **工具执行过程可视化** ✅

**前端显示需求：**
- 显示正在执行的工具名称
- 显示工具参数
- 显示执行结果
- 使用 Markdown 格式（支持代码高亮）

**后端实现：**
```python
# 显示工具信息
tool_info = f"\n\n🔧 **正在执行：** `{func_name}`\n"
self.wfile.write(tool_info.encode("utf-8"))

# 显示参数（JSON格式）
params_info = f"```json\n{args_str}\n```\n"
self.wfile.write(params_info.encode("utf-8"))

# 显示结果
result_info = f"**结果：** {result_content}\n"
self.wfile.write(result_info.encode("utf-8"))
```

**前端效果：**
```
🔧 正在执行：sys_initialize

结果：✅ 成功连接到Sysplorer

🔧 正在执行：NewModel
```json
{
  "modelName": "TestModel",
  "restriction": "Sysblock"
}
```
结果：True
```

---

### 4. **配置检查接口** ✅

**前端需求：**
```javascript
// script.js Line 117
fetch('http://127.0.0.1:8000/config')
    .then(resp => resp.json())
    .then(data => {
        if (!data || !data.has_env_key) {
            showSettings();  // 显示设置对话框
        }
    })
```

**后端添加：**
```python
def do_GET(self):
    if self.path == "/config":
        has_key = bool(os.getenv("DASHSCOPE_API_KEY"))
        send_json(self, 200, {"has_env_key": has_key})
```

---

### 5. **CORS支持** ✅

**前端跨域请求：**
```javascript
fetch('http://127.0.0.1:8000/chat', ...)
```

**后端响应头：**
```python
self.send_header("Access-Control-Allow-Origin", "*")
self.send_header("Access-Control-Allow-Headers", "Content-Type, Authorization")
self.send_header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
```

---

## 📋 完整对比

| 功能 | simple_server.py | server_v2.py |
|------|------------------|--------------|
| 消息格式 | 单个message | messages数组优先 |
| 流式输出 | SSE格式(data:) | 纯文本流 |
| 工具显示 | 简单文本 | Markdown格式化 |
| 配置接口 | 无 | /config端点 |
| 前端兼容 | ❌ | ✅ |

---

## 🎯 使用方法

### 启动服务器

```bash
# 设置API Key（可选，也可在前端设置）
set DASHSCOPE_API_KEY=your_key

# 启动服务器
python server_v2.py
```

### 前端使用

1. 打开 `index.html`
2. 点击设置图标 ⚙️
3. 配置：
   - **Model URL:** `https://dashscope.aliyuncs.com/compatible-mode/v1`
   - **API Key:** `sk-your-key`
4. 保存并开始对话

---

## 🔍 工作流程

```
用户在前端输入："创建一个PID模型"
    ↓
前端发送：
{
  "messages": [
    {"role": "system", "content": "..."},
    {"role": "user", "content": "创建一个PID模型"}
  ],
  "model": "qwen-plus",
  "base_url": "...",
  "api_key": "..."
}
    ↓
后端处理：
1. 接收完整messages数组
2. 调用LLM分析任务
3. LLM决定调用工具
    ↓
后端流式输出：
"好的，我来帮你创建PID模型。

🔧 **正在执行：** `sys_initialize`
**结果：** ✅ 成功连接到Sysplorer

🔧 **正在执行：** `NewModel`
```json
{
  "modelName": "PIDModel",
  "restriction": "Sysblock"
}
```
**结果：** True

模型创建成功！"
    ↓
前端显示：
- 使用 marked.js 渲染 Markdown
- 使用 highlight.js 高亮代码
- 逐字打字机效果
```

---

## ✨ 新增特性

### 1. Markdown支持

后端现在输出格式化的Markdown，前端自动渲染：

```markdown
🔧 **正在执行：** `sys_initialize`

**结果：** ✅ 成功连接

---

🔧 **正在执行：** `AddComponent`
```json
{
  "typeName": "SysplorerEmbeddedCoder.Discrete.DiscretePIDController",
  "modelName": "PIDModel",
  "name": "pid1",
  "x": 100,
  "y": 100
}
```
**结果：** True
```

### 2. 工具参数可视化

JSON代码块自动高亮：
```json
{
  "modelName": "TestModel",
  "restriction": "Sysblock"
}
```

### 3. 状态指示器

- 🔧 工具执行中
- ✅ 成功
- ❌ 失败

---

## 🐛 调试建议

### 查看服务器日志

```
🔧 [NewModel] {"modelName": "PIDModel", "restriction": "Sysblock"}
✅ [结果] True

🔧 [AddComponent] {"typeName": "...", "modelName": "PIDModel", ...}
✅ [结果] True
```

### 前端调试

打开浏览器控制台（F12），查看：
- Network标签：查看请求/响应
- Console标签：查看错误信息

---

## 📝 示例对话

### 示例1：创建简单模型

**用户输入：**
> 创建一个名为Test1的模型，添加一个Constant组件

**前端显示：**
```
好的，我来帮你创建模型。

🔧 正在执行：sys_initialize
结果：✅ 成功连接到Sysplorer

🔧 正在执行：NewModel
```json
{
  "modelName": "Test1",
  "restriction": "Sysblock"
}
```
结果：True

🔧 正在执行：sys_search_component
```json
{
  "keyword": "Constant"
}
```
结果：{"status": "found", "path": "SysplorerEmbeddedCoder.Sources.Constant"}

🔧 正在执行：AddComponent
```json
{
  "typeName": "SysplorerEmbeddedCoder.Sources.Constant",
  "modelName": "Test1",
  "name": "const1",
  "x": 100,
  "y": 100
}
```
结果：True

🔧 正在执行：SaveModel
```json
{
  "modelName": "Test1"
}
```
结果：True

✅ 模型Test1创建成功！已添加Constant组件并保存。
```

---

## 🎨 前端界面特性

根据你上传的截图和代码，前端支持：

1. **模式选择**：Ask / Agent / Debug
2. **模型选择**：qwen-plus / qwen-max / deepseek-v3.2 等
3. **Markdown渲染**：使用 marked.js
4. **代码高亮**：使用 highlight.js (github主题)
5. **打字机效果**：逐字显示，更自然
6. **停止生成**：点击停止按钮取消请求

---

## 🔐 安全建议

### 环境变量方式（推荐）
```bash
set DASHSCOPE_API_KEY=sk-your-key
python server_v2.py
```

### 前端设置方式
1. 点击设置 ⚙️
2. 输入API Key
3. 保存到 localStorage

**注意：** 前端设置的Key会保存在浏览器本地存储中。

---

## 📌 重要提示

### ✅ 兼容前端
- ✅ 接收 `messages` 数组
- ✅ 纯文本流式输出
- ✅ Markdown格式化
- ✅ `/config` 接口

### ✅ 保留功能
- ✅ 自主工具调用循环
- ✅ 中文文档解析
- ✅ 类型自动转换
- ✅ 组件搜索

### ✅ 新增功能
- ✅ 工具执行可视化
- ✅ JSON参数格式化
- ✅ 状态emoji指示

---

**版本：** 2.0 (Frontend Compatible)  
**更新日期：** 2024-02-05
