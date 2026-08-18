#include "server_socket.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include "server_control.h"

#if defined(__GNUC__) || defined(__clang__)
#define FUNC_NAME __PRETTY_FUNCTION__
#elif defined(_MSC_VER)                       
#define FUNC_NAME __FUNCTION__
#else
#define FUNC_NAME __func__
#endif

#define PRINT_FUNC              printf("Recive: [%s] \n", FUNC_NAME)

int g_serverSocket = 0;
int g_solverSocket = 0;
bool m_isRunning = false;

bool Send(const unsigned char* data, const int bodyLen)
{
    if (g_solverSocket)
    {
        send(g_solverSocket, data, bodyLen, 0); // 回显数据
        return true;
    }

    return false;
}

bool IsConnect()
{
    return g_solverSocket > 0;
}

void Connected()
{
    PRINT_FUNC;
    m_isRunning = true;
}

void Disconnected()
{
    PRINT_FUNC;
    GetGlobalControlPtr()->Stop(GetGlobalControlPtr());
    m_isRunning = false;
}

bool InitSocket()
{
    struct sockaddr_in clientAddr = { 0 };

    clientAddr.sin_family = AF_INET;
    clientAddr.sin_addr.s_addr = INADDR_ANY;
    clientAddr.sin_port = htons(RT_SOCKET_PORT);

    if ((g_serverSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_IP)) == 0)
    {
        perror("Socket creation failed");
        return false;
    }

    // 设置端口地址能够被立刻重新绑定，避免 Address already in use 导致绑定失败
    const int opt = 1;
    setsockopt(g_serverSocket, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    while(bind(g_serverSocket, (struct sockaddr*)(&clientAddr), sizeof(clientAddr)) < 0) {}

    // 监听连接
    printf("bind success: %d", RT_SOCKET_PORT);
    if (listen(g_serverSocket, 3) < 0)
    {
        perror("Listen failed");
        return false;
    }

    return true;
}

void StartListen()
{
    if (!g_serverSocket)
    {
        return;
    }

    // 重复执行
    if (m_isRunning)
    {
        return;
    }

    m_isRunning = true;

    unsigned char buffer[BUFFSIZE] = { 0 };
    struct linger linger_opt;
    linger_opt.l_onoff = 1;
    linger_opt.l_linger = 0; // 立即关闭

    // 设置服务器地址结构
    struct sockaddr_in cli_addr = { 0 };
    cli_addr.sin_family = AF_INET;
    cli_addr.sin_port = htons(RT_SOCKET_PORT);
    int cli_len = sizeof(cli_addr);
    while (true)
    {
        if (!m_isRunning)
        {
            break;
        }

        if (g_solverSocket <= 0)
        {
            setsockopt(g_solverSocket, SOL_SOCKET, SO_REUSEADDR, (const char*)(&linger_opt), sizeof(linger_opt));
            g_solverSocket = accept(g_serverSocket, (struct sockaddr*)&cli_addr, (socklen_t*)&cli_len);
            // 接受并处理客户端连接
            printf("client socket: %d \n", g_solverSocket);
            if (g_solverSocket <= 0)
            {
                perror("Accept failed");
                sleep(1);
                continue;
            }
        }

        memset(buffer, 0, BUFFSIZE);
        const int bytesReceived = recv(g_solverSocket, buffer, BUFFSIZE, 0);
        buffer[bytesReceived] = '\0'; // 添加字符串结束符

        if (bytesReceived > 0)
        {
            LoopRecvMsg(buffer, bytesReceived);
        }
        else
        {
            g_solverSocket = 0;
        }
    }
    if (g_serverSocket)
    {
        close(g_serverSocket);
        g_serverSocket = 0;
    }

    if (g_solverSocket)
    {
        close(g_solverSocket);
        g_solverSocket = 0;
    }
}

