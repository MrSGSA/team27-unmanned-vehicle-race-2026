#ifndef _RT_TASK_H_
#define _RT_TASK_H_

#ifdef _CGT_LINUX_
#include <stdbool.h>
#endif

#include "msg_define.h"
//##//
bool IsStart();

bool rtStopTask();
 
bool rtTaskInitialize(double par_stepSize,double par_stopTime, double par_comStepSize, const TMsgSimStart* tInfo);

void SetFlag(const bool bOpen);

void task_send_function(void* arg);

void SingleStep();

void SetModify(int _modify_size, int* _modify_index, double* _modify_value);

#ifdef _STM32_TCP_MODE_

void RtDataSendTask(void);

void RtPeriodicTask(void);
#endif

#endif
