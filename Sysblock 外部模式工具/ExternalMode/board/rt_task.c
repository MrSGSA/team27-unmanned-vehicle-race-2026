#include "rt_task.h"

#include <float.h>
#include <math.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "common_define.h"
#include "msg_define.h"
#include "server_control.h"
#include "set_timer.h"

#ifdef _SERIAL_MODE_
#include "server_serial.h"
#elif _RASP_MODE_
#include "server_socket.h"
#include <pthread.h>
#include <sys/mman.h>
#include <unistd.h>
pthread_t thread_id;

#elif  _STM32_MODE_
#include "stm32_server_serial.h"
#elif _STM32_TCP_MODE_
#include "stm32_server_tcp.h"
#endif

#ifdef _RUN_DEPLOY_
// DIY_GENERATE_NAME
#include "diy_gain.h"
#endif

#define GET_SZ_BOOL(type, dataIndex, sz)       \
type* pTemp = GetParamBool(dataIndex); \
indexI = 0; \
for (; indexI < sz.num; ++indexI) \
{ \
    sz.value[indexI] = pTemp[indexI] ? 1 : 0; \
}

#define GET_SZ_VALUE(func, type, dataIndex, sz)       \
type* pTemp = func(dataIndex); \
indexI = 0; \
for (; indexI < sz.num; ++indexI) \
{ \
    sz.value[indexI] = pTemp[indexI]; \
}


#ifdef _STM32_TCP_MODE_

#define RT_MAX_FLATTENED_VALUES 120 // 单步仿真最大数据量
#define RT_RING_BUFFER_SIZE 60      // 环形缓冲区的大小

// SimDataNode
typedef struct {
    double values[RT_MAX_FLATTENED_VALUES]; // 静态分配，存储压平后的所有数据
    long int stepIndex;                     // 步数/时间戳
} SimDataNode;

// 环形缓冲区
static volatile SimDataNode g_RingBuf[RT_RING_BUFFER_SIZE];
static volatile int g_Head = 0; // 写指针
static volatile int g_Tail = 0; // 读指针
static volatile long int g_DropCount = 0; // 丢包计数

// 在初始化时计算偏移量
// g_szDataOffset[i] 表示第 i 个变量在 values[] 数组中的起始索引，此处考虑维度，进行了转换
static int g_szDataOffset[DATAINDEX_MAX] = { 0 };

// 单步数据的实际总长度：每个变量对应的维度展开之和
static int g_totalDataCount = 0;


#endif

volatile bool g_bIsSend;  // 初始化完成，可以发送数据的标志
volatile bool g_bIsModify = false;


double startTime = 0.0;
double stopTime = 10;
double communicationStepLength = 0.00005;
double stepSize = 0.00005;

int g_szDataIndex[DATAINDEX_MAX] = { 0 };
int g_szDimNum[DATAINDEX_MAX] = { 0 };
int g_szType[DATAINDEX_MAX] = { 0 };
double g_szDataValue[DATAINDEX_MAX] = { 0 };

int g_modify_size = 0;
int g_modify_index[DATAINDEX_MAX] = { 0 };
double g_modify_value[DATAINDEX_MAX] = { 0 };

long int wStepIndex = 0;   // 表示仿真时间/步数：从0开始，每仿真一步自加一次
int g_wDataIndexSize = 0;
int g_pTimerHandler = -1;
static bool DoubleEqual(double n1, double n2, double tolerance)
{
    return fabs(n1 - n2) < tolerance + FLT_EPSILON;
}

bool IsStart()
{
    return g_bIsSend;
}

bool rtStopTask()
{
#ifdef _RASP_MODE_
    munlockall();
#endif
    {
        g_bIsSend = false;
        return true;
    }
}

void PrintLog2Client(const char* log, const int logLen)
{
    return;
    TMsgServerLog tInfo = { 0 };
    memcpy(tInfo.log, log, logLen);
    unsigned char ch[BUFFSIZE] = { 0 };
    const int sendLen = TServerLog2Data(&tInfo, ch, logLen);
    SendBodyMsg(ch, sendLen, NotifySimStepData);
}

void PrintInfo(const char* log, const int logLen)
{
    TMsgServerLog tInfo = { 0 };
    memcpy(tInfo.log, log, logLen);
    unsigned char ch[BUFFSIZE] = { 0 };
    const int sendLen = TServerLog2Data(&tInfo, ch, logLen);
    SendBodyMsg(ch, sendLen, NotifySimStepData);
}

