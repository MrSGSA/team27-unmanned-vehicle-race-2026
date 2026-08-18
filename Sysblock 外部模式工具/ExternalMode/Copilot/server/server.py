"""
Sysplorer AI Copilot Server - Frontend Compatible Version
=========================================================
完全适配前端的后端实现
"""

import json
import os
import sys
import ast
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.request import Request, urlopen
from urllib.error import HTTPError

# ========== 配置 ==========
HOST = "127.0.0.1"
PORT = 8000
SYSPLORER_API_DOC = os.path.abspath(os.path.join(os.path.dirname(__file__), "sysplorer_api.py"))
APP_IDENTITY = "ai_copilot_server_v1"

# ========== 全局状态 ==========
TOOLS_SCHEMA = []
TOOLS_MAP = {}

# ========== 组件知识库 ==========
COMPONENT_DB = {
    "pid": "SysplorerEmbeddedCoder.Discrete.DiscretePIDController",
    "pid controller": "SysplorerEmbeddedCoder.Discrete.DiscretePIDController",
    "gain": "SysplorerEmbeddedCoder.MathOperation.Gain",
    "constant": "SysplorerEmbeddedCoder.Sources.Constant",
    "step": "SysplorerEmbeddedCoder.Sources.Step",
    "integrator": "SysplorerEmbeddedCoder.Continuous.Integrator",
    "sum": "SysplorerEmbeddedCoder.MathOperation.Sum",
    "add": "SysplorerEmbeddedCoder.MathOperation.Sum",
    "product": "SysplorerEmbeddedCoder.MathOperation.Product",
    "multiply": "SysplorerEmbeddedCoder.MathOperation.Product",
    "outport": "SysplorerEmbeddedCoder.Port.Outport",
    "inport": "SysplorerEmbeddedCoder.Port.Inport",
    "sine": "SysplorerEmbeddedCoder.Sources.SineWave",
    "pulse": "SysplorerEmbeddedCoder.Sources.PulseGenerator",
    "mux": "SysplorerEmbeddedCoder.SignalRouting.Mux",
    "demux": "SysplorerEmbeddedCoder.SignalRouting.DeMux",
    "sqrt": "SysplorerEmbeddedCoder.MathOperation.Sqrt"
}

# ========== 辅助工具 ==========
def kill_existing_server(port):
    """Kills existing server instance by checking /health endpoint for identity match."""
    health_url = f"http://{HOST}:{port}/health"
    try:
        req = Request(health_url, method="GET")
        with urlopen(req, timeout=1) as response:
            if response.status == 200:
                data = json.loads(response.read().decode("utf-8"))
                if data.get("app") == APP_IDENTITY:
                    pid = data.get("pid")
                    if pid and pid != os.getpid():
                        print(f"Found existing instance (PID: {pid}). Killing it...")
                        import subprocess
                        subprocess.run(f'taskkill /F /PID {pid}', shell=True, capture_output=True)
                        import time
                        time.sleep(1)
    except Exception:
        pass



def sys_initialize():
    """初始化Sysplorer连接"""
    try:
        import mworks.sysplorer as eng
        ids = eng.FindSysplorer()
        if len(ids) > 0:
            eng.ConnectSysplorer(port=ids[0])
            return "✅ 成功连接到Sysplorer"
        return "❌ 未找到运行中的Sysplorer，请先启动软件"
    except ImportError:
        return "❌ mworks.sysplorer库未安装"
    except Exception as e:
        return f"❌ 连接失败：{str(e)}"


def sys_search_component(keyword: str):
    """搜索组件库路径"""
    k = keyword.lower().strip()
    
    if k in COMPONENT_DB:
        return json.dumps({
            "status": "found", 
            "path": COMPONENT_DB[k], 
            "keyword": k
        }, ensure_ascii=False)
    
    matches = {key: path for key, path in COMPONENT_DB.items() if k in key}
    if matches:
        return json.dumps({
            "status": "found", 
            "matches": matches
        }, ensure_ascii=False)
    
    return json.dumps({
        "status": "not_found", 
        "message": f"未找到'{keyword}'。可用：PID, Gain, Constant, Step, Sum"
    }, ensure_ascii=False)


