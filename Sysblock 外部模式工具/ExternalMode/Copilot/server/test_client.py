"""
测试客户端 - 用于测试Sysplorer AI Copilot Server
"""

import json
import requests
import os

# 配置
SERVER_URL = "http://127.0.0.1:8000"
API_KEY = os.getenv("DASHSCOPE_API_KEY", "your_api_key_here")

def test_health():
    """测试健康检查"""
    print("=" * 60)
    print("测试1: 健康检查")
    print("=" * 60)
    
    response = requests.get(f"{SERVER_URL}/health")
    print(f"状态码: {response.status_code}")
    print(f"响应: {response.json()}")
    print()

def test_chat(message):
    """测试对话"""
    print("=" * 60)
    print(f"测试对话: {message}")
    print("=" * 60)
    
    payload = {
        "model": "qwen-plus",
        "base_url": "https://dashscope.aliyuncs.com/compatible-mode/v1",
        "api_key": API_KEY,
        "messages": [
            {"role": "user", "content": message}
        ]
    }
    
    response = requests.post(
        f"{SERVER_URL}/chat",
        json=payload,
        stream=True
    )
    
    print("响应流:")
    print("-" * 60)
    for line in response.iter_content(chunk_size=None, decode_unicode=True):
        if line:
            print(line, end='', flush=True)
    print()
    print("-" * 60)
    print()

def main():
    """主测试流程"""
    print("\n🚀 Sysplorer AI Copilot 测试客户端\n")
    
    # 1. 健康检查
    try:
        test_health()
    except Exception as e:
        print(f"❌ 健康检查失败: {e}")
        print("请确保服务器已启动！")
        return
    
    # 2. 测试基本对话
    test_chat("你好，请介绍一下你自己")
    
    # 3. 测试建模任务
    print("\n" + "=" * 60)
    print("开始建模测试...")
    print("=" * 60)
    print()
    
    # 示例1：简单模型
    test_chat("创建一个名为TestModel的模型，添加一个Constant组件")
    
    # 示例2：搜索组件
    test_chat("帮我查找PID控制器的库路径")
    
    # 示例3：完整流程（需要Sysplorer运行）
    test_chat("""
    请帮我创建一个PID控制系统模型：
    1. 模型名称：PID_Control
    2. 包含：一个Constant输入、一个PID控制器、一个Gain
    3. 保存模型
    """)

if __name__ == "__main__":
    main()
