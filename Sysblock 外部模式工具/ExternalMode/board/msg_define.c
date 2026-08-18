#include "msg_define.h"

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#ifdef _CGT_LINUX_
#include "server_control.h"
#else
#include "clientControl.h"
#endif


#ifdef _SERIAL_MODE_
#include "server_serial.h"
#elif _RASP_MODE_
#include "server_socket.h"
#elif _STM32_MODE_
#include "stm32_server_serial.h"
#elif _STM32_TCP_MODE_
#include "stm32_server_tcp.h"
#endif

int TStepData2Data(TMsgStepData* tInfo, unsigned char* p)
{
    int count = 0;
    memcpy(p + count, &(tInfo->dwTime), sizeof(int));
    count += sizeof(int);
    memcpy(p + count, &(tInfo->wDataIndexSize), sizeof(int));
    count += sizeof(int);
    int index = 0;
    for (index = 0; index < (tInfo->wDataIndexSize); ++index)
    {
        memcpy(p + count, &(tInfo->szDataValue[index].num), sizeof(int));
        count += sizeof(int);
        memcpy(p + count, (tInfo->szDataValue[index].value), sizeof(double) * (tInfo->szDataValue[index].num));
        count += sizeof(double) * (tInfo->szDataValue[index].num);
    }

    return count;
}

int Parse2TStepData(TMsgStepData* tInfo, const unsigned char* p, int count)
{
    if (count < 8)
    {
        return -1;
    }

    int len = 0;
    memcpy(&(tInfo->dwTime), p + len, sizeof(int));
    len += sizeof(int);
    memcpy(&(tInfo->wDataIndexSize), p + len, sizeof(int));
    len += sizeof(int);

    int index = 0;
    for (index = 0; index < (tInfo->wDataIndexSize); ++index)
    {
        if (count < len + sizeof(int))
        {
            return -1;
        }

        memcpy(&(tInfo->szDataValue[index].num), p + len,sizeof(int));
        len += sizeof(int);

        if (count < len + sizeof(double) * (tInfo->szDataValue[index].num))
        {
            return -1;
        }

        tInfo->szDataValue[index].value = (double*)malloc(sizeof(double) * (tInfo->szDataValue[index].num));
        memcpy(tInfo->szDataValue[index].value, p + len, sizeof(double) * (tInfo->szDataValue[index].num));
        len = len + sizeof(double) * (tInfo->szDataValue[index].num);
    }

    return len;
}

void TStepDataFreeMem(TMsgStepData* tInfo)
{
    if (tInfo->wDataIndexSize < 1)
    {
        return;
    }

    int index = 0;
    for (index = 0; index < tInfo->wDataIndexSize; ++index)
    {
        free((void *)tInfo->szDataValue[index].value);
    }
}

int GetTStepDataHeader()
{
    return sizeof(int) + sizeof(int);
}

int GetTSimStartBody(const TMsgSimStart* tInfo)
{
    return sizeof(int) * tInfo->wDataIndexSize * 3;
}

int TSimStart2Data(TMsgSimStart* tInfo, unsigned char* p)
{
    int count = 0;
    memcpy(p + count, &(tInfo->dwStepSize), sizeof(double));
    count += sizeof(double);
    memcpy(p + count, &(tInfo->wDataIndexSize), sizeof(int));
    count += sizeof(int);
    if (tInfo->wDataIndexSize > 0)
    {
        memcpy(p + count, &(tInfo->szDataIndex), tInfo->wDataIndexSize * sizeof(int));
        count += tInfo->wDataIndexSize * sizeof(int);
        memcpy(p + count, &(tInfo->wType), tInfo->wDataIndexSize * sizeof(int));
        count += tInfo->wDataIndexSize * sizeof(int);
        memcpy(p + count, &(tInfo->wDimNum), tInfo->wDataIndexSize * sizeof(int));
        count += tInfo->wDataIndexSize * sizeof(int);
    }

    return count;
}

void Parse2TSimStart(TMsgSimStart* tInfo, const unsigned char* p)
{
    memcpy(&(tInfo->dwStepSize), p, sizeof(double));
    p = p + sizeof(double);
    memcpy(&(tInfo->wDataIndexSize), p, sizeof(int));
    p = p + sizeof(int);
    if (tInfo->wDataIndexSize > 0)
    {
        memcpy(&(tInfo->szDataIndex), p, tInfo->wDataIndexSize * sizeof(int));
        p = p + tInfo->wDataIndexSize * sizeof(int);
        memcpy(&(tInfo->wType), p, tInfo->wDataIndexSize * sizeof(int));
        p = p + tInfo->wDataIndexSize * sizeof(int);
        memcpy(&(tInfo->wDimNum), p, tInfo->wDataIndexSize * sizeof(int));
    }
}

int GetTSimStartHeader()
{
    return sizeof(double) + sizeof(int);
}