# ========== Schema生成 ==========
def python_type_to_json_type(annotation):
    """类型转换"""
    if annotation in (str, "str"):
        return "string"
    if annotation in (int, "int"):
        return "integer"
    if annotation in (float, "float"):
        return "number"
    if annotation in (bool, "bool"):
        return "boolean"
    
    if isinstance(annotation, str):
        s = annotation.lower()
        if "int" in s: return "integer"
        if "float" in s: return "number"
        if "bool" in s: return "boolean"
    
    return "string"


def parse_docstring_params(doc):
    """解析中文文档参数"""
    params = {}
    if not doc:
        return params
    
    lines = doc.split('\n')
    in_params = False
    current_param = None
    
    for line in lines:
        stripped = line.strip()
        
        if "输入参数" in stripped or stripped == "Args:":
            in_params = True
            continue
        
        if in_params and ("返回值" in stripped or "示例" in stripped or stripped.startswith("Returns:")):
            break
        
        if in_params and stripped:
            import re
            m = re.match(r"^(\w+)\s*-\s*(.+)$", stripped)
            if m:
                param_name = m.group(1)
                description = m.group(2)
                params[param_name] = {"description": description, "type": None}
                current_param = param_name
            elif current_param and "数据类型" in stripped:
                m = re.match(r"数据类型[：:]\s*(.+)$", stripped)
                if m:
                    params[current_param]["type"] = m.group(1).strip()
    
    return params


def parse_api_file(filepath):
    """解析API文档"""
    with open(filepath, 'r', encoding='utf-8') as f:
        source = f.read()
    
    tree = ast.parse(source)
    functions = []
    
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef):
            func_name = node.name
            if func_name.startswith("_"):
                continue
            
            doc = ast.get_docstring(node) or ""
            
            params = []
            for arg in node.args.args:
                if arg.arg == "self":
                    continue
                
                param_info = {
                    "name": arg.arg,
                    "type": "string",
                    "required": True
                }
                
                if arg.annotation and isinstance(arg.annotation, ast.Name):
                    param_info["type"] = python_type_to_json_type(arg.annotation.id)
                
                params.append(param_info)
            
            num_defaults = len(node.args.defaults)
            if num_defaults > 0:
                for i in range(num_defaults):
                    params[-(i+1)]["required"] = False
            
            functions.append((func_name, doc, params))
    
    return functions


def create_tool_schema(func_name, doc, params, param_docs):
    """创建工具Schema"""
    description = doc.split('\n\n')[0].replace('\n', ' ').strip()
    if not description:
        description = f"执行{func_name}操作"
    
    properties = {}
    required = []
    
    for param in params:
        p_name = param["name"]
        p_type = param["type"]
        
        prop = {"type": p_type}
        
        if p_name in param_docs:
            prop["description"] = param_docs[p_name]["description"]
            if param_docs[p_name]["type"]:
                prop["type"] = python_type_to_json_type(param_docs[p_name]["type"])
        
        properties[p_name] = prop
        
        if param["required"]:
            required.append(p_name)
    
    return {
        "type": "function",
        "function": {
            "name": func_name,
            "description": description,
            "parameters": {
                "type": "object",
                "properties": properties,
                "required": required
            }
        }
    }


