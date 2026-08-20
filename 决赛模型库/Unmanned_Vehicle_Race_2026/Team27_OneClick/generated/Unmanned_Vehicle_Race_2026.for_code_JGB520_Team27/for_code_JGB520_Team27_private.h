/********************************************************************************
 * Copyright (C) 2005-2026, Suzhou Tongyuan Software&Control Technology Co.,Ltd.
 * All rights reserved.
 * 版权所有 (C) 2005-2026， 苏州同元软控技术股份有限公司
 * 保留所有权利。
 *
 * 该文件由MWORKS内核代码生成器自动生成。
 *
 * 文件名称: for_code_JGB520_Team27_private.h
 * 生成时间: 2026-08-20 14:01:17
 *
********************************************************************************/

#ifndef a_PRIVATE_H
#define a_PRIVATE_H

#include "for_code_JGB520_Team27.h"

#include <wiringPi.h>
#include <wiringSerial.h>
#include <softPwm.h>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

extern int fd;
struct for_code_jgb520_team27FilterfcB
{
  MwbDouble raw;
  MwbDouble y;
  MwbDouble y_a;
  MwbDouble y_c;
  MwbDouble y_e;
  MwbDouble y_g;
  MwbDouble y_i;
  MwbDouble y_k;
  MwbDouble y_m;
  MwbBool y_n;
  MwbBool y_q;
  MwbDouble y_r;
  MwbDouble y_u;
  MwbBool y_ba;
  MwbDouble y_da;
  MwbDouble y_ea;
  MwbDouble y_ga;
  MwbDouble y_ka;
  MwbDouble y_pa;
  MwbDouble y_ra;
  MwbDouble y_wa;
  MwbBool y_bb;
  MwbDouble y_fb;
  MwbDouble y_ib;
};

struct FilterfcDw
{
  MwbDouble k;
  MwbDouble k_b;
  MwbDouble k_d;
  MwbDouble k_f;
  MwbDouble k_h;
  MwbDouble k_j;
  MwbDouble k_l;
  MwbDouble u1;
  MwbDouble u2;
  MwbDouble u1_o;
  MwbDouble u2_p;
  MwbDouble u1_s;
  MwbBool u2_t;
  MwbDouble u3;
  MwbDouble u1_v;
  MwbBool u2_w;
  MwbDouble u3_x;
  MwbDouble u1_y;
  MwbDouble u2_aa;
  MwbDouble initCond;
  MwbDouble u1_ca;
  MwbDouble unitDelayBuffer;
  MwbDouble yb;
  MwbDouble u;
  MwbDouble k_fa;
  MwbDouble u1_ha;
  MwbBool u2_ia;
  MwbDouble u3_ja;
  MwbDouble u1_la;
  MwbBool u2_ma;
  MwbDouble u3_na;
  MwbDouble u_oa;
  MwbDouble k_qa;
  MwbDouble u1_sa;
  MwbDouble u2_ta;
  MwbDouble initCond_ua;
  MwbDouble u1_va;
  MwbDouble unitDelayBuffer_xa;
  MwbDouble yb_ya;
  MwbDouble u1_za;
  MwbDouble u2_ab;
  MwbDouble u1_cb;
  MwbBool u2_db;
  MwbDouble u3_eb;
  MwbDouble u1_gb;
  MwbDouble u2_hb;
  MwbDouble u1_jb;
  MwbBool u2_kb;
  MwbDouble u3_lb;
};

struct for_code_jgb520_team27FilterflB
{
  MwbDouble raw;
  MwbDouble y;
  MwbDouble y_a;
  MwbDouble y_c;
  MwbDouble y_e;
  MwbDouble y_g;
  MwbDouble y_i;
  MwbDouble y_k;
  MwbDouble y_m;
  MwbBool y_n;
  MwbBool y_q;
  MwbDouble y_r;
  MwbDouble y_u;
  MwbBool y_ba;
  MwbDouble y_da;
  MwbDouble y_ea;
  MwbDouble y_ga;
  MwbDouble y_ka;
  MwbDouble y_pa;
  MwbDouble y_ra;
  MwbDouble y_wa;
  MwbBool y_bb;
  MwbDouble y_fb;
  MwbDouble y_ib;
};

