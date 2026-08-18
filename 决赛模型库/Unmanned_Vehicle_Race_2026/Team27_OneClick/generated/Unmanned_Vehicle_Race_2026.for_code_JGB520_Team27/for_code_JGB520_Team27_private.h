/********************************************************************************
 * Copyright (C) 2005-2026, Suzhou Tongyuan Software&Control Technology Co.,Ltd.
 * All rights reserved.
 * 版权所有 (C) 2005-2026， 苏州同元软控技术股份有限公司
 * 保留所有权利。
 *
 * 该文件由MWORKS内核代码生成器自动生成。
 *
 * 文件名称: for_code_JGB520_Team27_private.h
 * 生成时间: 2026-08-12 20:35:14
 *
********************************************************************************/

#ifndef aPRIVATE_H
#define aPRIVATE_H

#include "for_code_JGB520_Team27.h"

#include <wiringPi.h>
#include <wiringSerial.h>
#include <softPwm.h>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

extern int fd;
struct Obsavoidcontroller_team27_fflf2
{
  MwbDouble sensor1;
  MwbDouble sensor2;
  MwbDouble sensor3;
  MwbDouble sensor4;
  MwbDouble sensor5;
  MwbDouble speed;
  MwbDouble steer;
};

struct Obsavoidcontroller_team27_fflf3
{
  MwbDouble front;
  MwbDouble unused;
  MwbDouble rightFront;
  MwbDouble leftFront;
  MwbDouble rear;
};

struct for_code_jgb520_team27B
{
  MwbDouble sensor1_distence;
  MwbDouble sensor2_distence;
  MwbDouble sensor3_distence;
  MwbDouble sensor4_distence;
  MwbDouble sensor5_distence;
  MwbDouble y;
  MwbDouble y_c;
  MwbDouble y_f;
  MwbDouble y_i;
  MwbDouble y_l;
  MwbDouble speed;
  MwbDouble steer;
  MwbDouble y_o;
  MwbDouble y_s;
  MwbDouble y_v;
  MwbInt32 y_ca;
  MwbInt32 y_ea;
  MwbInt32 y_ga;
  MwbInt32 y_ia;
  MwbDouble y_ka;
  struct Obsavoidcontroller_team27_fflf2 subSystem;
};

struct for_code_jgb520_team27Dw
{
  MwbDouble src;
  MwbDouble src_a;
  MwbDouble u;
  MwbDouble k;
  MwbDouble u_b;
  MwbDouble k_d;
  MwbDouble u_e;
  MwbDouble k_g;
  MwbDouble u_h;
  MwbDouble k_j;
  MwbDouble u_k;
  MwbDouble k_m;
  MwbDouble sensor1;
  MwbDouble sensor2;
  MwbDouble sensor3;
  MwbDouble sensor4;
  MwbDouble sensor5;
  MwbDouble u_n;
  MwbDouble k_p;
  MwbDouble src_q;
  MwbDouble u_r;
  MwbDouble k_t;
  MwbInt32 id;
  MwbDouble speed;
  MwbInt32 time_ms;
  MwbDouble u_u;
  MwbDouble k_w;
  MwbInt32 id_x;
  MwbDouble speed_y;
  MwbInt32 time_ms_aa;
  MwbInt32 k_ba;
  MwbInt32 k_da;
  MwbInt32 k_fa;
  MwbInt32 k_ha;
  MwbDouble k_ja;
  struct Obsavoidcontroller_team27_fflf3 subSystem;
};


void Obsavoidcontroller_team27_fflf7(MwbDouble sensor1, MwbDouble sensor2, MwbDouble sensor3, MwbDouble sensor4, MwbDouble sensor5, 
  MwbDouble* speed, MwbDouble* steer, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct Obsavoidcontroller_team27_fflf2* 
  localB, struct Obsavoidcontroller_team27_fflf3* localDw);
void Terminate();


#endif /* aPRIVATE_H */

/********************************************************************************
** end of file
********************************************************************************/
