let currentBuffer = "";
let currentMsgDiv = null;
let isKeyConfigured = false;
let currentAbortController = null;
let pendingText = "";
let typingTimer = null;
let streamEnded = false;
let receivedBuffer = "";
let chatHistory = [];
const MAX_CONTEXT_MESSAGES = 50; // 增加上下文保留数量，避免丢失工具执行历史

// ... 弹窗与设置逻辑 (保持不变) ...
function showSettings() { document.getElementById('settings-modal').style.display = 'flex'; }
function hideSettings() { document.getElementById('settings-modal').style.display = 'none'; }
function saveSettings() {
    const url = document.getElementById('api-url').value.trim();
    const key = document.getElementById('api-key').value.trim();
    if (key.length > 0) isKeyConfigured = true; else isKeyConfigured = false;
    localStorage.setItem('api-url', url);
    localStorage.setItem('api-key', key);
    hideSettings();
}
function checkSend(event) { if (event.ctrlKey && event.key === 'Enter') { event.preventDefault(); send(); } }
// ... 下拉菜单逻辑 (保持不变) ...
function toggleSelect(id) {
    document.querySelectorAll('.select-options').forEach(el => { if (el.parentElement.id !== id) el.classList.remove('show'); });
    document.querySelector(`#${id} .select-options`).classList.toggle('show');
}
function selectOption(selectId, value) {
    document.querySelector(`#${selectId} .trigger-text`).innerText = value;
    document.querySelectorAll(`#${selectId} li`).forEach(li => {
        li.classList.remove('selected');
        if(li.innerText === value) li.classList.add('selected');
    });
    document.getElementById(selectId).setAttribute('data-value', value);
    document.querySelector(`#${selectId} .select-options`).classList.remove('show');
    event.stopPropagation();
}
document.addEventListener('click', function(e) {
    if (!e.target.closest('.custom-select')) { document.querySelectorAll('.select-options').forEach(el => el.classList.remove('show')); }
});

// --- 主逻辑 ---
window.onload = function() {
    selectOption('mode-select', 'Ask');
    selectOption('model-select', 'gemini-3-pro');
    const savedUrl = localStorage.getItem('api-url');
    const savedKey = localStorage.getItem('api-key');
    if (savedUrl) document.getElementById('api-url').value = savedUrl;
    if (savedKey) document.getElementById('api-key').value = savedKey;
    isKeyConfigured = !!savedKey;

    if (typeof marked !== 'undefined') {
        marked.setOptions({
            renderer: new marked.Renderer(),
            highlight: function(code, lang) {
                const language = hljs.getLanguage(lang) ? lang : 'plaintext';
                return hljs.highlight(code, { language }).value;
            },
            langPrefix: 'hljs language-',
            pedantic: false, gfm: true, breaks: true, sanitize: false, smartLists: true, smartypants: false, xhtml: false
        });
    }

    document.getElementById('file-badge').style.display = 'none';
}

function handleInput(textarea) {
    const btn = document.querySelector('.send-btn');
    if (textarea.value.length > 0) btn.classList.add('active'); else btn.classList.remove('active');
    textarea.style.height = 'auto'; textarea.style.height = (textarea.scrollHeight) + 'px';
}

function createMsgDiv(role) {
    let box = document.getElementById('chat-box');
    let row = document.createElement('div'); row.className = 'msg-row ' + role;
    let avatar = document.createElement('div'); avatar.className = 'avatar';
    if (role === 'bot') avatar.innerHTML = `<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="10" rx="2"></rect><circle cx="12" cy="5" r="2"></circle><path d="M12 7v4"></path><line x1="8" y1="16" x2="8" y2="16"></line><line x1="16" y1="16" x2="16" y2="16"></line></svg>`;
    else avatar.innerHTML = `<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>`;
    let bubble = document.createElement('div'); bubble.className = 'msg-bubble';
    if (role === 'bot') { row.appendChild(avatar); row.appendChild(bubble); }
    else { row.appendChild(bubble); row.appendChild(avatar); }
    box.appendChild(row);
    if (role === 'bot') currentMsgDiv = bubble;
    return bubble;
}

function scrollToBottom() { let box = document.getElementById('chat-box'); box.scrollTop = box.scrollHeight; }

function send() {
    let inp = document.getElementById('inp'); let text = inp.value.trim();
    if(!text) return;
    const baseUrl = document.getElementById('api-url').value.trim();
    let apiKey = document.getElementById('api-key').value.trim();
    if (!baseUrl) { showSettings(); return; }
    if (!apiKey) {
        fetch('http://127.0.0.1:8000/config')
            .then(resp => resp.ok ? resp.json() : null)
            .then(data => {
                if (!data || !data.has_env_key) { showSettings(); return; }
                doSend(text, baseUrl, "");
            })
            .catch(() => { showSettings(); });
        return;
    }
    isKeyConfigured = true;
    doSend(text, baseUrl, apiKey);
}