# ========== 工具加载 ==========
def load_tools():
    """加载所有工具"""
    global TOOLS_SCHEMA, TOOLS_MAP
    TOOLS_SCHEMA = []
    TOOLS_MAP = {}
    
    # 1. 辅助工具
    TOOLS_MAP["sys_initialize"] = sys_initialize
    TOOLS_SCHEMA.append({
        "type": "function",
        "function": {
            "name": "sys_initialize",
            "description": "初始化Sysplorer连接。在执行任何建模操作前必须先调用。",
            "parameters": {"type": "object", "properties": {}, "required": []}
        }
    })
    
    TOOLS_MAP["sys_search_component"] = sys_search_component
    TOOLS_SCHEMA.append({
        "type": "function",
        "function": {
            "name": "sys_search_component",
            "description": "搜索组件库路径。输入关键词返回完整路径。",
            "parameters": {
                "type": "object",
                "properties": {
                    "keyword": {"type": "string", "description": "组件关键词（PID/Gain/Constant）"}
                },
                "required": ["keyword"]
            }
        }
    })
    
    # 2. Sysplorer API
    try:
        import mworks.sysplorer as eng
        
        if not os.path.exists(SYSPLORER_API_DOC):
            print(f"⚠️  未找到{SYSPLORER_API_DOC}")
            return
        
        functions = parse_api_file(SYSPLORER_API_DOC)
        print(f"📚 从{SYSPLORER_API_DOC}加载{len(functions)}个函数")
        
        for func_name, doc, params in functions:
            param_docs = parse_docstring_params(doc)
            schema = create_tool_schema(func_name, doc, params, param_docs)
            TOOLS_SCHEMA.append(schema)
            
            def make_executor(name, param_list):
                def executor(**kwargs):
                    if name == "NewModel":
                        kwargs["restriction"] = "Sysblock"
                    
                    # 类型转换
                    for p in param_list:
                        p_name = p["name"]
                        p_type = p["type"]
                        if p_name in kwargs:
                            try:
                                if p_type == "integer":
                                    kwargs[p_name] = int(float(kwargs[p_name]))
                                elif p_type == "number":
                                    kwargs[p_name] = float(kwargs[p_name])
                                elif p_type == "boolean":
                                    if isinstance(kwargs[p_name], str):
                                        kwargs[p_name] = kwargs[p_name].lower() == "true"
                            except (ValueError, TypeError):
                                pass
                    
                    print(f"\n🔧 [{name}] {json.dumps(kwargs, ensure_ascii=False)}")
                    
                    if not hasattr(eng, name):
                        return f"❌ 函数{name}不存在"
                    
                    try:
                        method = getattr(eng, name)
                        result = method(**kwargs)
                        print(f"✅ [结果] {result}")
                        return result
                    except Exception as e:
                        error_msg = f"❌ {name}执行失败：{str(e)}"
                        print(error_msg)
                        return error_msg
                
                return executor
            
            TOOLS_MAP[func_name] = make_executor(func_name, params)
        
        print(f"✅ 成功加载{len(TOOLS_SCHEMA)}个工具\n")
        
    except ImportError:
        print("⚠️  mworks.sysplorer未安装")
    except Exception as e:
        print(f"❌ 加载失败：{e}")


# ========== HTTP处理 ==========
def send_json(handler, status, data):
    """发送JSON响应"""
    response = json.dumps(data, ensure_ascii=False).encode("utf-8")
    handler.send_response(status)
    handler.send_header("Content-Type", "application/json; charset=utf-8")
    handler.send_header("Access-Control-Allow-Origin", "*")
    handler.end_headers()
    handler.wfile.write(response)


def parse_stream_chunk(line):
    """解析SSE流"""
    if not line.startswith("data:"):
        return None, None, None
    
    data_str = line[5:].strip()
    if data_str == "[DONE]":
        return "DONE", None, None
    
    try:
        obj = json.loads(data_str)
        choice = obj.get("choices", [{}])[0]
        delta = choice.get("delta", {})
        finish_reason = choice.get("finish_reason")
        
        return finish_reason, delta.get("content"), delta.get("tool_calls")
    except:
        return None, None, None


