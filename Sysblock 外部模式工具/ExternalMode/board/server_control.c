/******************************************************
///
/// Copyright (c) 2022-  ,苏州同元软控信息技术有限公司
/// All rights reserved
///
/// @file			rt_sim_control.cpp
/// @brief			仿真控制/仿真信息
///
/// @version		v0.1
/// @author
/// @data
*******************************************************/

// #include <boost/thread.hpp>
#include "server_control.h"

#include "common_define.h"
#include "msg_define.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "rt_task.h"

#ifdef _SERIAL_MODE_
#include "server_serial.h"
#elif _RASP_MODE_  
#include "server_socket.h"
#elif _STM32_MODE_
#include "stm32_server_serial.h"
#elif _STM32_TCP_MODE_
#include "stm32_server_tcp.h"
#endif


CServerControl* g_pControl = NULL;
void Init_impl(CServerControl* ptr)
{
    ptr->m_bStartSimulation = false;
}

int Start_impl(CServerControl* ptr, const unsigned char* data, const int len)
{
    PRINT_FUNC;
    TMsgSimStart tInfo = { 0 };
    Parse2TSimStart(&tInfo, data);
    
    printf("Start: recv %d, actually %d", len, GetTSimStartHeader() + GetTSimStartBody(&tInfo));

	SendMsg(RspSimulation);
    rtTaskInitialize(tInfo.dwStepSize, 0, 0, &tInfo);
    
    return GetTSimStartHeader() + GetTSimStartBody(&tInfo);
}

bool Pause_impl(CServerControl* ptr)
{
    PRINT_FUNC;

    SendMsg(RspPause);
    ptr->m_bPauseFlag = true;

    return true;
}

bool Resume_impl(CServerControl* ptr)
{
    PRINT_FUNC;

    SendMsg(RspResume);
    ptr->m_bPauseFlag = false;
    return true;
}

bool Stop_impl(CServerControl* ptr)
{
    PRINT_FUNC;

    SendMsg(RspStop);
    rtStopTask();
    return true;
}

void Disconnect_impl(CServerControl* ptr)
{
    PRINT_FUNC;
    Disconnected();

    return;
}

bool ModifyParams_impl(CServerControl* ptr, const unsigned char* data, const int len)
{
    PRINT_FUNC;

    TMsgSimStart tInfo = { 0 };
    Parse2TSimStart(&tInfo, data);
    //printf("ModifyParams: recv %d, actually %d", len, GetTSimStartHeader() + GetTSimStartBody(&tInfo));

    int size = tInfo.wDataIndexSize;
    int* modify_index = tInfo.szDataIndex;
    double modify_value[1] = { tInfo.dwStepSize };

    SetModify(size, modify_index, modify_value);

    return true;
}

bool SendMsg(const int emType)
{
    unsigned char buffer[BUFFSIZE] = { 0 };
    const int wLen = PackageHeader(buffer, emType, 0, 0);

    return Send(buffer, wLen);
}

bool SendBodyMsg(void* body, const int bodyLen, const int emType)
{
    unsigned char buffer[BUFFSIZE] = { 0 };
    const int wLen = PackageHeader(buffer, emType, 0, bodyLen);
    AddBody(buffer, wLen, body, bodyLen);

    return Send(buffer, wLen + bodyLen);
}

int MessageDispatch(CServerControl* ptr, const TMsgHeader* tHeader, const unsigned char* body, int bodyLen)
{
    if (!ptr)
    {
        return 0;
    }

    //printf("Recv %d, bodyLen: %d \n", tHeader->emMsgtype, bodyLen);
    switch (tHeader->emMsgtype)
    {
        case ReqConnect:
            SendMsg(RspConnect);
            break;
        case RspDisconnect:
            ptr->Disconnect(ptr);
            break;
        case ReqSimulation:
            return ptr->Start(ptr, body, bodyLen);
        case ReqPause:
            ptr->Pause(ptr);
            break;
        case ReqResume:
            ptr->Resume(ptr);
            break;
        case ReqStop:
            ptr->Stop(ptr);
            break;
        case NotifyQuit:
            ptr->Disconnect(ptr);
            break;
        case NotifyModifyParams:
            ptr->ModifyParams(ptr, body, bodyLen);
            break;
        default:
            break;
    }

    return 0;
}

CServerControl* CreateControlFunc()
{
    g_pControl = (CServerControl*)malloc(sizeof(CServerControl));
    g_pControl->m_bPauseFlag = false;
    g_pControl->m_bStartSimulation = false;
    g_pControl->Init = Init_impl;
    g_pControl->Pause = Pause_impl;
    g_pControl->Disconnect = Disconnect_impl;
    g_pControl->Resume = Resume_impl;
    g_pControl->Start = Start_impl;
    g_pControl->Stop = Stop_impl;
    g_pControl->MessageDispatch = MessageDispatch;
    g_pControl->ModifyParams = ModifyParams_impl;

    return g_pControl;
}

CServerControl* GetGlobalControlPtr()
{
    return g_pControl;
}