function doSend(text, baseUrl, apiKey) {
    let inp = document.getElementById('inp');

    // 1. 切换按钮状态：隐藏 Send，显示 Stop
    document.getElementById('send-btn').style.display = 'none';
    document.getElementById('stop-btn').style.display = 'flex';

    let userBubble = createMsgDiv('user');
    userBubble.innerText = text;
    
    inp.value = ''; handleInput(inp); scrollToBottom();
    let model = document.getElementById('model-select').getAttribute('data-value') || 'DeepSeek';
    let mode = document.getElementById('mode-select').getAttribute('data-value') || 'Debug';
    currentBuffer = "";
    currentMsgDiv = null;
    pendingText = "";
    receivedBuffer = "";
    streamEnded = false;
    currentAbortController = new AbortController();
    
    // 实现滑动窗口：仅发送最近的 N 条消息作为上下文
    const contextMessages = chatHistory.slice(-MAX_CONTEXT_MESSAGES);
    // 确保包含当前用户的消息
    contextMessages.push({role: 'user', content: text});
    
    // 【关键修复】立即将用户消息加入历史记录，确保下一轮对话时历史完整
    chatHistory.push({role: 'user', content: text});

    streamChat({
        messages: contextMessages,
        message: text,
        model: model,
        mode: mode,
        baseUrl: baseUrl,
        apiKey: apiKey
    }, currentAbortController.signal);
}

// 【新增】停止生成逻辑
function stopGeneration() {
    if (currentAbortController) currentAbortController.abort();
    pendingText = "";
    receivedBuffer = "";
    streamEnded = true;
    if (typingTimer) { clearInterval(typingTimer); typingTimer = null; }
    completeFinalize();
}

function addFile() { document.getElementById('file-input').click(); }
function clearChat() { 
    document.getElementById('chat-box').innerHTML = '<div id="empty-state" class="empty-state"></div>'; 
    chatHistory = [];
}

// 【新增】监听文件选择
document.getElementById('file-input').addEventListener('change', function(e) {
    if (e.target.files.length > 0) {
        document.getElementById('file-badge').style.display = 'block';
    }
});

async function streamChat(payload, signal) {
    try {
        const response = await fetch('http://127.0.0.1:8000/chat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                messages: payload.messages, // Send full history
                message: payload.message,   // Keep for fallback
                model: payload.model,
                base_url: payload.baseUrl,
                api_key: payload.apiKey,
                stream: true
            }),
            signal
        });
        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(errorText || `HTTP ${response.status}`);
        }
        const reader = response.body.getReader();
        const decoder = new TextDecoder('utf-8');
        while (true) {
            const { value, done } = await reader.read();
            if (done) break;
            const chunk = decoder.decode(value, { stream: true });
            appendStreamChunk(chunk);
        }
    } catch (e) {
        if (e.name !== 'AbortError') alert(e.message || e);
    } finally {
        finalizeStream();
    }
}

function appendStreamChunk(text) {
    if (!text) return;
    if (text.startsWith(receivedBuffer)) {
        const diff = text.slice(receivedBuffer.length);
        receivedBuffer = text;
        enqueueText(diff);
        return;
    }
    if (receivedBuffer && receivedBuffer.startsWith(text)) return;
    receivedBuffer += text;
    enqueueText(text);
}

function finalizeStream() {
    streamEnded = true;
    if (!typingTimer && pendingText.length === 0) completeFinalize();
}

function enqueueText(text) {
    if (!text) return;
    pendingText += text;
    if (!typingTimer) startTyping();
}

function startTyping() {
    typingTimer = setInterval(() => {
        if (!pendingText.length) {
            clearInterval(typingTimer);
            typingTimer = null;
            if (streamEnded) completeFinalize();
            return;
        }
        const step = pendingText.slice(0, 3);
        pendingText = pendingText.slice(3);
        if (!currentMsgDiv) createMsgDiv('bot');
        currentBuffer += step;
        if (typeof marked === 'undefined') currentMsgDiv.innerText = currentBuffer;
        else currentMsgDiv.innerHTML = marked.parse(currentBuffer);
        scrollToBottom();
    }, 20);
}

function completeFinalize() {
    document.getElementById('stop-btn').style.display = 'none';
    document.getElementById('send-btn').style.display = 'flex';
    if(currentMsgDiv && typeof hljs !== 'undefined') {
        currentMsgDiv.querySelectorAll('pre code').forEach((block) => hljs.highlightElement(block));
    }
    
    // 【修正】这里不再需要复杂的补全逻辑，因为在 doSend 时已经加入了 User 消息
    // 这里只需要加入 Assistant 的回复
    
    if (receivedBuffer) {
        chatHistory.push({role: 'assistant', content: receivedBuffer});
    }
    currentBuffer = "";
    currentMsgDiv = null;
    currentAbortController = null;
}