class ChatHandler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        """禁用默认日志"""
        pass
    
    def do_OPTIONS(self):
        self.send_response(204)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, Authorization")
        self.send_header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
        self.end_headers()
    
    def do_GET(self):
        if self.path == "/health":
            send_json(self, 200, {"status": "ok", "pid": os.getpid()})
        elif self.path == "/config":
            # 检查环境变量中是否有API Key
            has_key = bool(os.getenv("TMP2_API_KEY"))
            send_json(self, 200, {"has_env_key": has_key})
        else:
            send_json(self, 404, {"error": "Not Found"})
    
    def do_POST(self):
        if self.path != "/chat":
            send_json(self, 404, {"error": "Not Found"})
            return
        
        # 解析请求
        content_length = int(self.headers.get("Content-Length", 0))
        body_str = self.rfile.read(content_length).decode("utf-8")
        try:
            body = json.loads(body_str)
        except json.JSONDecodeError:
            send_json(self, 400, {"error": "Invalid JSON body"})
            return
        
        # 优先从body中获取模型，处理可能为None的情况
        model = body.get("model")
        if not model:
            model = "qwen-plus"
            
        print(f"📝 当前请求使用模型: {model}")

        base_url = body.get("base_url", "https://copilot-dev.tongyuan.cc/api/openai/v1")
        api_key = body.get("api_key")
        
        # 打印原始请求信息，便于调试
        # print(f"📥 [调试] 客户端原始 Base URL: {base_url}")

        # 兼容性修复：gemini-3-pro 必须使用 Tongyuan API
        if model == "gemini-3-pro" and base_url and "dashscope" in base_url:
            print(f"⚠️ [自动修正] gemini-3-pro 不支持 DashScope，已自动切换至 Tongyuan API")
            base_url = "https://copilot-dev.tongyuan.cc/api/openai/v1"
            # 如果存在环境变量 Key，优先使用（因为前端传来的可能是 DashScope Key）
            if os.getenv("TMP2_API_KEY"):
                api_key = os.getenv("TMP2_API_KEY")
                print(f"⚠️ [自动修正] 使用环境变量 TMP2_API_KEY")

        if not api_key:
             api_key = os.getenv("TMP2_API_KEY")

        # Debug logging
        #masked_key = f"{api_key[:8]}...{api_key[-4:]}" if api_key and len(api_key) > 12 else "None"
        #print(f"🔗 Base URL: {base_url}")
        #print(f"🔑 API Key: {masked_key}")
        
        # 前端发送的是完整消息历史
        messages = body.get("messages", [])
        # 如果没有messages，尝试从message字段获取
        if not messages and body.get("message"):
            messages = [{"role": "user", "content": body.get("message")}]
        
        if not api_key:
            send_json(self, 400, {"error": "缺少API Key"})
            return
        
        # 注入系统提示词（如果不存在）
        has_system = any(m.get("role") == "system" for m in messages)
        if not has_system:
            system_prompt = """你是一个智能助手，当用户有明确建模需求时，你能够通过工具自动完成Sysplorer建模任务。

**核心规则：**
1. **语言匹配**：使用与用户相同的语言（中文问题→中文回答，英文问题→英文回答）
2. **必须执行工具**：当用户有建模需求时，不要只说"我将..."，必须实际调用工具
3. **建模流程**：
   a. sys_initialize() - 初始化连接
   b. ChangeDirectory(directory=r'路径') - 切换工作目录（如需要）
   c. NewModel(modelName='模型名', restriction='Sysblock') - 创建模型
   d. sys_search_component(keyword='关键词') - 搜索组件路径
   e. AddComponent(typeName='完整路径', modelName='模型名', name='实例名', x=10, y=10) - 先添加完所有的组件
   f. ConnectPort(modelName='模型名', leftPort='组件1.端口', rightPort='组件2.端口') - 组件添加完成之后再进行端口间的连线
   g. SaveModel(modelName='模型名') - 保存

**参数说明：**
- typeName: 组件完整库路径（通过sys_search_component获取）
- modelName: 模型名称
- name: 组件实例名
- x, y: 画布位置坐标

**示例：**
用户："创建一个PID控制器模型"
你应该执行：
1. sys_initialize()
2. NewModel(modelName='PIDModel', restriction='Sysblock')
3. sys_search_component(keyword='PID')
4. AddComponent(typeName='找到的路径', modelName='PIDModel', name='pid1', x=10, y=10) 组件相互位置紧凑，而不重叠，尽量位于视图中心
5. ConnectPort(modelName='PIDModel', leftPort='pid1.Output', rightPort='pid1.Setpoint')
6. GetComponentPorts(modelName='PIDModel', name='pid1') 连接失败时，要获取组件端口，查看端口名称是否正确
7. SaveModel(modelName='PIDModel')
"""
            messages.insert(0, {"role": "system", "content": system_prompt})
        
        # 开始流式响应（纯文本，不是SSE格式）
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Cache-Control", "no-cache")
        self.end_headers()
        
        # 自主循环
        max_turns = 20
        current_turn = 0
        
        while current_turn < max_turns:
            current_turn += 1
            print(f">>> current_turn: {current_turn}")
            
            # 准备LLM请求
            # 【强制限制格式】改为非流式调用 (stream=False)
            # 这样模型必须生成完整的、合法的 JSON 后才会返回，避免了流式传输中的碎片拼接错误
            # 同时也利用了 API 网关的 JSON 校验能力
            payload = {
                "model": model,
                "messages": messages,
                "stream": False,
                "tools": TOOLS_SCHEMA if TOOLS_SCHEMA else None
            }
            if not payload["tools"]:
                del payload["tools"]
            
            headers = {
                "Content-Type": "application/json",
                "Authorization": f"Bearer {api_key}",
                "X-APP-ID": "openai"  # Required for Gemini-3-Pro
            }
            
            try:
                req = Request(
                    f"{base_url}/chat/completions",
                    data=json.dumps(payload).encode("utf-8"),
                    headers=headers,
                    method="POST"
                )
                
                # 非流式处理
                full_content = ""
                tool_calls_list = []
                finish_reason = None
                
                with urlopen(req, timeout=120) as resp:
                    response_data = json.loads(resp.read().decode("utf-8"))
                    
                    # 解析响应
                    if "choices" in response_data and len(response_data["choices"]) > 0:
                        choice = response_data["choices"][0]
                        message = choice.get("message", {})
                        full_content = message.get("content") or ""
                        tool_calls_list = message.get("tool_calls") or []
                        finish_reason = choice.get("finish_reason")
                        
                        # 输出文本内容
                        if full_content:
                            self.wfile.write(full_content.encode("utf-8"))
                            self.wfile.flush()
                
                # 执行工具 (无需再拼接 buffer，直接使用完整的 tool_calls_list)
                if tool_calls_list:
                    
                    # 添加助手消息
                    messages.append({
                        "role": "assistant",
                        "content": full_content if full_content else None,
                        "tool_calls": tool_calls_list
                    })
                    
                    # 执行每个工具并显示过程
                    for tc in tool_calls_list:
                        func_name = tc["function"]["name"]
                        func_args_str = tc["function"]["arguments"]
                        call_id = tc["id"]
                        
                        # 显示工具调用信息
                        tool_info = f"\n\n🔧 **正在执行：** `{func_name}`\n"
                        self.wfile.write(tool_info.encode("utf-8"))
                        self.wfile.flush()
                        
                        # 解析参数
                        try:
                            loaded = json.loads(func_args_str)
                            if isinstance(loaded, dict):
                                func_args = loaded
                            elif isinstance(loaded, list):
                                if loaded:
                                    last = loaded[-1]
                                    if isinstance(last, dict):
                                        func_args = last
                                    elif func_name == "sys_search_component":
                                        func_args = {"keyword": str(last)}
                                    else:
                                        func_args = {}
                                else:
                                    func_args = {}
                            else:
                                func_args = {}
                            args_str = json.dumps(func_args, ensure_ascii=False, indent=2)
                            params_info = f"```json\n{args_str}\n```\n"
                            self.wfile.write(params_info.encode("utf-8"))
                            self.wfile.flush()
                        except:
                            # 如果参数不是合法的 JSON，可能是空字符串或解析失败
                            # 尝试修复空参数的情况
                            if not func_args_str.strip():
                                func_args = {}
                            else:
                                try:
                                    import re
                                    s = func_args_str.strip()
                                    repaired = None
                                    if "}{".find(s) != -1:
                                        pass
                                    # 组合为数组形式
                                    if "}{" in s or "} {" in s or "}\n{" in s:
                                        # 使用正则替换，兼容中间有空白字符的情况
                                        array_str = "[" + re.sub(r'}\s*{', '},{', s) + "]"
                                        try:
                                            arr = json.loads(array_str)
                                            if isinstance(arr, list) and arr:
                                                last = arr[-1]
                                                if isinstance(last, dict):
                                                    func_args = last
                                                elif func_name == "sys_search_component":
                                                    func_args = {"keyword": str(last)}
                                                else:
                                                    func_args = {}
                                                self.wfile.write(f"⚠️ 自动修复参数: {s} -> {json.dumps(func_args, ensure_ascii=False)}\n".encode("utf-8"))
                                                repaired = True
                                        except:
                                            repaired = None
                                    if not repaired:
                                        kw_matches = re.findall(r'"keyword"\\s*:\\s*"([^"]+)"', s)
                                        if kw_matches:
                                            func_args = {"keyword": kw_matches[-1]}
                                            self.wfile.write(f"⚠️ 自动修复参数: {s} -> {json.dumps(func_args, ensure_ascii=False)}\n".encode("utf-8"))
                                            repaired = True
                                    if not repaired:
                                        json_objects = re.findall(r'\\{.*?\\}', s)
                                        if json_objects:
                                            last_json = json_objects[-1]
                                            try:
                                                func_args = json.loads(last_json)
                                                self.wfile.write(f"⚠️ 自动修复参数: {s} -> {last_json}\n".encode("utf-8"))
                                                repaired = True
                                            except:
                                                repaired = None
                                    if not repaired:
                                        self.wfile.write(f"⚠️ 参数解析失败: {func_args_str}\n".encode("utf-8"))
                                        func_args = {}
                                except:
                                    self.wfile.write(f"⚠️ 参数解析失败: {func_args_str}\n".encode("utf-8"))
                                    func_args = {}

                        # 【关键修复】Gemini 有时会把参数放在 'arguments' 字段中，但有时会忘记传参
                        # 对于 sys_search_component 这种只有一个必需参数的工具，如果 args 为空，可能是因为 Gemini 没解析好
                        # 我们这里不做特殊 hack，因为这是模型行为问题，但我们需要确保程序不崩
                        
                        # 执行工具
                        result_content = ""
                        if func_name in TOOLS_MAP:
                            try:
                                func = TOOLS_MAP[func_name]
                                result = func(**func_args)
                                result_content = json.dumps(result, ensure_ascii=False) if not isinstance(result, str) else result
                            except Exception as e:
                                result_content = f"❌ 错误：{str(e)}"
                        else:
                            result_content = f"❌ 未找到工具：{func_name}"
                        
                        # 显示结果
                        result_info = f"**结果：** {result_content}\n"
                        self.wfile.write(result_info.encode("utf-8"))
                        self.wfile.flush()
                        
                        # 添加工具结果
                        messages.append({
                            "role": "tool",
                            "tool_call_id": call_id,
                            "name": func_name,
                            "content": result_content
                        })
                    
                    # 继续下一轮
                    continue
                
                else:
                    # 没有工具调用，结束
                    break
            
            except HTTPError as e:
                error = e.read().decode("utf-8")
                self.wfile.write(f"\n\n❌ **错误：** {error}".encode("utf-8"))
                break
            except Exception as e:
                self.wfile.write(f"\n\n❌ **错误：** {str(e)}".encode("utf-8"))
                break


# ========== 启动 ==========
if __name__ == "__main__":
    # 检查并终止已存在实例
    kill_existing_server(PORT)
    
    print("=" * 70)
    print("🤖 Sysplorer AI Copilot Server - Frontend Compatible")
    print("=" * 70)
    
    load_tools()
    
    print(f"🚀 服务器启动: http://{HOST}:{PORT}")
    print(f"💡 健康检查: http://{HOST}:{PORT}/health")
    print(f"📊 已加载工具: {len(TOOLS_SCHEMA)}个")
    print("=" * 70)
    print()
    
    server = ThreadingHTTPServer((HOST, PORT), ChatHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n\n⏹️  服务器已停止")