void SetDataIndex(const TMsgSimStart* tInfo)
{
    if (!(0 < tInfo->wDataIndexSize && tInfo->wDataIndexSize < DATAINDEX_MAX))
    {
        return;
    }

    g_wDataIndexSize = tInfo->wDataIndexSize;
    memcpy(g_szDataIndex, tInfo->szDataIndex, GetTSimStartBody(tInfo));
    memcpy(g_szType, tInfo->wType, GetTSimStartBody(tInfo));
    memcpy(g_szDimNum, tInfo->wDimNum, GetTSimStartBody(tInfo));
}

void SetModify(int _modify_size, int* _modify_index, double* _modify_value)
{
    //PRINT_FUNC;

    if (_modify_size <= 0 || _modify_size > DATAINDEX_MAX || _modify_index == NULL || _modify_value == NULL)
    {
        //printf("[ERROR] SetModify: invalid params, size=%d\n", _modify_size);
        return;
    }

    g_modify_size = _modify_size;
    memcpy(g_modify_index, _modify_index, _modify_size * sizeof(int));
    memcpy(g_modify_value, _modify_value, _modify_size * sizeof(double));

    g_bIsModify = true;
}

void SetParam()
{
    //printf("---> Beginning modify value\n");

    if (g_modify_size < 1)
        return;

    int dataMapIndex = g_modify_index[0];
    MwbDouble val = g_modify_value[0];

    //printf("Modify dataMapIndex = %d, new value = %f\n", dataMapIndex, val);

    SetParamDouble(dataMapIndex, val);
}