struct aFilterflDw
{
  MwbDouble k;
  MwbDouble k_b;
  MwbDouble k_d;
  MwbDouble k_f;
  MwbDouble k_h;
  MwbDouble k_j;
  MwbDouble k_l;
  MwbDouble u1;
  MwbDouble u2;
  MwbDouble u1_o;
  MwbDouble u2_p;
  MwbDouble u1_s;
  MwbBool u2_t;
  MwbDouble u3;
  MwbDouble u1_v;
  MwbBool u2_w;
  MwbDouble u3_x;
  MwbDouble u1_y;
  MwbDouble u2_aa;
  MwbDouble initCond;
  MwbDouble u1_ca;
  MwbDouble unitDelayBuffer;
  MwbDouble yb;
  MwbDouble u;
  MwbDouble k_fa;
  MwbDouble u1_ha;
  MwbBool u2_ia;
  MwbDouble u3_ja;
  MwbDouble u1_la;
  MwbBool u2_ma;
  MwbDouble u3_na;
  MwbDouble u_oa;
  MwbDouble k_qa;
  MwbDouble u1_sa;
  MwbDouble u2_ta;
  MwbDouble initCond_ua;
  MwbDouble u1_va;
  MwbDouble unitDelayBuffer_xa;
  MwbDouble yb_ya;
  MwbDouble u1_za;
  MwbDouble u2_ab;
  MwbDouble u1_cb;
  MwbBool u2_db;
  MwbDouble u3_eb;
  MwbDouble u1_gb;
  MwbDouble u2_hb;
  MwbDouble u1_jb;
  MwbBool u2_kb;
  MwbDouble u3_lb;
};

struct for_code_jgb520_team27FilterfrB
{
  MwbDouble raw;
  MwbDouble y;
  MwbDouble y_a;
  MwbDouble y_c;
  MwbDouble y_e;
  MwbDouble y_g;
  MwbDouble y_i;
  MwbDouble y_k;
  MwbDouble y_m;
  MwbBool y_n;
  MwbBool y_q;
  MwbDouble y_r;
  MwbDouble y_u;
  MwbBool y_ba;
  MwbDouble y_da;
  MwbDouble y_ea;
  MwbDouble y_ga;
  MwbDouble y_ka;
  MwbDouble y_pa;
  MwbDouble y_ra;
  MwbDouble y_wa;
  MwbBool y_bb;
  MwbDouble y_fb;
  MwbDouble y_ib;
};

struct aFilterfrDw
{
  MwbDouble k;
  MwbDouble k_b;
  MwbDouble k_d;
  MwbDouble k_f;
  MwbDouble k_h;
  MwbDouble k_j;
  MwbDouble k_l;
  MwbDouble u1;
  MwbDouble u2;
  MwbDouble u1_o;
  MwbDouble u2_p;
  MwbDouble u1_s;
  MwbBool u2_t;
  MwbDouble u3;
  MwbDouble u1_v;
  MwbBool u2_w;
  MwbDouble u3_x;
  MwbDouble u1_y;
  MwbDouble u2_aa;
  MwbDouble initCond;
  MwbDouble u1_ca;
  MwbDouble unitDelayBuffer;
  MwbDouble yb;
  MwbDouble u;
  MwbDouble k_fa;
  MwbDouble u1_ha;
  MwbBool u2_ia;
  MwbDouble u3_ja;
  MwbDouble u1_la;
  MwbBool u2_ma;
  MwbDouble u3_na;
  MwbDouble u_oa;
  MwbDouble k_qa;
  MwbDouble u1_sa;
  MwbDouble u2_ta;
  MwbDouble initCond_ua;
  MwbDouble u1_va;
  MwbDouble unitDelayBuffer_xa;
  MwbDouble yb_ya;
  MwbDouble u1_za;
  MwbDouble u2_ab;
  MwbDouble u1_cb;
  MwbBool u2_db;
  MwbDouble u3_eb;
  MwbDouble u1_gb;
  MwbDouble u2_hb;
  MwbDouble u1_jb;
  MwbBool u2_kb;
  MwbDouble u3_lb;
};

struct for_code_jgb520_team27FilterslB
{
  MwbDouble raw;
  MwbDouble y;
  MwbDouble y_a;
  MwbDouble y_c;
  MwbDouble y_e;
  MwbDouble y_g;
  MwbDouble y_i;
  MwbDouble y_k;
  MwbDouble y_m;
  MwbBool y_n;
  MwbBool y_q;
  MwbDouble y_r;
  MwbDouble y_u;
  MwbBool y_ba;
  MwbDouble y_da;
  MwbDouble y_ea;
  MwbDouble y_ga;
  MwbDouble y_ka;
  MwbDouble y_pa;
  MwbDouble y_ra;
  MwbDouble y_wa;
  MwbBool y_bb;
  MwbDouble y_fb;
  MwbDouble y_ib;
};

