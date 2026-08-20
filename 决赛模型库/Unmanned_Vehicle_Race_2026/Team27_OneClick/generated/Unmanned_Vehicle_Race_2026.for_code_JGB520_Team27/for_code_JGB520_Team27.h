/********************************************************************************
 * Copyright (C) 2005-2026, Suzhou Tongyuan Software&Control Technology Co.,Ltd.
 * All rights reserved.
 * 版权所有 (C) 2005-2026， 苏州同元软控技术股份有限公司
 * 保留所有权利。
 *
 * 该文件由MWORKS内核代码生成器自动生成。
 *
 * 文件名称: for_code_JGB520_Team27.h
 * 生成时间: 2026-08-20 19:54:27
 *
********************************************************************************/

#ifndef FOR_CODE_JGB520_TEAM27_H
#define FOR_CODE_JGB520_TEAM27_H

#ifndef a_TEAM27_COMMON_INCLUDES_
#define a_TEAM27_COMMON_INCLUDES_
#include "mwb_types.h"
#include "math.h"
#endif /* a_TEAM27_COMMON_INCLUDES_ */

#include "mb_capi.h"

#define FOR_CODE_JGB520_TEAM27_IN_RUN (1U)

#include <wiringPi.h>
#include <wiringSerial.h>
#include <softPwm.h>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

extern int fd;
typedef struct for_code_jgb520_team27TagEmd for_code_jgb520_team27Emd;

#include <wiringPi.h>
#include <wiringSerial.h>
#include <softPwm.h>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

extern int fd;
struct for_code_jgb520_team27TagEmd{
  MwbDouble m_curTime;
  MwbDouble m_startTime;
  MwbDouble m_stepSize;
  MwbInt32 m_timeTickCount;
  struct {
    Mwb_CAPI_ModelMappingInfo mmi;
  } DataMapInfo;
};

/* External outputs (root outport signals) */
extern struct for_code_jgb520_team27ExtY for_code_jgb520_team27GbOut;

/* Block signals */
extern struct for_code_jgb520_team27B for_code_jgb520_team27GbB;

/* Block states */
extern struct for_code_jgb520_team27Dw for_code_jgb520_team27GbDw;

extern for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd;

void Step(void);
void Init(void);
void motor_send_cmd(int id, double speed, int time_ms);
void Terminate();


#endif /* FOR_CODE_JGB520_TEAM27_H */

/********************************************************************************
** end of file
********************************************************************************/