void GetParam(const long int time)
{
    if (g_wDataIndexSize < 1)
    {
        return;
    }

#ifdef _RUN_DEPLOY_
    TMsgStepData tInfo;
    int index = 0;
    for (; index < g_wDataIndexSize; ++index)
    {
        tInfo.szDataValue[index].num = g_szDimNum[index] < 2 ? 1 : g_szDimNum[index];
        tInfo.szDataValue[index].value = (double*)malloc(sizeof(double) * tInfo.szDataValue[index].num);

        if (1 == tInfo.szDataValue[index].num)
        {
            switch (g_szType[index])
            {
            case emData_double:
                tInfo.szDataValue[index].value[0] = *GetParamDouble(g_szDataIndex[index]); break;
            case emData_float:
                tInfo.szDataValue[index].value[0] = *GetParamFloat(g_szDataIndex[index]); break;
            case emData_bool:
                tInfo.szDataValue[index].value[0] = (*GetParamBool(g_szDataIndex[index]) ? 1 : 0); break;
            case emData_u8int:
                tInfo.szDataValue[index].value[0] = *GetParamUInt8(g_szDataIndex[index]); break;
            case emData_8int:
                tInfo.szDataValue[index].value[0] = *GetParamInt8(g_szDataIndex[index]); break;
            case emData_u16int:
                tInfo.szDataValue[index].value[0] = *GetParamUInt16(g_szDataIndex[index]); break;
            case emData_16int:
                tInfo.szDataValue[index].value[0] = *GetParamInt16(g_szDataIndex[index]); break;
            case emData_u32int:
                tInfo.szDataValue[index].value[0] = *GetParamUInt32(g_szDataIndex[index]); break;
            case emData_32int:
                tInfo.szDataValue[index].value[0] = *GetParamInt32(g_szDataIndex[index]); break;
            case emData_u64int:
                tInfo.szDataValue[index].value[0] = *GetParamUInt64(g_szDataIndex[index]); break;
            case emData_64int:
                tInfo.szDataValue[index].value[0] = *GetParamInt64(g_szDataIndex[index]); break;
            default:
                tInfo.szDataValue[index].value[0] = *GetParamDouble(g_szDataIndex[index]); break;
            }
        }
        else
        {
            int indexI = 0;
            switch (g_szType[index])
            {
                case emData_double:
                {
                    GET_SZ_VALUE(GetParamDouble, MwbDouble, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_bool:
                {
                    GET_SZ_BOOL(MwbBool, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_float:
                {
                    GET_SZ_VALUE(GetParamFloat, MwbFloat, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_u8int:
                {
                    GET_SZ_VALUE(GetParamUInt8, MwbUInt8, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_8int:
                {
                    GET_SZ_VALUE(GetParamInt8, MwbInt8, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_u16int:
                {
                    GET_SZ_VALUE(GetParamUInt16, MwbUInt16, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_16int:
                {
                    GET_SZ_VALUE(GetParamInt16, MwbInt16, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_u32int:
                {
                    GET_SZ_VALUE(GetParamUInt32, MwbUInt32, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_32int:
                {
                    GET_SZ_VALUE(GetParamInt32, MwbInt32, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_u64int:
                {
                    GET_SZ_VALUE(GetParamUInt64, MwbUInt64, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                case emData_64int:
                {
                    GET_SZ_VALUE(GetParamInt64, MwbInt64, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
                default:
                {
                    GET_SZ_VALUE(GetParamDouble, MwbDouble, g_szDataIndex[index], tInfo.szDataValue[index]);
                    break;
                }
            }
        }
        //printf("index[%d]dataindex[%d]type[%d] %lf\n", index, g_szDataIndex[index], g_szType[index], tInfo.szDataValue[index].value[0]);
    }

    tInfo.dwTime = time;
    tInfo.wDataIndexSize = g_wDataIndexSize;

    unsigned char ch[BUFFSIZE] = { 0 };
    const int len = TStepData2Data(&tInfo, ch);
    SendBodyMsg(ch, len, NotifySimStepData);

    //printf(" len:%d \n", len);
    TStepDataFreeMem(&tInfo);
#endif
}

void* thread_task(void* arg)
{
    printf("thread_task start! \n");
    while (g_bIsSend)
    {
        SingleStep();
    }

    printf("thread_task end \n");
#ifdef _RUN_DEPLOY_
    Terminate();
#endif

    return NULL;
}

void SingleStep()
{
    #ifdef _SERIAL_MODE_
    uint64_t start_ns = get_time_ns();

    #endif

    //PrintLog2Client("SingleStep Start \n", sizeof("SingleStep Start \n"));
#ifdef _RUN_DEPLOY_
    if (g_bIsModify)
    {
        SetParam();
        g_bIsModify = false;
    }

    Step();
#endif
    GetParam(wStepIndex);
    ++wStepIndex;

    //PrintLog2Client("SingleStep End \n", sizeof("SingleStep End \n"));

    #ifdef _SERIAL_MODE_
    uint64_t realStep = get_time_ns()-start_ns;
    if(realStep > stepSize*1000000000.0)
    {
        //printf("Warning: step over time! realStep=%llu ns, stepSize=%lf s\n", realStep, stepSize);
        char buff[128];
        int len = snprintf(buff, sizeof(buff), "timeout, current step: %ld, step time: %" PRIu64 "\n", realStep, stepSize);
        PrintInfo(buff, len);
    }
    #endif

    mwSleep(stepSize);
}


#ifdef _STM32_TCP_MODE_
// STM32 H750 不再调用SingleStep，实时仿真和TCP发送数据将解耦：中断内进行实时仿真，主函内发送仿真数据

static void RecalculateOffsets(void)
{
    int current_offset = 0;
    g_totalDataCount = 0;

    for (int i = 0; i < g_wDataIndexSize; i++)
    {
        // 当前变量在数组 values[] 中的起始位置
        g_szDataOffset[i] = current_offset;

        // 获取维度 
        int dim = g_szDimNum[i] < 1 ? 1 : g_szDimNum[i];
        

        current_offset += dim;

        // 如果总数据量超过静态数组 RT_MAX_FLATTENED_VALUES，停止解析
        if (current_offset > RT_MAX_FLATTENED_VALUES)
        {
            current_offset = RT_MAX_FLATTENED_VALUES; // 长度超出时要强制截断，保护内存
            break; 
        }
    }
    g_totalDataCount = current_offset;
}


/* 单步仿真后将数据写入环形缓冲区的一个对应节点中 */
static void CaptureDataToBuffer(volatile SimDataNode* node)
{
    int flat_index = 0;

    for (int i = 0; i < g_wDataIndexSize; ++i)
    {
        // 如果数据总量已经达到上限，停止写入，防止越界
        if (flat_index >= g_totalDataCount) break;

        int dimNum = g_szDimNum[i] < 1 ? 1 : g_szDimNum[i];

        // 循环读取每一维的数据
        for (int dim = 0; dim < dimNum; ++dim)
        {
            if (flat_index >= RT_MAX_FLATTENED_VALUES) return;

            // 存储仿真数据
            switch (g_szType[i])
            {
                case emData_double: node->values[flat_index] = GetParamDouble(g_szDataIndex[i])[dim]; break;
                case emData_float:  node->values[flat_index] = (double)GetParamFloat(g_szDataIndex[i])[dim]; break;
                case emData_bool:   node->values[flat_index] = (GetParamBool(g_szDataIndex[i])[dim] ? 1.0 : 0.0); break;
                case emData_u8int:  node->values[flat_index] = (double)GetParamUInt8(g_szDataIndex[i])[dim]; break;
                case emData_8int:   node->values[flat_index] = (double)GetParamInt8(g_szDataIndex[i])[dim]; break;
                case emData_u16int: node->values[flat_index] = (double)GetParamUInt16(g_szDataIndex[i])[dim]; break;
                case emData_16int:  node->values[flat_index] = (double)GetParamInt16(g_szDataIndex[i])[dim]; break;
                case emData_u32int: node->values[flat_index] = (double)GetParamUInt32(g_szDataIndex[i])[dim]; break;
                case emData_32int:  node->values[flat_index] = (double)GetParamInt32(g_szDataIndex[i])[dim]; break;
                case emData_u64int: node->values[flat_index] = (double)GetParamUInt64(g_szDataIndex[i])[dim]; break;
                case emData_64int:  node->values[flat_index] = (double)GetParamInt64(g_szDataIndex[i])[dim]; break;
                default:            node->values[flat_index] = GetParamDouble(g_szDataIndex[i])[dim]; break;
            }
            flat_index++;
        }
    }
}


/**
 *  硬中断周期性任务，在硬件定时器中断中调用
 *  调参 -> 仿真步进 -> 数据缓存
 */
void RtPeriodicTask(void)
{
    if (!g_bIsSend) return;

    // 1. 调参
    if (g_bIsModify)
    {
        SetParam();
        g_bIsModify = false;
    }

    // 2. 仿真
    Step(); 

    // 3. 数据写入环形缓冲区
    int nextHead = (g_Head + 1) % RT_RING_BUFFER_SIZE;
    if (nextHead != g_Tail) 
    {
        CaptureDataToBuffer(&g_RingBuf[g_Head]);
        g_RingBuf[g_Head].stepIndex = wStepIndex;
        g_Head = nextHead;
    }
    else 
    {
        // 如果缓冲区满了，直接丢掉
        g_DropCount++;
    }

    wStepIndex++;
}


/**
 * TCP发送数据：在主循环中调用
 *    从 RingBuffer 取数据 -> 封包 -> 发送
 */
void RtDataSendTask(void)
{
    if (!g_bIsSend) return;
	
	int processLimit = 100;

    while (g_Tail != g_Head && processLimit > 0)
    {
        TMsgStepData tInfo;
        tInfo.wDataIndexSize = g_wDataIndexSize;
        tInfo.dwTime = g_RingBuf[g_Tail].stepIndex;

        // 1. 构造指针数组
        for (int i = 0; i < g_wDataIndexSize; i++)
        {
			// szDataValue 大小为100，避免越界
			if(i > 100) break;
			
			tInfo.szDataValue[i].num = g_szDimNum[i] < 2 ? 1 : g_szDimNum[i];
			// 设置 value 指针指向 RingBuffer 的内存地址
            tInfo.szDataValue[i].value = (double*)&g_RingBuf[g_Tail].values[g_szDataOffset[i]];
        }

        // 2. 序列化数据
        unsigned char ch[BUFFSIZE] = { 0 };
        const int len = TStepData2Data(&tInfo, ch); 
        
        // 3. 发送
		bool sendRes = false;
        if (len > 0) {
            sendRes = SendBodyMsg(ch, len, NotifySimStepData);
        }
		
		if(sendRes)
		{
			// 更新指针
			g_Tail = (g_Tail + 1) % RT_RING_BUFFER_SIZE;
			--processLimit;
		}
		else
		{
			return;
		}
   
    }
}


#endif

bool rtTaskInitialize(double par_stepSize, double par_stopTime, double par_comStepSize, const TMsgSimStart* tInfo)
{
    communicationStepLength = par_comStepSize;
    stopTime = par_stopTime;
    stepSize = par_stepSize;
	
	if (DoubleEqual(stepSize, 0, 0))
    {
        stepSize = 0.02;
    }
	
	printf("solver parameters: %lf, %lf, %lf, %d \n", communicationStepLength, stopTime, stepSize, tInfo->wDataIndexSize);
	
	g_wDataIndexSize = 0;
    SetDataIndex(tInfo);

#ifdef _RASP_MODE_
    InitTimer(stepSize);
#elif defined(_SERIAL_MODE_)
    ResetStepTimer();
#elif defined(_STM32_TCP_MODE_)
	// 初始化 Ring Buffer 指针
    g_Head = 0;
    g_Tail = 0;
    g_DropCount = 0;
    // 计算偏移量，避免中断中每次重复计算，提高效率
    RecalculateOffsets();
	
#endif
    
    Init();
    CodeGenerate_init();

    wStepIndex = 0;
	g_bIsSend = true;
	
#if defined(_SERIAL_MODE_) || defined(_STM32_MODE_)
    SingleStep();
#elif defined(_STM32_TCP_MODE_)
	// 移除这里仿真动作，所有仿真位于硬中断tim3中
	//SingleStep();
#elif defined(_RASP_MODE_)
    mlockall(MCL_CURRENT | MCL_FUTURE);
    pthread_t thread_id = 0;
    if (0 != pthread_create(&thread_id, NULL, thread_task, &stepSize))
    {
        printf("[ERROR] Failed to create thread \n");
        return false;
    }
#endif
    return true;
}