struct aFilterslDw
{
  MwbDouble k;
  MwbDouble k_b;
  MwbDouble k_d;
  MwbDouble k_f;
  MwbDouble k_h;
  MwbDouble k_j;
  MwbDouble k_l;
  MwbDouble u1;
  MwbDouble u2;
  MwbDouble u1_o;
  MwbDouble u2_p;
  MwbDouble u1_s;
  MwbBool u2_t;
  MwbDouble u3;
  MwbDouble u1_v;
  MwbBool u2_w;
  MwbDouble u3_x;
  MwbDouble u1_y;
  MwbDouble u2_aa;
  MwbDouble initCond;
  MwbDouble u1_ca;
  MwbDouble unitDelayBuffer;
  MwbDouble yb;
  MwbDouble u;
  MwbDouble k_fa;
  MwbDouble u1_ha;
  MwbBool u2_ia;
  MwbDouble u3_ja;
  MwbDouble u1_la;
  MwbBool u2_ma;
  MwbDouble u3_na;
  MwbDouble u_oa;
  MwbDouble k_qa;
  MwbDouble u1_sa;
  MwbDouble u2_ta;
  MwbDouble initCond_ua;
  MwbDouble u1_va;
  MwbDouble unitDelayBuffer_xa;
  MwbDouble yb_ya;
  MwbDouble u1_za;
  MwbDouble u2_ab;
  MwbDouble u1_cb;
  MwbBool u2_db;
  MwbDouble u3_eb;
  MwbDouble u1_gb;
  MwbDouble u2_hb;
  MwbDouble u1_jb;
  MwbBool u2_kb;
  MwbDouble u3_lb;
};

struct for_code_jgb520_team27FiltersrB
{
  MwbDouble raw;
  MwbDouble y;
  MwbDouble y_a;
  MwbDouble y_c;
  MwbDouble y_e;
  MwbDouble y_g;
  MwbDouble y_i;
  MwbDouble y_k;
  MwbDouble y_m;
  MwbBool y_n;
  MwbBool y_q;
  MwbDouble y_r;
  MwbDouble y_u;
  MwbBool y_ba;
  MwbDouble y_da;
  MwbDouble y_ea;
  MwbDouble y_ga;
  MwbDouble y_ka;
  MwbDouble y_pa;
  MwbDouble y_ra;
  MwbDouble y_wa;
  MwbBool y_bb;
  MwbDouble y_fb;
  MwbDouble y_ib;
};

struct aFiltersrDw
{
  MwbDouble k;
  MwbDouble k_b;
  MwbDouble k_d;
  MwbDouble k_f;
  MwbDouble k_h;
  MwbDouble k_j;
  MwbDouble k_l;
  MwbDouble u1;
  MwbDouble u2;
  MwbDouble u1_o;
  MwbDouble u2_p;
  MwbDouble u1_s;
  MwbBool u2_t;
  MwbDouble u3;
  MwbDouble u1_v;
  MwbBool u2_w;
  MwbDouble u3_x;
  MwbDouble u1_y;
  MwbDouble u2_aa;
  MwbDouble initCond;
  MwbDouble u1_ca;
  MwbDouble unitDelayBuffer;
  MwbDouble yb;
  MwbDouble u;
  MwbDouble k_fa;
  MwbDouble u1_ha;
  MwbBool u2_ia;
  MwbDouble u3_ja;
  MwbDouble u1_la;
  MwbBool u2_ma;
  MwbDouble u3_na;
  MwbDouble u_oa;
  MwbDouble k_qa;
  MwbDouble u1_sa;
  MwbDouble u2_ta;
  MwbDouble initCond_ua;
  MwbDouble u1_va;
  MwbDouble unitDelayBuffer_xa;
  MwbDouble yb_ya;
  MwbDouble u1_za;
  MwbDouble u2_ab;
  MwbDouble u1_cb;
  MwbBool u2_db;
  MwbDouble u3_eb;
  MwbDouble u1_gb;
  MwbDouble u2_hb;
  MwbDouble u1_jb;
  MwbBool u2_kb;
  MwbDouble u3_lb;
};

struct for_code_jgb520_team27ChartB
{
  MwbDouble fc;
  MwbDouble fcRaw;
  MwbDouble fl;
  MwbDouble fr;
  MwbDouble sl;
  MwbDouble sr;
  MwbDouble speed;
  MwbDouble steer;
  MwbDouble gapS;
  MwbDouble servo;
};

