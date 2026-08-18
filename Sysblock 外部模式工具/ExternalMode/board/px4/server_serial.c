#include "server_serial.h"

#include <stdio.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include "server_control.h"
#include "MW_SVD.h"
#include "MW_SCI.h"
#include "MW_PX4_SCI.h"
#include "rtwtypes.h"
#include <string.h>
#include <pthread.h>
#include "rt_task.h"

#if defined(__GNUC__) || defined(__clang__)
#define FUNC_NAME __PRETTY_FUNCTION__
#elif defined(_MSC_VER)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
#define FUNC_NAME __FUNCTION__
#else
#define FUNC_NAME __func__
#endif

#define PRINT_FUNC              printf("Recive: [%s] \n", FUNC_NAME)

bool g_isRunning = false;
bool g_isLoop = false;
MW_Handle_Type g_pSerialHandle = NULL;

bool Send(const unsigned char* data, const int bodyLen)
{
    return MW_SCI_Transmit(g_pSerialHandle, (unsigned char*)data, bodyLen) == MW_SCI_SUCCESS;
}

void Connected(void)
{
    PRINT_FUNC;
    g_isRunning = true;
}

void Disconnected(void)
{
    PRINT_FUNC;
    GetGlobalControlPtr()->Stop(GetGlobalControlPtr());
}

bool InitSerial()
{
    g_pSerialHandle = MW_SCI_Open((void*)"/dev/ttyACM0", 1, 0, 0);
    if (g_pSerialHandle == (MW_Handle_Type)NULL)
    {
        printf("Error opening serial port!\n");
        return -1;
    }

    // 2. 配置波特率 (57600)
    if (MW_SCI_SetBaudrate(g_pSerialHandle, 57600) != MW_SCI_SUCCESS)
    {
        printf("Error setting baudrate!\n");
        MW_SCI_Close(g_pSerialHandle);
        return -1;
    }

    // 3. 设置帧格式 (8数据位, 无校验, 1停止位)
    if (MW_SCI_SetFrameFormat(g_pSerialHandle, 8, MW_SCI_PARITY_NONE, MW_SCI_STOPBITS_1) != MW_SCI_SUCCESS)
    {
        printf("Error setting frame format!\n");
        MW_SCI_Close(g_pSerialHandle);
        return -1;
    }

    // 4. 配置硬件流控 (无流控)
    if (MW_SCI_ConfigureHardwareFlowControl(g_pSerialHandle,
        MW_SCI_FLOWCONTROL_NONE,
        0, 0) != MW_SCI_SUCCESS)
    {
        printf("Error configuring hardware flow control!\n");
        MW_SCI_Close(g_pSerialHandle);
        return -1;
    }
    return true;
}


void StartListen(void)
{
    if (!IsOpen() || IsRunning())
    {
        return;
    }

    Connected();
    unsigned char buffer[BUFFSIZE] = { 0 };
    while (g_isRunning)
    {
        memset(buffer, 0, BUFFSIZE);
        if (IsStart())
        {
            SingleStep();
        }

        if (MW_SCI_SUCCESS == MW_SCI_Receive(g_pSerialHandle, buffer, BUFFSIZE))
        {
            LoopRecvMsg(buffer, BUFFSIZE);
        }
    }
    GetGlobalControlPtr()->Stop(GetGlobalControlPtr());
}

bool IsOpen(void)
{
    return (int)(g_pSerialHandle) > 0;
}

bool IsRunning(void)
{
    return g_isRunning;
}
