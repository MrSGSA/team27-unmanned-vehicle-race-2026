/********************************************************************************
 * Copyright (C) 2005-2026, Suzhou Tongyuan Software&Control Technology Co.,Ltd.
 * All rights reserved.
 * 版权所有 (C) 2005-2026， 苏州同元软控技术股份有限公司
 * 保留所有权利。
 *
 * 该文件由MWORKS内核代码生成器自动生成。
 *
 * 文件名称: for_code_JGB520_Team27.h
 * 生成时间: 2026-08-12 20:35:14
 *
********************************************************************************/

#ifndef FOR_CODE_JGB520_TEAM27_H
#define FOR_CODE_JGB520_TEAM27_H

#ifndef aTEAM27_COMMON_INCLUDES_
#define aTEAM27_COMMON_INCLUDES_
#include "mwb_types.h"
#include "math.h"
#endif /* aTEAM27_COMMON_INCLUDES_ */

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
};

/* Block signals */
extern struct for_code_jgb520_team27B for_code_jgb520_team27GbB;

/* Block states */
extern struct for_code_jgb520_team27Dw for_code_jgb520_team27GbDw;

extern for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd;

void Step(void);
void Init(void);
void Terminate();


#endif /* FOR_CODE_JGB520_TEAM27_H */

/********************************************************************************
** end of file
********************************************************************************/