struct for_code_jgb520_team27ChartDw
{
  MwbDouble frontWarn;
  MwbDouble frontStrong;
  MwbDouble frontEmergency;
  MwbDouble frontRelease;
  MwbDouble frontSectorEmergency;
  MwbDouble sideEmergency;
  MwbDouble sideCorrection;
  MwbDouble scoreCap;
  MwbDouble directionHysteresis;
  MwbDouble normalDeadband;
  MwbDouble clockwiseBias;
  MwbDouble directionLock;
  MwbDouble flEff;
  MwbDouble frEff;
  MwbDouble slEff;
  MwbDouble srEff;
  MwbDouble flCap;
  MwbDouble frCap;
  MwbDouble slCap;
  MwbDouble srCap;
  MwbDouble leftScore;
  MwbDouble rightScore;
  MwbDouble steeringMagnitude;
  MwbDouble normalSteer;
  MwbInt8 is_active_chart;
};

struct b520_team27SteeringratelimiterB
{
  MwbDouble target;
  MwbDouble y;
  MwbDouble y_a;
  MwbDouble y_c;
  MwbDouble y_d;
  MwbDouble y_e;
  MwbDouble y_g;
};

struct gb520_team27SteeringratelimiterDw
{
  MwbDouble k;
  MwbDouble k_b;
  MwbDouble initCond;
  MwbDouble u1;
  MwbDouble unitDelayBuffer;
  MwbDouble yb;
  MwbDouble u1_f;
  MwbDouble u2;
  MwbDouble upperLimit;
  MwbDouble u;
  MwbDouble lowerLimit;
  MwbDouble u1_h;
  MwbDouble u2_i;
};

struct Obsavoidcontroller_team27_mwor2
{
  MwbDouble front_dist;
  MwbDouble rear_dist;
  MwbDouble right_dist;
  MwbDouble left_dist;
  MwbDouble fu_dist;
  MwbDouble speed;
  MwbDouble steer;
  MwbDouble gap;
  MwbDouble fu_sensor_cmd;
  MwbDouble y;
  MwbDouble y_b;
  MwbDouble y_d;
  MwbDouble y_f;
  MwbDouble y_h;
  MwbDouble y_i;
  MwbDouble y_k;
  struct for_code_jgb520_team27FilterfcB filterFC;
  struct for_code_jgb520_team27FilterflB filterFL;
  struct for_code_jgb520_team27FilterfrB filterFR;
  struct for_code_jgb520_team27FilterslB filterSL;
  struct for_code_jgb520_team27FiltersrB filterSR;
  struct for_code_jgb520_team27ChartB chart;
  struct b520_team27SteeringratelimiterB steeringRateLimiter;
};

struct Obsavoidcontroller_team27_mwor3
{
  MwbDouble temp;
  MwbDouble temp1;
  MwbDouble temp2;
  MwbDouble temp3;
  MwbDouble temp4;
  MwbDouble temp5;
  MwbDouble u;
  MwbDouble u_a;
  MwbDouble u_c;
  MwbDouble u_e;
  MwbDouble u_g;
  MwbDouble k;
  MwbDouble k_j;
  MwbDouble upperLimit;
  MwbDouble u_l;
  MwbDouble lowerLimit;
  struct FilterfcDw filterFC;
  struct aFilterflDw filterFL;
  struct aFilterfrDw filterFR;
  struct aFilterslDw filterSL;
  struct aFiltersrDw filterSR;
  struct for_code_jgb520_team27ChartDw chart;
  struct gb520_team27SteeringratelimiterDw steeringRateLimiter;
};

struct for_code_jgb520_team27ExtY
{
  MwbDouble front_center_dist_out;
  MwbDouble front_right_dist_out;
  MwbDouble side_right_dist_out;
  MwbDouble side_left_dist_out;
  MwbDouble front_left_dist_out;
  MwbDouble speed_cmd_out;
  MwbDouble steer_cmd_out;
  MwbDouble fixed_servo_cmd_out;
};

struct for_code_jgb520_team27B
{
  MwbDouble sensor1_distence;
  MwbDouble sensor2_distence;
  MwbDouble sensor3_distence;
  MwbDouble sensor4_distence;
  MwbDouble sensor5_distence;
  MwbDouble speed;
  MwbDouble steer;
  MwbDouble gap;
  MwbDouble fu_sensor_cmd;
  MwbDouble y;
  MwbInt32 y_u;
  MwbInt32 y_w;
  MwbInt32 y_y;
  MwbInt32 y_ba;
  MwbDouble y_da;
  struct Obsavoidcontroller_team27_mwor2 subSystem;
};

