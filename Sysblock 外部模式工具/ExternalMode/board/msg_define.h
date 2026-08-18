#ifndef _MSG_DEFINE_H_
#define _MSG_DEFINE_H_

#ifdef _CGT_LINUX_
#include <stdbool.h>
#endif

#pragma pack(push, 1)

// 走配置项
#define DIY_GENERATE_NAME       "diy_gain"

#define IP_ADDR_RT              "192.168.0.7"
#define RT_SOCKET_PORT          8887

#ifdef _RASP_MODE_
#define BUFFSIZE                (4096)
#elif defined(_STM32_TCP_MODE_)
#define BUFFSIZE                (512)
#else
#define BUFFSIZE                (1024)
#endif

#define MAGINE_DEFINE_USER      "ty"
#define MAGINE_DEFINE_PSWD      "admin123"

#define BUFFSIZE_STRUCT 512

#define TASK_ID_SIM         0
#define TASK_ID_SEND        1

#define VEC_BUFF_TO_DATA(p, len, vec, count, type) \
    if (len > 0 && !vec.empty()) \
    { \
        memcpy(p + count, vec.data(), len * sizeof(type)); \
        count += len * sizeof(type); \
    }

#define VEC_BUFF_PARSE_DATA(p, count, vec, type) \
    if (count > 0) \
    { \
        vec.resize(count); \
        memcpy(vec.data(), p, count * sizeof(type)); \
        p += count * sizeof(type); \
    }

enum emDataTypeDef
{
    emData_double = 0,
    emData_float,
    emData_bool,
    emData_u8int,
    emData_8int,
    emData_u16int,
    emData_16int,
    emData_u32int,
    emData_32int,
    emData_u64int,
    emData_64int,
    emData_end,
};

enum emRtMsgDefine
{
    // Ui消息定义---------------------
    emRtMsgInit = 100,

    // 连接
    ReqConnect,
    RspConnect,

    ReqDisconnect,
    RspDisconnect,

    // 翻译
    ReqTranslation,             // ui->server
    RspTranslation,             // server->ui

    // 编译
    ReqCompiler,                // char[] !!
    RspCompiler,                //

    // 部署
    ReqDeploy,                  // char[] !!
    RspDeploy,                  // 

    // 仿真
    ReqSimulation,              // TSimulationInfo !!
    RspSimulation,

    ReqPause,                   //!!
    RspPause,

    //继续
    ReqResume,                  //!!
    RspResume,

    ReqStop,                    //!!
    RspStop,

	ReqTerminate,               //终止

	ReqStepForward,
	RspStepForward,

    ReqSetNotifyVariables,
    RspSetNotifyVariables,

    ReqSetNotifyParams,         // TSetNotifyInputINFO !!
    RspSetNotifyParams,

    ReqSetNotifyInput,          // TNotifyResultINFO  !!
    RspSetNotifyInput,

    //驱动消息定义------------    -----------------------------------
    ReqGetDeviceTree = 200,     // TStr
    RspGetDeviceTree,           // TStr2
    NotifyQuit,
    // 服务器通知-----------------------------------------------
    emRtMsgDetailSplit = 1000,

    NotifyResult,
    NotifySimStepData,
    NotifySimStep,              // Server通知Client实际仿真步长
    NotifyPrtMsg,

    // 客户端通知-----------------------------------------------  
    emRtMsgDetailSplit2 = 2000,
    NotifyModifyParams,

    NotifyRealsVal,
    NotifyInterVal,
    NotifyBoolenVal,

    NotifyModelName,

    emRtMsgEnd,
};

typedef struct tagMsgHeader
{
    int emMsgtype;
    int emMsgDetaiType;

    // 可添加验证字段 暂不启用
    unsigned int BodyLen;
}TMsgHeader;

typedef struct tDimNumData
{
    int num;
    double* value;
}TDimNumData;

typedef struct tStepData
{
    int dwTime;
    int wDataIndexSize;
    TDimNumData szDataValue[100];

}TMsgStepData;

typedef struct tagServerLog
{
    int len;
    char log[BUFFSIZE];
}TMsgServerLog;

typedef struct tagSimStart
{
    double dwStepSize;
    int wDataIndexSize;
    int szDataIndex[100];
    int wType[100];         // 数据类型  // 0 - double 1 - int  2- bool
    int wDimNum[100];       // 维度
}TMsgSimStart;

#pragma pack(pop) // 恢复之前的对齐设置

// ** TMsgStepData 
int TStepData2Data(TMsgStepData* tInfo, unsigned char* p);
int Parse2TStepData(TMsgStepData* tInfo, const unsigned char* p, int count);
void TStepDataFreeMem(TMsgStepData* tInfo);
int GetTStepDataHeader();
// ** end;

// ** TMsgSimStart
int GetTSimStartBody(const TMsgSimStart* tInfo);
int TSimStart2Data(TMsgSimStart* tInfo, unsigned char* p);
void Parse2TSimStart(TMsgSimStart* tInfo, const unsigned char* p);
int GetTSimStartHeader();
// ** end;

// ** TMsgServerLog
int TServerLog2Data(TMsgServerLog* tInfo, unsigned char* p, int bodyLen);
int Parse2TServerLog(TMsgServerLog* tInfo, const unsigned char* p, int count);
// ** end;


// msgDeal
int PackageHeader(unsigned char* data, const int emType, const int emDetailType, const int bodyLen);
void AddBody(unsigned char* data, const int count, void* body, const int bodyLen);
int ParseMsg(const unsigned char* data, const int bodyLen);
bool LoopRecvMsg(const unsigned char* data, const int bodyLen);

bool ParseBigMsg(const unsigned char* data, const int bodyLen, int* position, long int* msgLen);
bool LoopRecvBigMsg(const unsigned char* data, const int bodyLen, int* position, long int* msgLen);

#endif