int TServerLog2Data(TMsgServerLog* tInfo, unsigned char* p, int bodyLen)
{
    memcpy(p, &(tInfo->len), sizeof(int));
    const int count = sizeof(int);

    if (tInfo->len > BUFFSIZE || tInfo->len > bodyLen)
    {
        return 0;
    }

    memcpy(p + count, &(tInfo->len), count);

    return tInfo->len + count;
}

int Parse2TServerLog(TMsgServerLog* tInfo, const unsigned char* p, int count)
{
    memcpy(&(tInfo->len), p, sizeof(int));
    p = p + sizeof(int);

    if (tInfo->len > count - sizeof(int))
    {
        return -1;
    }
    memcpy(&(tInfo->log), p, tInfo->len);

    return count + tInfo->len;
}

int PackageHeader(unsigned char* data, const int emType, const int emDetailType, const int bodyLen)
{
    TMsgHeader msgHeader = { 0 };
    msgHeader.emMsgtype = emType;
    msgHeader.emMsgDetaiType = emDetailType;
    msgHeader.BodyLen = bodyLen;

    const int len = sizeof(TMsgHeader);
    memcpy(data, &msgHeader, len);

    return len;
}

void AddBody(unsigned char* data, const int count, void* body, const int bodyLen)
{
    memcpy(data + count, body, bodyLen);
}

int ParseMsg(const unsigned char* data, const int bodyLen)
{
    if (bodyLen < sizeof(TMsgHeader))
    {
        return -1;
    }

    const int headerLen = sizeof(TMsgHeader);
    TMsgHeader tHeader;
    memcpy(&tHeader, data, headerLen);

    // 包头校验 --PackageHeader
    if (tHeader.emMsgtype > emRtMsgEnd || 0 != tHeader.emMsgDetaiType)
    {
        return 1;
    }

#ifdef _CGT_LINUX_
    const int wLen = GetGlobalControlPtr()->MessageDispatch(GetGlobalControlPtr(), &tHeader, data + headerLen, bodyLen - headerLen);
#else
    const int wLen = ClientControlBase::MessageDispatch(&tHeader, data + headerLen, bodyLen - headerLen);
#endif
    if (wLen < 0)
    {
        return -1;
    }

    return headerLen + wLen;
}

bool LoopRecvMsg(const unsigned char* data, const int bodyLen)
{
    int wPos = 0;
    const unsigned char* p = data;
    while (true)
    {
        if (wPos + sizeof(TMsgHeader) > bodyLen)
        {
            return wPos == bodyLen;
        }

        const int wRet = ParseMsg(data + wPos, bodyLen - wPos);
        if (wRet < 0)
        {
            break;
        }

        wPos += wRet;
    }

    return true;
}

bool ParseBigMsg(const unsigned char* data, const int bodyLen, int* position, long int* msgLen)
{
    if (bodyLen < sizeof(TMsgHeader))
    {
        *position = 0;
        *msgLen = sizeof(TMsgHeader);
        return false;
    }

    const int wHeaderLen = sizeof(TMsgHeader);
    TMsgHeader tHeader;
    memcpy(&tHeader, data, wHeaderLen);

    // 包头校验 --PackageHeader
    if (tHeader.emMsgtype <= emRtMsgInit || tHeader.emMsgtype > emRtMsgEnd || 0 != tHeader.emMsgDetaiType
        || (tHeader.emMsgtype != NotifySimStepData && tHeader.BodyLen > BUFFSIZE))  // 仅仿真数据可能超过最大长度
    {
        *position = 1; // 指针前移
        return true;
    }

    // 长度校验
    if (tHeader.BodyLen > bodyLen - wHeaderLen)
    {
        *position = 0;
        *msgLen = tHeader.BodyLen + wHeaderLen;
        return false;
    }

#ifdef _CGT_LINUX_
    const int wLen = GetGlobalControlPtr()->MessageDispatch(GetGlobalControlPtr(), &tHeader, data + wHeaderLen, bodyLen - wHeaderLen);
#else
    const int wLen = ClientControlBase::MessageDispatch(&tHeader, data + wHeaderLen, bodyLen - wHeaderLen);
#endif
    if (wLen < 0)
    {
        *position = wHeaderLen;
        return true;
    }
    
    *position = tHeader.BodyLen + wHeaderLen;
    return true;
}

bool LoopRecvBigMsg(const unsigned char* data, const int bodyLen, int* position, long int* msgLen)
{
    int wPos = 0;
    const unsigned char* p = data;
    while (true)
    {
        if (wPos + sizeof(TMsgHeader) > bodyLen)
        {
            *position = wPos;
            return wPos == bodyLen;
        }

        if (!ParseBigMsg(data + wPos, bodyLen - wPos, position, msgLen))
        {
            return false;
        }

        wPos += *position;
    }

    return true;
}