struct for_code_jgb520_team27Dw
{
  MwbDouble src;
  MwbDouble u;
  MwbDouble k;
  MwbDouble u_a;
  MwbDouble k_b;
  MwbDouble u_c;
  MwbDouble k_d;
  MwbDouble u_e;
  MwbDouble k_f;
  MwbDouble u_g;
  MwbDouble k_h;
  MwbDouble front_dist;
  MwbDouble rear_dist;
  MwbDouble right_dist;
  MwbDouble left_dist;
  MwbDouble fu_dist;
  MwbDouble temp;
  MwbDouble temp1;
  MwbDouble temp2;
  MwbDouble temp3;
  MwbDouble temp4;
  MwbDouble temp5;
  MwbDouble u_i;
  MwbDouble k_j;
  MwbDouble src_k;
  MwbDouble u_l;
  MwbDouble k_m;
  MwbInt32 id;
  MwbDouble speed;
  MwbInt32 time_ms;
  MwbDouble u_n;
  MwbDouble k_o;
  MwbInt32 id_p;
  MwbDouble speed_q;
  MwbInt32 time_ms_r;
  MwbDouble src_s;
  MwbInt32 k_t;
  MwbInt32 k_v;
  MwbInt32 k_x;
  MwbInt32 k_aa;
  MwbDouble k_ca;
  struct Obsavoidcontroller_team27_mwor3 subSystem;
};


void m27FilterfcInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterfcB* 
  localB, struct FilterfcDw* localDw);
void for_code_jgb520_team27Filterfc(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterfcB* localB, struct FilterfcDw* localDw);
void m27FilterflInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterflB* 
  localB, struct aFilterflDw* localDw);
void for_code_jgb520_team27Filterfl(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterflB* localB, struct aFilterflDw* localDw);
void m27FilterfrInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterfrB* 
  localB, struct aFilterfrDw* localDw);
void for_code_jgb520_team27Filterfr(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterfrB* localB, struct aFilterfrDw* localDw);
void m27FilterslInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterslB* 
  localB, struct aFilterslDw* localDw);
void for_code_jgb520_team27Filtersl(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterslB* localB, struct aFilterslDw* localDw);
void m27FiltersrInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FiltersrB* 
  localB, struct aFiltersrDw* localDw);
void for_code_jgb520_team27Filtersr(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FiltersrB* localB, struct aFiltersrDw* localDw);
void for_code_jgb520_team27ChartInit(MwbDouble sr, MwbDouble fl, MwbDouble sl, MwbDouble fc, MwbDouble fr, MwbDouble fcRaw, MwbDouble* 
  speed, MwbDouble* steer, MwbDouble* gapS, MwbDouble* servo, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27ChartB* 
  localB, struct for_code_jgb520_team27ChartDw* localDw);
void for_code_jgb520_team27Chart(MwbDouble sr, MwbDouble fl, MwbDouble sl, MwbDouble fc, MwbDouble fr, MwbDouble fcRaw, MwbDouble* 
speed, MwbDouble* steer, MwbDouble* gapS, MwbDouble* servo, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27ChartB* 
localB, struct for_code_jgb520_team27ChartDw* localDw);
void ajgb520_team27SteeringratelimiterInit(MwbDouble target, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, 
  struct b520_team27SteeringratelimiterB* localB, struct gb520_team27SteeringratelimiterDw* localDw);
void a20_team27Steeringratelimiter(MwbDouble target, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
b520_team27SteeringratelimiterB* localB, struct gb520_team27SteeringratelimiterDw* localDw);
void Obsavoidcontroller_team27_mwo28(MwbDouble front_dist, MwbDouble rear_dist, MwbDouble right_dist, MwbDouble left_dist, MwbDouble 
  fu_dist, MwbDouble* speed, MwbDouble* steer, MwbDouble* gap, MwbDouble* fu_sensor_cmd, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, 
  struct Obsavoidcontroller_team27_mwor2* localB, struct Obsavoidcontroller_team27_mwor3* localDw);
void Obsavoidcontroller_team27_mwo27(MwbDouble front_dist, MwbDouble rear_dist, MwbDouble right_dist, MwbDouble left_dist, MwbDouble 
fu_dist, MwbDouble* speed, MwbDouble* steer, MwbDouble* gap, MwbDouble* fu_sensor_cmd, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, 
struct Obsavoidcontroller_team27_mwor2* localB, struct Obsavoidcontroller_team27_mwor3* localDw);
void motor_send_cmd(int id, double speed, int time_ms);
void Terminate();


#endif /* a_PRIVATE_H */

/********************************************************************************
** end of file
********************************************************************************/
