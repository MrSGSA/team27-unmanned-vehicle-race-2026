/********************************************************************************
 * Copyright (C) 2005-2026, Suzhou Tongyuan Software&Control Technology Co.,Ltd.
 * All rights reserved.
 * 版权所有 (C) 2005-2026， 苏州同元软控技术股份有限公司
 * 保留所有权利。
 *
 * 该文件由MWORKS内核代码生成器自动生成。
 *
 * 文件名称: for_code_JGB520_Team27.c
 * 生成时间: 2026-08-20 20:14:28
 *
********************************************************************************/

#include "for_code_JGB520_Team27.h"
#include "mwb_runtime.h"
#include "for_code_JGB520_Team27_private.h"
#include "for_code_JGB520_Team27_extern_include.h"

#include "for_code_JGB520_Team27_capi.h"

struct for_code_jgb520_team27ExtY for_code_jgb520_team27GbOut;
struct for_code_jgb520_team27B for_code_jgb520_team27GbB;
struct for_code_jgb520_team27Dw for_code_jgb520_team27GbDw;
static struct for_code_jgb520_team27TagEmd for_code_jgb520_team27StMd;
for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd = &for_code_jgb520_team27StMd;
void Terminate()
{
  fd = serialOpen("/dev/ttyAMA0", 115200);
  delayMicroseconds(20000);
  motor_send_cmd(2, 0, 0); 
motor_send_cmd(1, 0, 0); 
}

void Step(void)
{
  MwbDouble tmp=0.0;
  for_code_jgb520_team27GbB.y_u = for_code_jgb520_team27GbDw.k_t;
  for_code_jgb520_team27GbB.y_w = for_code_jgb520_team27GbDw.k_v;
  for_code_jgb520_team27GbB.y_y = for_code_jgb520_team27GbDw.k_x;
  for_code_jgb520_team27GbB.y_ba = for_code_jgb520_team27GbDw.k_aa;
  for_code_jgb520_team27GbB.y_da = for_code_jgb520_team27GbDw.k_ca;
  {
    void rear_sensor_cmd(const MwbDouble);
    rear_sensor_cmd(for_code_jgb520_team27GbB.y_da);
  }
  {
    void GetCarMsg(MwbDouble* , MwbDouble* , MwbDouble* , MwbDouble* , MwbDouble* );
    GetCarMsg(&(for_code_jgb520_team27GbB.sensor1_distence), &(for_code_jgb520_team27GbB.sensor2_distence), &(for_code_jgb520_team27GbB.sensor3_distence), 
    &(for_code_jgb520_team27GbB.sensor4_distence), &(for_code_jgb520_team27GbB.sensor5_distence));
  }
  for_code_jgb520_team27GbOut.front_center_dist_out = for_code_jgb520_team27GbDw.k * for_code_jgb520_team27GbB.sensor1_distence;
  for_code_jgb520_team27GbOut.front_right_dist_out = for_code_jgb520_team27GbDw.k_b * for_code_jgb520_team27GbB.sensor2_distence;
  for_code_jgb520_team27GbOut.side_right_dist_out = for_code_jgb520_team27GbDw.k_d * for_code_jgb520_team27GbB.sensor3_distence;
  for_code_jgb520_team27GbOut.side_left_dist_out = for_code_jgb520_team27GbDw.k_f * for_code_jgb520_team27GbB.sensor4_distence;
  for_code_jgb520_team27GbOut.front_left_dist_out = for_code_jgb520_team27GbDw.k_h * for_code_jgb520_team27GbB.sensor5_distence;
  Obsavoidcontroller_team27_mwo27(for_code_jgb520_team27GbOut.front_center_dist_out, for_code_jgb520_team27GbOut.front_left_dist_out, 
  for_code_jgb520_team27GbOut.side_right_dist_out, for_code_jgb520_team27GbOut.side_left_dist_out, for_code_jgb520_team27GbOut.front_right_dist_out, 
  &for_code_jgb520_team27GbDw.u_n, &for_code_jgb520_team27GbDw.u_i, &tmp, &for_code_jgb520_team27GbOut.fixed_servo_cmd_out, for_code_jgb520_team27GbMd, 
  &for_code_jgb520_team27GbB.subSystem, &for_code_jgb520_team27GbDw.subSystem);
  for_code_jgb520_team27GbOut.steer_cmd_out = for_code_jgb520_team27GbDw.k_j * for_code_jgb520_team27GbDw.u_i;
  {
    void steer_cmd(const MwbDouble);
    steer_cmd(for_code_jgb520_team27GbOut.steer_cmd_out);
  }
  for_code_jgb520_team27GbOut.speed_cmd_out = for_code_jgb520_team27GbDw.k_m * for_code_jgb520_team27GbDw.u_n;
  {
    void motor_send_cmd(int id,double speed,int time_ms);
    motor_send_cmd(for_code_jgb520_team27GbB.y_w, for_code_jgb520_team27GbOut.speed_cmd_out, for_code_jgb520_team27GbB.y_ba);
  }
  for_code_jgb520_team27GbB.y = for_code_jgb520_team27GbDw.k_o * for_code_jgb520_team27GbDw.u_n;
  {
    void motor_send_cmd(int id,double speed,int time_ms);
    motor_send_cmd(for_code_jgb520_team27GbB.y_u, for_code_jgb520_team27GbB.y, for_code_jgb520_team27GbB.y_y);
  }
  {
    void front_sensor_cmd(const MwbDouble);
    front_sensor_cmd(for_code_jgb520_team27GbOut.fixed_servo_cmd_out);
  }
  ++for_code_jgb520_team27GbMd->m_timeTickCount;
}

void Init(void)
{
  MwbDouble tmp=0.0;
  for_code_jgb520_team27GbMd->m_stepSize = 0.05;
  for_code_jgb520_team27GbDw.k_t = 2;
  for_code_jgb520_team27GbDw.k_v = 1;
  for_code_jgb520_team27GbDw.k_x = 0;
  for_code_jgb520_team27GbDw.k_aa = 0;
  for_code_jgb520_team27GbDw.k_ca = (MwbDouble)((0));
  for_code_jgb520_team27GbDw.k = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_b = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_d = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_f = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_h = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_j = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_m = (MwbDouble)(((-1)));
  for_code_jgb520_team27GbDw.k_o = (MwbDouble)((1));
  Obsavoidcontroller_team27_mwo28(for_code_jgb520_team27GbOut.front_center_dist_out, for_code_jgb520_team27GbOut.front_left_dist_out, 
  for_code_jgb520_team27GbOut.side_right_dist_out, for_code_jgb520_team27GbOut.side_left_dist_out, for_code_jgb520_team27GbOut.front_right_dist_out, 
  &for_code_jgb520_team27GbDw.u_n, &for_code_jgb520_team27GbDw.u_i, &tmp, &for_code_jgb520_team27GbOut.fixed_servo_cmd_out, for_code_jgb520_team27GbMd, 
  &for_code_jgb520_team27GbB.subSystem, &for_code_jgb520_team27GbDw.subSystem);
  {
    void rasInit(void);
    rasInit();
  }
  for_code_JGB520_Team27_InitializeDataMapInfo();
}


void m27FilterfcInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterfcB* 
  localB, struct FilterfcDw* localDw)
{
  localDw->k = (MwbDouble)((2));
  localDw->k_b = (MwbDouble)((250));
  localDw->k_d = (MwbDouble)((1));
  localDw->k_f = (MwbDouble)((0));
  localDw->k_h = 0.5;
  localDw->k_j = 0.05;
  localDw->k_l = 0.15;
  localDw->initCond = (MwbDouble)((100));
  localDw->yb = localDw->initCond;
  localDw->k_fa = 0.1;
  localDw->k_qa = 0.9;
  localDw->initCond_ua = (MwbDouble)((0));
  localDw->yb_ya = localDw->initCond_ua;
}

void for_code_jgb520_team27Filterfc(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterfcB* localB, struct FilterfcDw* localDw)
{
  localB->y_a = localDw->k;
  localB->y_c = localDw->k_b;
  localB->y_e = localDw->k_d;
  localB->y_g = localDw->k_f;
  localB->y_i = localDw->k_h;
  localB->y_k = localDw->k_j;
  localB->y_m = localDw->k_l;
  localB->y_n = raw > localB->y_a;
  localB->y_q = localB->y_c > raw;
  if (localB->y_n != (0U))
  {
    localB->y_r = localB->y_e;
  }
  else
  {
    localB->y_r = localB->y_g;
  }
  if (localB->y_q != (0U))
  {
    localB->y_u = localB->y_r;
  }
  else
  {
    localB->y_u = localB->y_g;
  }
  localB->y_ba = localB->y_u > localB->y_i;
  localB->y_da = localDw->yb;
  localB->y_ea = localDw->k_fa * localB->y_da;
  if (localB->y_n != (0U))
  {
    localB->y_ga = raw;
  }
  else
  {
    localB->y_ga = localB->y_da;
  }
  if (localB->y_q != (0U))
  {
    localB->y_ka = localB->y_ga;
  }
  else
  {
    localB->y_ka = localB->y_da;
  }
  localB->y_pa = localDw->k_qa * localB->y_ka;
  localB->y_ra = localB->y_pa + localB->y_ea;
  localB->y_wa = localDw->yb_ya;
  localB->y_bb = localB->y_m > localB->y_wa;
  if (localB->y_bb != (0U))
  {
    *y = localB->y_ra;
  }
  else
  {
    *y = localB->y_g;
  }
  localB->y_fb = localB->y_wa + localB->y_k;
  if (localB->y_ba != (0U))
  {
    localB->y_ib = localB->y_g;
  }
  else
  {
    localB->y_ib = localB->y_fb;
  }
  localDw->yb = localB->y_ra;
  localDw->yb_ya = localB->y_ib;
}
void m27FilterflInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterflB* 
  localB, struct aFilterflDw* localDw)
{
  localDw->k = (MwbDouble)((2));
  localDw->k_b = (MwbDouble)((250));
  localDw->k_d = (MwbDouble)((1));
  localDw->k_f = (MwbDouble)((0));
  localDw->k_h = 0.5;
  localDw->k_j = 0.05;
  localDw->k_l = 0.15;
  localDw->initCond = (MwbDouble)((100));
  localDw->yb = localDw->initCond;
  localDw->k_fa = 0.1;
  localDw->k_qa = 0.9;
  localDw->initCond_ua = (MwbDouble)((0));
  localDw->yb_ya = localDw->initCond_ua;
}

void for_code_jgb520_team27Filterfl(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterflB* localB, struct aFilterflDw* localDw)
{
  localB->y_a = localDw->k;
  localB->y_c = localDw->k_b;
  localB->y_e = localDw->k_d;
  localB->y_g = localDw->k_f;
  localB->y_i = localDw->k_h;
  localB->y_k = localDw->k_j;
  localB->y_m = localDw->k_l;
  localB->y_n = raw > localB->y_a;
  localB->y_q = localB->y_c > raw;
  if (localB->y_n != (0U))
  {
    localB->y_r = localB->y_e;
  }
  else
  {
    localB->y_r = localB->y_g;
  }
  if (localB->y_q != (0U))
  {
    localB->y_u = localB->y_r;
  }
  else
  {
    localB->y_u = localB->y_g;
  }
  localB->y_ba = localB->y_u > localB->y_i;
  localB->y_da = localDw->yb;
  localB->y_ea = localDw->k_fa * localB->y_da;
  if (localB->y_n != (0U))
  {
    localB->y_ga = raw;
  }
  else
  {
    localB->y_ga = localB->y_da;
  }
  if (localB->y_q != (0U))
  {
    localB->y_ka = localB->y_ga;
  }
  else
  {
    localB->y_ka = localB->y_da;
  }
  localB->y_pa = localDw->k_qa * localB->y_ka;
  localB->y_ra = localB->y_pa + localB->y_ea;
  localB->y_wa = localDw->yb_ya;
  localB->y_bb = localB->y_m > localB->y_wa;
  if (localB->y_bb != (0U))
  {
    *y = localB->y_ra;
  }
  else
  {
    *y = localB->y_g;
  }
  localB->y_fb = localB->y_wa + localB->y_k;
  if (localB->y_ba != (0U))
  {
    localB->y_ib = localB->y_g;
  }
  else
  {
    localB->y_ib = localB->y_fb;
  }
  localDw->yb = localB->y_ra;
  localDw->yb_ya = localB->y_ib;
}
void m27FilterfrInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterfrB* 
  localB, struct aFilterfrDw* localDw)
{
  localDw->k = (MwbDouble)((2));
  localDw->k_b = (MwbDouble)((250));
  localDw->k_d = (MwbDouble)((1));
  localDw->k_f = (MwbDouble)((0));
  localDw->k_h = 0.5;
  localDw->k_j = 0.05;
  localDw->k_l = 0.15;
  localDw->initCond = (MwbDouble)((100));
  localDw->yb = localDw->initCond;
  localDw->k_fa = 0.1;
  localDw->k_qa = 0.9;
  localDw->initCond_ua = (MwbDouble)((0));
  localDw->yb_ya = localDw->initCond_ua;
}

void for_code_jgb520_team27Filterfr(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterfrB* localB, struct aFilterfrDw* localDw)
{
  localB->y_a = localDw->k;
  localB->y_c = localDw->k_b;
  localB->y_e = localDw->k_d;
  localB->y_g = localDw->k_f;
  localB->y_i = localDw->k_h;
  localB->y_k = localDw->k_j;
  localB->y_m = localDw->k_l;
  localB->y_n = raw > localB->y_a;
  localB->y_q = localB->y_c > raw;
  if (localB->y_n != (0U))
  {
    localB->y_r = localB->y_e;
  }
  else
  {
    localB->y_r = localB->y_g;
  }
  if (localB->y_q != (0U))
  {
    localB->y_u = localB->y_r;
  }
  else
  {
    localB->y_u = localB->y_g;
  }
  localB->y_ba = localB->y_u > localB->y_i;
  localB->y_da = localDw->yb;
  localB->y_ea = localDw->k_fa * localB->y_da;
  if (localB->y_n != (0U))
  {
    localB->y_ga = raw;
  }
  else
  {
    localB->y_ga = localB->y_da;
  }
  if (localB->y_q != (0U))
  {
    localB->y_ka = localB->y_ga;
  }
  else
  {
    localB->y_ka = localB->y_da;
  }
  localB->y_pa = localDw->k_qa * localB->y_ka;
  localB->y_ra = localB->y_pa + localB->y_ea;
  localB->y_wa = localDw->yb_ya;
  localB->y_bb = localB->y_m > localB->y_wa;
  if (localB->y_bb != (0U))
  {
    *y = localB->y_ra;
  }
  else
  {
    *y = localB->y_g;
  }
  localB->y_fb = localB->y_wa + localB->y_k;
  if (localB->y_ba != (0U))
  {
    localB->y_ib = localB->y_g;
  }
  else
  {
    localB->y_ib = localB->y_fb;
  }
  localDw->yb = localB->y_ra;
  localDw->yb_ya = localB->y_ib;
}
void m27FilterslInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FilterslB* 
  localB, struct aFilterslDw* localDw)
{
  localDw->k = (MwbDouble)((2));
  localDw->k_b = (MwbDouble)((250));
  localDw->k_d = (MwbDouble)((1));
  localDw->k_f = (MwbDouble)((0));
  localDw->k_h = 0.5;
  localDw->k_j = 0.05;
  localDw->k_l = 0.15;
  localDw->initCond = (MwbDouble)((100));
  localDw->yb = localDw->initCond;
  localDw->k_fa = 0.1;
  localDw->k_qa = 0.9;
  localDw->initCond_ua = (MwbDouble)((0));
  localDw->yb_ya = localDw->initCond_ua;
}

void for_code_jgb520_team27Filtersl(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FilterslB* localB, struct aFilterslDw* localDw)
{
  localB->y_a = localDw->k;
  localB->y_c = localDw->k_b;
  localB->y_e = localDw->k_d;
  localB->y_g = localDw->k_f;
  localB->y_i = localDw->k_h;
  localB->y_k = localDw->k_j;
  localB->y_m = localDw->k_l;
  localB->y_n = raw > localB->y_a;
  localB->y_q = localB->y_c > raw;
  if (localB->y_n != (0U))
  {
    localB->y_r = localB->y_e;
  }
  else
  {
    localB->y_r = localB->y_g;
  }
  if (localB->y_q != (0U))
  {
    localB->y_u = localB->y_r;
  }
  else
  {
    localB->y_u = localB->y_g;
  }
  localB->y_ba = localB->y_u > localB->y_i;
  localB->y_da = localDw->yb;
  localB->y_ea = localDw->k_fa * localB->y_da;
  if (localB->y_n != (0U))
  {
    localB->y_ga = raw;
  }
  else
  {
    localB->y_ga = localB->y_da;
  }
  if (localB->y_q != (0U))
  {
    localB->y_ka = localB->y_ga;
  }
  else
  {
    localB->y_ka = localB->y_da;
  }
  localB->y_pa = localDw->k_qa * localB->y_ka;
  localB->y_ra = localB->y_pa + localB->y_ea;
  localB->y_wa = localDw->yb_ya;
  localB->y_bb = localB->y_m > localB->y_wa;
  if (localB->y_bb != (0U))
  {
    *y = localB->y_ra;
  }
  else
  {
    *y = localB->y_g;
  }
  localB->y_fb = localB->y_wa + localB->y_k;
  if (localB->y_ba != (0U))
  {
    localB->y_ib = localB->y_g;
  }
  else
  {
    localB->y_ib = localB->y_fb;
  }
  localDw->yb = localB->y_ra;
  localDw->yb_ya = localB->y_ib;
}
void m27FiltersrInit(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27FiltersrB* 
  localB, struct aFiltersrDw* localDw)
{
  localDw->k = (MwbDouble)((2));
  localDw->k_b = (MwbDouble)((250));
  localDw->k_d = (MwbDouble)((1));
  localDw->k_f = (MwbDouble)((0));
  localDw->k_h = 0.5;
  localDw->k_j = 0.05;
  localDw->k_l = 0.15;
  localDw->initCond = (MwbDouble)((100));
  localDw->yb = localDw->initCond;
  localDw->k_fa = 0.1;
  localDw->k_qa = 0.9;
  localDw->initCond_ua = (MwbDouble)((0));
  localDw->yb_ya = localDw->initCond_ua;
}

void for_code_jgb520_team27Filtersr(MwbDouble raw, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
for_code_jgb520_team27FiltersrB* localB, struct aFiltersrDw* localDw)
{
  localB->y_a = localDw->k;
  localB->y_c = localDw->k_b;
  localB->y_e = localDw->k_d;
  localB->y_g = localDw->k_f;
  localB->y_i = localDw->k_h;
  localB->y_k = localDw->k_j;
  localB->y_m = localDw->k_l;
  localB->y_n = raw > localB->y_a;
  localB->y_q = localB->y_c > raw;
  if (localB->y_n != (0U))
  {
    localB->y_r = localB->y_e;
  }
  else
  {
    localB->y_r = localB->y_g;
  }
  if (localB->y_q != (0U))
  {
    localB->y_u = localB->y_r;
  }
  else
  {
    localB->y_u = localB->y_g;
  }
  localB->y_ba = localB->y_u > localB->y_i;
  localB->y_da = localDw->yb;
  localB->y_ea = localDw->k_fa * localB->y_da;
  if (localB->y_n != (0U))
  {
    localB->y_ga = raw;
  }
  else
  {
    localB->y_ga = localB->y_da;
  }
  if (localB->y_q != (0U))
  {
    localB->y_ka = localB->y_ga;
  }
  else
  {
    localB->y_ka = localB->y_da;
  }
  localB->y_pa = localDw->k_qa * localB->y_ka;
  localB->y_ra = localB->y_pa + localB->y_ea;
  localB->y_wa = localDw->yb_ya;
  localB->y_bb = localB->y_m > localB->y_wa;
  if (localB->y_bb != (0U))
  {
    *y = localB->y_ra;
  }
  else
  {
    *y = localB->y_g;
  }
  localB->y_fb = localB->y_wa + localB->y_k;
  if (localB->y_ba != (0U))
  {
    localB->y_ib = localB->y_g;
  }
  else
  {
    localB->y_ib = localB->y_fb;
  }
  localDw->yb = localB->y_ra;
  localDw->yb_ya = localB->y_ib;
}
void for_code_jgb520_team27ChartInit(MwbDouble sr, MwbDouble fl, MwbDouble sl, MwbDouble fc, MwbDouble fr, MwbDouble fcRaw, MwbDouble* 
  speed, MwbDouble* steer, MwbDouble* gapS, MwbDouble* servo, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27ChartB* 
  localB, struct for_code_jgb520_team27ChartDw* localDw)
{
  localDw->frontWarn = (MwbDouble)((26));
  localDw->frontStrong = (MwbDouble)((12));
  localDw->frontEmergency = 5.5;
  localDw->frontRelease = (MwbDouble)((30));
  localDw->frontSectorEmergency = 4.5;
  localDw->frontDiagonalWarn = (MwbDouble)((22));
  localDw->frontDiagonalRelease = (MwbDouble)((26));
  localDw->sideEmergency = (MwbDouble)((6));
  localDw->sideCorrection = (MwbDouble)((10));
  localDw->scoreCap = (MwbDouble)((40));
  localDw->unknownForward = (MwbDouble)((10));
  localDw->unknownSide = (MwbDouble)((8));
  localDw->pathFrontMinimum = (MwbDouble)((9));
  localDw->pathSideMinimum = (MwbDouble)((8));
  localDw->frontCornerRelease = (MwbDouble)((10));
  localDw->trappedDistance = (MwbDouble)((10));
  localDw->directionHysteresis = 2.5;
  localDw->directionSwitchMargin = (MwbDouble)((5));
  localDw->directionConfirmTime = 0.1;
  localDw->normalDeadband = (MwbDouble)((3));
  localDw->clockwiseBias = 0.5;
  localDw->directionLock = (MwbDouble)((0));
  localDw->desiredDirection = (MwbDouble)((0));
  localDw->candidateDirection = (MwbDouble)((0));
  localDw->candidateTimer = (MwbDouble)((0));
  localDw->avoidRequest = (MwbDouble)((0));
  localDw->leftPathAllowed = (MwbDouble)((1));
  localDw->rightPathAllowed = (MwbDouble)((1));
  localDw->flEff = (MwbDouble)((40));
  localDw->frEff = (MwbDouble)((40));
  localDw->slEff = (MwbDouble)((40));
  localDw->srEff = (MwbDouble)((40));
  localDw->flCap = (MwbDouble)((40));
  localDw->frCap = (MwbDouble)((40));
  localDw->slCap = (MwbDouble)((40));
  localDw->srCap = (MwbDouble)((40));
  localDw->leftScore = (MwbDouble)((40));
  localDw->rightScore = (MwbDouble)((40));
  localDw->leftSideReach = (MwbDouble)((40));
  localDw->rightSideReach = (MwbDouble)((40));
  localDw->steeringMagnitude = (MwbDouble)((0));
  localDw->closestFront = (MwbDouble)((40));
  localDw->normalSteer = (MwbDouble)((0));
  localDw->pocketDistance = (MwbDouble)((11));
  localDw->turnEscapeSpeed = (MwbDouble)((45));
  localDw->corridorCenterMinimum = (MwbDouble)((18));
  localDw->corridorCornerMinimum = (MwbDouble)((12));
  localDw->corridorPassAllowed = (MwbDouble)((0));
  localDw->tightStopDistance = (MwbDouble)((18));
  localDw->tightStopRequest = (MwbDouble)((0));
  localDw->normalStopRequest = (MwbDouble)((0));
  localDw->stopRecoveryTimer = (MwbDouble)((0));
  localDw->stopRecoveryDelay = 0.2;
  localDw->backupState = (MwbDouble)((0));
  localDw->backupTimer = (MwbDouble)((0));
  localDw->closeConfirmTimer = (MwbDouble)((0));
  localDw->escapeFailureTimer = (MwbDouble)((0));
  localDw->escapeFailureTime = 0.45;
  localDw->backupEscapeDirection = (MwbDouble)((0));
  localDw->lastBackupEscapeDirection = (MwbDouble)((0));
  localDw->backupCycleCount = (MwbDouble)((0));
  localDw->backupCycleLimit = (MwbDouble)((2));
  localDw->backupArmed = (MwbDouble)((1));
  localDw->controlStep = 0.05;
  localDw->backupConfirmTime = 0.1;
  localDw->backupMinTime = 0.8;
  localDw->backupMaxTime = 1.2;
  localDw->backupPreStopTime = 0.2;
  localDw->backupStraightTime = 0.2;
  localDw->backupSteerMagnitude = 0.38;
  localDw->backupSettleTime = 0.15;
  localDw->backupRelease = (MwbDouble)((12));
  localDw->backupSpeedCmd = (MwbDouble)(((-55)));
  *speed = (MwbDouble)((0));
  *steer = (MwbDouble)((0));
  *gapS = (MwbDouble)((0));
  *servo = (MwbDouble)((0));
}
void for_code_jgb520_team27Chart(MwbDouble sr, MwbDouble fl, MwbDouble sl, MwbDouble fc, MwbDouble fr, MwbDouble fcRaw, MwbDouble* 
speed, MwbDouble* steer, MwbDouble* gapS, MwbDouble* servo, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct for_code_jgb520_team27ChartB* 
localB, struct for_code_jgb520_team27ChartDw* localDw)
{
  if (localDw->is_active_chart == 0U)
  {
    localDw->is_active_chart = (MwbInt8)(((1U)));
    if (fl >= 2)
    {
      localDw->flEff = fl;
    }
    else
    {
      localDw->flEff = localDw->unknownForward;
    }
    if (fr >= 2)
    {
      localDw->frEff = fr;
    }
    else
    {
      localDw->frEff = localDw->unknownForward;
    }
    if (sl >= 2)
    {
      localDw->slEff = sl;
    }
    else
    {
      localDw->slEff = localDw->unknownSide;
    }
    if (sr >= 2)
    {
      localDw->srEff = sr;
    }
    else
    {
      localDw->srEff = localDw->unknownSide;
    }
    if (localDw->flEff < localDw->scoreCap)
    {
      localDw->flCap = localDw->flEff;
    }
    else
    {
      localDw->flCap = localDw->scoreCap;
    }
    if (localDw->frEff < localDw->scoreCap)
    {
      localDw->frCap = localDw->frEff;
    }
    else
    {
      localDw->frCap = localDw->scoreCap;
    }
    if (localDw->slEff < localDw->scoreCap)
    {
      localDw->slCap = localDw->slEff;
    }
    else
    {
      localDw->slCap = localDw->scoreCap;
    }
    if (localDw->srEff < localDw->scoreCap)
    {
      localDw->srCap = localDw->srEff;
    }
    else
    {
      localDw->srCap = localDw->scoreCap;
    }
    localDw->leftSideReach = 1.6 * localDw->slCap;
    if (localDw->leftSideReach > localDw->scoreCap)
    {
      localDw->leftSideReach = localDw->scoreCap;
    }
    else
    {
      /* nothing to do. */
    }
    localDw->rightSideReach = 1.6 * localDw->srCap;
    if (localDw->rightSideReach > localDw->scoreCap)
    {
      localDw->rightSideReach = localDw->scoreCap;
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->flCap < localDw->leftSideReach)
    {
      localDw->leftScore = localDw->flCap;
    }
    else
    {
      localDw->leftScore = localDw->leftSideReach;
    }
    if (localDw->frCap < localDw->rightSideReach)
    {
      localDw->rightScore = localDw->frCap + localDw->clockwiseBias;
    }
    else
    {
      localDw->rightScore = localDw->rightSideReach + localDw->clockwiseBias;
    }
    if (localDw->flEff >= localDw->pathFrontMinimum && localDw->slEff >= localDw->pathSideMinimum)
    {
      localDw->leftPathAllowed = (MwbDouble)((1));
    }
    else
    {
      localDw->leftPathAllowed = (MwbDouble)((0));
    }
    if (localDw->frEff >= localDw->pathFrontMinimum && localDw->srEff >= localDw->pathSideMinimum)
    {
      localDw->rightPathAllowed = (MwbDouble)((1));
    }
    else
    {
      localDw->rightPathAllowed = (MwbDouble)((0));
    }
    if (fc >= localDw->corridorCenterMinimum && localDw->flEff >= localDw->corridorCornerMinimum && localDw->frEff >= localDw->corridorCornerMinimum)
    {
      localDw->corridorPassAllowed = (MwbDouble)((1));
    }
    else
    {
      localDw->corridorPassAllowed = (MwbDouble)((0));
    }
    localDw->closestFront = fc;
    if (localDw->flEff < localDw->closestFront)
    {
      localDw->closestFront = localDw->flEff;
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->frEff < localDw->closestFront)
    {
      localDw->closestFront = localDw->frEff;
    }
    else
    {
      /* nothing to do. */
    }
    if (fc > 0 && fc <= localDw->frontWarn || localDw->flEff <= localDw->frontDiagonalWarn || localDw->frEff <= localDw->frontDiagonalWarn)
    {
      localDw->avoidRequest = (MwbDouble)((1));
    }
    else
    {
      localDw->avoidRequest = (MwbDouble)((0));
    }
    if (localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5 && localDw->closestFront <= localDw->tightStopDistance && fcRaw >= 2 && fcRaw <= 250)
    {
      localDw->tightStopRequest = (MwbDouble)((1));
    }
    else
    {
      localDw->tightStopRequest = (MwbDouble)((0));
    }
    if (fcRaw >= 2 && fcRaw <= 250 && ((fc <= localDw->frontEmergency || fcRaw <= localDw->frontEmergency) && !((localDw->directionLock 
    > 0.5 && localDw->leftPathAllowed > 0.5 || localDw->directionLock < (-0.5) && localDw->rightPathAllowed > 0.5)) || localDw->flEff 
    <= localDw->frontSectorEmergency && localDw->rightPathAllowed < 0.5 || localDw->frEff <= localDw->frontSectorEmergency && localDw->leftPathAllowed 
    < 0.5 || localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5))
    {
      localDw->normalStopRequest = (MwbDouble)((1));
    }
    else
    {
      localDw->normalStopRequest = (MwbDouble)((0));
    }
    if (fc > localDw->frontRelease && localDw->flEff > localDw->frontDiagonalRelease && localDw->frEff > localDw->frontDiagonalRelease)
    {
      localDw->backupArmed = (MwbDouble)((1));
      localDw->backupCycleCount = (MwbDouble)((0));
      localDw->lastBackupEscapeDirection = (MwbDouble)((0));
      localDw->closeConfirmTimer = (MwbDouble)((0));
      localDw->escapeFailureTimer = (MwbDouble)((0));
      localDw->stopRecoveryTimer = (MwbDouble)((0));
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->backupState < 0.5 && localDw->backupArmed > 0.5 && (fcRaw >= 2 && fcRaw <= localDw->frontEmergency || localDw->flEff 
    <= localDw->frontSectorEmergency && localDw->frEff > localDw->frontSectorEmergency || localDw->frEff <= localDw->frontSectorEmergency 
    && localDw->flEff > localDw->frontSectorEmergency))
    {
      localDw->escapeFailureTimer = localDw->escapeFailureTimer + localDw->controlStep;
    }
    else
    {
      localDw->escapeFailureTimer = (MwbDouble)((0));
    }
    if (localDw->backupState < 0.5 && localDw->normalStopRequest > 0.5 && localDw->backupCycleCount < localDw->backupCycleLimit)
    {
      localDw->stopRecoveryTimer = localDw->stopRecoveryTimer + localDw->controlStep;
    }
    else
    {
      localDw->stopRecoveryTimer = (MwbDouble)((0));
    }
    if (localDw->backupState > 2.5)
    {
      localDw->backupTimer = localDw->backupTimer + localDw->controlStep;
      if (localDw->backupTimer >= localDw->backupSettleTime)
      {
        localDw->backupState = (MwbDouble)((0));
        localDw->backupTimer = (MwbDouble)((0));
        localDw->directionLock = (MwbDouble)((0));
        localDw->desiredDirection = (MwbDouble)((0));
        localDw->candidateDirection = (MwbDouble)((0));
        localDw->candidateTimer = (MwbDouble)((0));
        localDw->backupEscapeDirection = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    else if (localDw->backupState > 1.5)
    {
      localDw->backupTimer = localDw->backupTimer + localDw->controlStep;
      if (!((fcRaw >= 2 && fcRaw <= 250)) || localDw->backupTimer >= localDw->backupMaxTime || localDw->backupTimer >= localDw->backupMinTime 
      && fc >= localDw->backupRelease && localDw->flEff >= localDw->frontCornerRelease && localDw->frEff >= localDw->frontCornerRelease)
      {
        localDw->backupState = (MwbDouble)((3));
        localDw->backupTimer = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    else if (localDw->backupState > 0.5)
    {
      localDw->backupTimer = localDw->backupTimer + localDw->controlStep;
      if (!((fcRaw >= 2 && fcRaw <= 250)))
      {
        localDw->backupState = (MwbDouble)((3));
        localDw->backupTimer = (MwbDouble)((0));
      }
      else if (localDw->backupTimer >= localDw->backupPreStopTime)
      {
        localDw->backupState = (MwbDouble)((2));
        localDw->backupTimer = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    else
    {
      if (localDw->backupArmed > 0.5 && (localDw->tightStopRequest > 0.5 || localDw->escapeFailureTimer >= localDw->escapeFailureTime 
      || localDw->flEff <= localDw->pocketDistance && localDw->frEff <= localDw->pocketDistance || fc > 0 && fc <= localDw->frontStrong 
      && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5) || localDw->stopRecoveryTimer >= localDw->stopRecoveryDelay 
      && localDw->backupCycleCount < localDw->backupCycleLimit)
      {
        localDw->closeConfirmTimer = localDw->closeConfirmTimer + localDw->controlStep;
      }
      else
      {
        localDw->closeConfirmTimer = (MwbDouble)((0));
      }
      if (localDw->closeConfirmTimer >= localDw->backupConfirmTime)
      {
        if (localDw->leftPathAllowed > 0.5 && localDw->rightPathAllowed < 0.5)
        {
          localDw->backupEscapeDirection = (MwbDouble)((1));
        }
        else if (localDw->rightPathAllowed > 0.5 && localDw->leftPathAllowed < 0.5)
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        else if (localDw->leftScore > localDw->rightScore + localDw->directionHysteresis)
        {
          localDw->backupEscapeDirection = (MwbDouble)((1));
        }
        else if (localDw->rightScore > localDw->leftScore + localDw->directionHysteresis)
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        else if (localDw->backupCycleCount > 0.5 && localDw->lastBackupEscapeDirection > 0.5)
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        else if (localDw->backupCycleCount > 0.5 && localDw->lastBackupEscapeDirection < (-0.5))
        {
          localDw->backupEscapeDirection = (MwbDouble)((1));
        }
        else
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        localDw->lastBackupEscapeDirection = localDw->backupEscapeDirection;
        localDw->backupCycleCount = localDw->backupCycleCount + (MwbDouble)(1);
        localDw->backupState = (MwbDouble)((1));
        localDw->backupTimer = (MwbDouble)((0));
        localDw->closeConfirmTimer = (MwbDouble)((0));
        localDw->escapeFailureTimer = (MwbDouble)((0));
        localDw->stopRecoveryTimer = (MwbDouble)((0));
        localDw->backupArmed = (MwbDouble)((0));
        localDw->desiredDirection = (MwbDouble)((0));
        localDw->candidateDirection = (MwbDouble)((0));
        localDw->candidateTimer = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    if (localDw->backupState < 0.5)
    {
      if (localDw->directionLock > 0.5)
      {
        if (fc > localDw->frontRelease && localDw->frEff > localDw->frontDiagonalRelease)
        {
          localDw->directionLock = (MwbDouble)((0));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->rightPathAllowed > 0.5 && (localDw->leftPathAllowed < 0.5 || localDw->rightScore > localDw->leftScore + 
        localDw->directionSwitchMargin))
        {
          localDw->directionLock = (MwbDouble)(((-1)));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5)
        {
          localDw->directionLock = (MwbDouble)((0));
        }
        else
        {
          /* nothing to do. */
        }
      }
      else if (localDw->directionLock < (-0.5))
      {
        if (fc > localDw->frontRelease && localDw->flEff > localDw->frontDiagonalRelease)
        {
          localDw->directionLock = (MwbDouble)((0));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->leftPathAllowed > 0.5 && (localDw->rightPathAllowed < 0.5 || localDw->leftScore > localDw->rightScore + 
        localDw->directionSwitchMargin))
        {
          localDw->directionLock = (MwbDouble)((1));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5)
        {
          localDw->directionLock = (MwbDouble)((0));
        }
        else
        {
          /* nothing to do. */
        }
      }
      else
      {
        localDw->desiredDirection = (MwbDouble)((0));
        if (localDw->avoidRequest > 0.5)
        {
          if (localDw->leftPathAllowed > 0.5 && localDw->rightPathAllowed < 0.5)
          {
            localDw->desiredDirection = (MwbDouble)((1));
          }
          else if (localDw->rightPathAllowed > 0.5 && localDw->leftPathAllowed < 0.5)
          {
            localDw->desiredDirection = (MwbDouble)(((-1)));
          }
          else if (localDw->leftPathAllowed > 0.5 && localDw->rightPathAllowed > 0.5)
          {
            if (localDw->leftScore > localDw->rightScore + localDw->directionHysteresis)
            {
              localDw->desiredDirection = (MwbDouble)((1));
            }
            else
            {
              localDw->desiredDirection = (MwbDouble)(((-1)));
            }
          }
          else
          {
            /* nothing to do. */
          }
        }
        else
        {
          /* nothing to do. */
        }
        if (localDw->desiredDirection > 0.5 || localDw->desiredDirection < (-0.5))
        {
          if (localDw->candidateDirection > 0.5 && localDw->desiredDirection > 0.5 || localDw->candidateDirection < (-0.5) && localDw->desiredDirection 
          < (-0.5))
          {
            localDw->candidateTimer = localDw->candidateTimer + localDw->controlStep;
          }
          else
          {
            localDw->candidateDirection = localDw->desiredDirection;
            localDw->candidateTimer = localDw->controlStep;
          }
          if (localDw->candidateTimer >= localDw->directionConfirmTime)
          {
            localDw->directionLock = localDw->candidateDirection;
            localDw->candidateDirection = (MwbDouble)((0));
            localDw->candidateTimer = (MwbDouble)((0));
          }
          else
          {
            /* nothing to do. */
          }
        }
        else
        {
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
      }
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->backupState > 2.5)
    {
      *speed = (MwbDouble)((0));
    }
    else if (localDw->backupState > 1.5)
    {
      *speed = localDw->backupSpeedCmd;
    }
    else if (localDw->backupState > 0.5)
    {
      *speed = (MwbDouble)((0));
    }
    else if (fc <= localDw->frontEmergency || fcRaw >= 2 && fcRaw <= localDw->frontEmergency)
    {
      if (localDw->directionLock > 0.5 && localDw->leftPathAllowed > 0.5 || localDw->directionLock < (-0.5) && localDw->rightPathAllowed 
      > 0.5)
      {
        *speed = localDw->turnEscapeSpeed;
      }
      else
      {
        *speed = (MwbDouble)((0));
      }
    }
    else if (localDw->flEff <= localDw->frontSectorEmergency && localDw->frEff > localDw->frontSectorEmergency && localDw->rightPathAllowed 
    > 0.5)
    {
      *speed = localDw->turnEscapeSpeed;
    }
    else if (localDw->frEff <= localDw->frontSectorEmergency && localDw->flEff > localDw->frontSectorEmergency && localDw->leftPathAllowed 
    > 0.5)
    {
      *speed = localDw->turnEscapeSpeed;
    }
    else if (localDw->flEff <= localDw->frontSectorEmergency || localDw->frEff <= localDw->frontSectorEmergency)
    {
      *speed = (MwbDouble)((0));
    }
    else if (localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5)
    {
      *speed = (MwbDouble)((0));
    }
    else if (localDw->corridorPassAllowed > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5)
    {
      *speed = (MwbDouble)((90));
    }
    else if (localDw->directionLock > 0.5 || localDw->directionLock < (-0.5))
    {
      if (localDw->closestFront <= 8)
      {
        *speed = localDw->turnEscapeSpeed;
      }
      else if (localDw->closestFront <= 11)
      {
        *speed = (MwbDouble)((70));
      }
      else if (localDw->closestFront <= 16)
      {
        *speed = (MwbDouble)((100));
      }
      else
      {
        *speed = (MwbDouble)((130));
      }
    }
    else if (localDw->avoidRequest > 0.5)
    {
      *speed = (MwbDouble)((110));
    }
    else if (localDw->flEff < 8 || localDw->frEff < 8 || localDw->slEff < localDw->sideEmergency || localDw->srEff < localDw->sideEmergency)
    {
      *speed = (MwbDouble)((90));
    }
    else if (fc <= 32 || localDw->flEff < 26 || localDw->frEff < 26)
    {
      *speed = (MwbDouble)((140));
    }
    else
    {
      *speed = (MwbDouble)((160));
    }
    if (localDw->backupState > 2.5)
    {
      *steer = (MwbDouble)((0));
    }
    else if (localDw->backupState > 1.5)
    {
      if (localDw->backupTimer < localDw->backupStraightTime)
      {
        *steer = (MwbDouble)((0));
      }
      else if (localDw->backupEscapeDirection > 0.5)
      {
        *steer = -(localDw->backupSteerMagnitude);
      }
      else if (localDw->backupEscapeDirection < (-0.5))
      {
        *steer = localDw->backupSteerMagnitude;
      }
      else
      {
        *steer = (MwbDouble)((0));
      }
    }
    else if (localDw->backupState > 0.5)
    {
      *steer = (MwbDouble)((0));
    }
    else if (localDw->flEff <= localDw->frontSectorEmergency && localDw->frEff > localDw->frontSectorEmergency && localDw->rightPathAllowed 
    > 0.5)
    {
      *steer = (-0.58);
      localDw->directionLock = (MwbDouble)(((-1)));
    }
    else if (localDw->frEff <= localDw->frontSectorEmergency && localDw->flEff > localDw->frontSectorEmergency && localDw->leftPathAllowed 
    > 0.5)
    {
      *steer = 0.58;
      localDw->directionLock = (MwbDouble)((1));
    }
    else if (localDw->slEff < localDw->sideEmergency && !((localDw->srEff < localDw->sideEmergency)))
    {
      *steer = (-0.58);
      localDw->directionLock = (MwbDouble)(((-1)));
    }
    else if (localDw->srEff < localDw->sideEmergency && !((localDw->slEff < localDw->sideEmergency)))
    {
      *steer = 0.58;
      localDw->directionLock = (MwbDouble)((1));
    }
    else if (localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5)
    {
      *steer = (MwbDouble)((0));
    }
    else if (localDw->directionLock > 0.5 || localDw->directionLock < (-0.5))
    {
      if (localDw->closestFront <= 12)
      {
        localDw->steeringMagnitude = 0.58;
      }
      else if (localDw->closestFront <= 18)
      {
        localDw->steeringMagnitude = 0.56;
      }
      else
      {
        localDw->steeringMagnitude = 0.48;
      }
      *steer = localDw->directionLock * localDw->steeringMagnitude;
    }
    else
    {
      if (localDw->leftScore - localDw->rightScore > localDw->normalDeadband || localDw->rightScore - localDw->leftScore > localDw->normalDeadband)
      {
        localDw->normalSteer = 0.02 * (localDw->leftScore - localDw->rightScore);
      }
      else
      {
        localDw->normalSteer = (MwbDouble)((0));
      }
      if (localDw->slEff < localDw->sideCorrection)
      {
        localDw->normalSteer = localDw->normalSteer - 0.055 * (localDw->sideCorrection - localDw->slEff);
      }
      else
      {
        /* nothing to do. */
      }
      if (localDw->srEff < localDw->sideCorrection)
      {
        localDw->normalSteer = localDw->normalSteer + 0.055 * (localDw->sideCorrection - localDw->srEff);
      }
      else
      {
        /* nothing to do. */
      }
      if (localDw->normalSteer > 0.4)
      {
        *steer = 0.4;
      }
      else if (localDw->normalSteer < (-0.4))
      {
        *steer = (-0.4);
      }
      else
      {
        *steer = localDw->normalSteer;
      }
    }
    *gapS = (MwbDouble)((0));
    *servo = (MwbDouble)((0));
  }
  else
  {
    if (fl >= 2)
    {
      localDw->flEff = fl;
    }
    else
    {
      localDw->flEff = localDw->unknownForward;
    }
    if (fr >= 2)
    {
      localDw->frEff = fr;
    }
    else
    {
      localDw->frEff = localDw->unknownForward;
    }
    if (sl >= 2)
    {
      localDw->slEff = sl;
    }
    else
    {
      localDw->slEff = localDw->unknownSide;
    }
    if (sr >= 2)
    {
      localDw->srEff = sr;
    }
    else
    {
      localDw->srEff = localDw->unknownSide;
    }
    if (localDw->flEff < localDw->scoreCap)
    {
      localDw->flCap = localDw->flEff;
    }
    else
    {
      localDw->flCap = localDw->scoreCap;
    }
    if (localDw->frEff < localDw->scoreCap)
    {
      localDw->frCap = localDw->frEff;
    }
    else
    {
      localDw->frCap = localDw->scoreCap;
    }
    if (localDw->slEff < localDw->scoreCap)
    {
      localDw->slCap = localDw->slEff;
    }
    else
    {
      localDw->slCap = localDw->scoreCap;
    }
    if (localDw->srEff < localDw->scoreCap)
    {
      localDw->srCap = localDw->srEff;
    }
    else
    {
      localDw->srCap = localDw->scoreCap;
    }
    localDw->leftSideReach = 1.6 * localDw->slCap;
    if (localDw->leftSideReach > localDw->scoreCap)
    {
      localDw->leftSideReach = localDw->scoreCap;
    }
    else
    {
      /* nothing to do. */
    }
    localDw->rightSideReach = 1.6 * localDw->srCap;
    if (localDw->rightSideReach > localDw->scoreCap)
    {
      localDw->rightSideReach = localDw->scoreCap;
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->flCap < localDw->leftSideReach)
    {
      localDw->leftScore = localDw->flCap;
    }
    else
    {
      localDw->leftScore = localDw->leftSideReach;
    }
    if (localDw->frCap < localDw->rightSideReach)
    {
      localDw->rightScore = localDw->frCap + localDw->clockwiseBias;
    }
    else
    {
      localDw->rightScore = localDw->rightSideReach + localDw->clockwiseBias;
    }
    if (localDw->flEff >= localDw->pathFrontMinimum && localDw->slEff >= localDw->pathSideMinimum)
    {
      localDw->leftPathAllowed = (MwbDouble)((1));
    }
    else
    {
      localDw->leftPathAllowed = (MwbDouble)((0));
    }
    if (localDw->frEff >= localDw->pathFrontMinimum && localDw->srEff >= localDw->pathSideMinimum)
    {
      localDw->rightPathAllowed = (MwbDouble)((1));
    }
    else
    {
      localDw->rightPathAllowed = (MwbDouble)((0));
    }
    if (fc >= localDw->corridorCenterMinimum && localDw->flEff >= localDw->corridorCornerMinimum && localDw->frEff >= localDw->corridorCornerMinimum)
    {
      localDw->corridorPassAllowed = (MwbDouble)((1));
    }
    else
    {
      localDw->corridorPassAllowed = (MwbDouble)((0));
    }
    localDw->closestFront = fc;
    if (localDw->flEff < localDw->closestFront)
    {
      localDw->closestFront = localDw->flEff;
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->frEff < localDw->closestFront)
    {
      localDw->closestFront = localDw->frEff;
    }
    else
    {
      /* nothing to do. */
    }
    if (fc > 0 && fc <= localDw->frontWarn || localDw->flEff <= localDw->frontDiagonalWarn || localDw->frEff <= localDw->frontDiagonalWarn)
    {
      localDw->avoidRequest = (MwbDouble)((1));
    }
    else
    {
      localDw->avoidRequest = (MwbDouble)((0));
    }
    if (localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5 && localDw->closestFront <= localDw->tightStopDistance && fcRaw >= 2 && fcRaw <= 250)
    {
      localDw->tightStopRequest = (MwbDouble)((1));
    }
    else
    {
      localDw->tightStopRequest = (MwbDouble)((0));
    }
    if (fcRaw >= 2 && fcRaw <= 250 && ((fc <= localDw->frontEmergency || fcRaw <= localDw->frontEmergency) && !((localDw->directionLock 
    > 0.5 && localDw->leftPathAllowed > 0.5 || localDw->directionLock < (-0.5) && localDw->rightPathAllowed > 0.5)) || localDw->flEff 
    <= localDw->frontSectorEmergency && localDw->rightPathAllowed < 0.5 || localDw->frEff <= localDw->frontSectorEmergency && localDw->leftPathAllowed 
    < 0.5 || localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5))
    {
      localDw->normalStopRequest = (MwbDouble)((1));
    }
    else
    {
      localDw->normalStopRequest = (MwbDouble)((0));
    }
    if (fc > localDw->frontRelease && localDw->flEff > localDw->frontDiagonalRelease && localDw->frEff > localDw->frontDiagonalRelease)
    {
      localDw->backupArmed = (MwbDouble)((1));
      localDw->backupCycleCount = (MwbDouble)((0));
      localDw->lastBackupEscapeDirection = (MwbDouble)((0));
      localDw->closeConfirmTimer = (MwbDouble)((0));
      localDw->escapeFailureTimer = (MwbDouble)((0));
      localDw->stopRecoveryTimer = (MwbDouble)((0));
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->backupState < 0.5 && localDw->backupArmed > 0.5 && (fcRaw >= 2 && fcRaw <= localDw->frontEmergency || localDw->flEff 
    <= localDw->frontSectorEmergency && localDw->frEff > localDw->frontSectorEmergency || localDw->frEff <= localDw->frontSectorEmergency 
    && localDw->flEff > localDw->frontSectorEmergency))
    {
      localDw->escapeFailureTimer = localDw->escapeFailureTimer + localDw->controlStep;
    }
    else
    {
      localDw->escapeFailureTimer = (MwbDouble)((0));
    }
    if (localDw->backupState < 0.5 && localDw->normalStopRequest > 0.5 && localDw->backupCycleCount < localDw->backupCycleLimit)
    {
      localDw->stopRecoveryTimer = localDw->stopRecoveryTimer + localDw->controlStep;
    }
    else
    {
      localDw->stopRecoveryTimer = (MwbDouble)((0));
    }
    if (localDw->backupState > 2.5)
    {
      localDw->backupTimer = localDw->backupTimer + localDw->controlStep;
      if (localDw->backupTimer >= localDw->backupSettleTime)
      {
        localDw->backupState = (MwbDouble)((0));
        localDw->backupTimer = (MwbDouble)((0));
        localDw->directionLock = (MwbDouble)((0));
        localDw->desiredDirection = (MwbDouble)((0));
        localDw->candidateDirection = (MwbDouble)((0));
        localDw->candidateTimer = (MwbDouble)((0));
        localDw->backupEscapeDirection = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    else if (localDw->backupState > 1.5)
    {
      localDw->backupTimer = localDw->backupTimer + localDw->controlStep;
      if (!((fcRaw >= 2 && fcRaw <= 250)) || localDw->backupTimer >= localDw->backupMaxTime || localDw->backupTimer >= localDw->backupMinTime 
      && fc >= localDw->backupRelease && localDw->flEff >= localDw->frontCornerRelease && localDw->frEff >= localDw->frontCornerRelease)
      {
        localDw->backupState = (MwbDouble)((3));
        localDw->backupTimer = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    else if (localDw->backupState > 0.5)
    {
      localDw->backupTimer = localDw->backupTimer + localDw->controlStep;
      if (!((fcRaw >= 2 && fcRaw <= 250)))
      {
        localDw->backupState = (MwbDouble)((3));
        localDw->backupTimer = (MwbDouble)((0));
      }
      else if (localDw->backupTimer >= localDw->backupPreStopTime)
      {
        localDw->backupState = (MwbDouble)((2));
        localDw->backupTimer = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    else
    {
      if (localDw->backupArmed > 0.5 && (localDw->tightStopRequest > 0.5 || localDw->escapeFailureTimer >= localDw->escapeFailureTime 
      || localDw->flEff <= localDw->pocketDistance && localDw->frEff <= localDw->pocketDistance || fc > 0 && fc <= localDw->frontStrong 
      && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5) || localDw->stopRecoveryTimer >= localDw->stopRecoveryDelay 
      && localDw->backupCycleCount < localDw->backupCycleLimit)
      {
        localDw->closeConfirmTimer = localDw->closeConfirmTimer + localDw->controlStep;
      }
      else
      {
        localDw->closeConfirmTimer = (MwbDouble)((0));
      }
      if (localDw->closeConfirmTimer >= localDw->backupConfirmTime)
      {
        if (localDw->leftPathAllowed > 0.5 && localDw->rightPathAllowed < 0.5)
        {
          localDw->backupEscapeDirection = (MwbDouble)((1));
        }
        else if (localDw->rightPathAllowed > 0.5 && localDw->leftPathAllowed < 0.5)
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        else if (localDw->leftScore > localDw->rightScore + localDw->directionHysteresis)
        {
          localDw->backupEscapeDirection = (MwbDouble)((1));
        }
        else if (localDw->rightScore > localDw->leftScore + localDw->directionHysteresis)
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        else if (localDw->backupCycleCount > 0.5 && localDw->lastBackupEscapeDirection > 0.5)
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        else if (localDw->backupCycleCount > 0.5 && localDw->lastBackupEscapeDirection < (-0.5))
        {
          localDw->backupEscapeDirection = (MwbDouble)((1));
        }
        else
        {
          localDw->backupEscapeDirection = (MwbDouble)(((-1)));
        }
        localDw->lastBackupEscapeDirection = localDw->backupEscapeDirection;
        localDw->backupCycleCount = localDw->backupCycleCount + (MwbDouble)(1);
        localDw->backupState = (MwbDouble)((1));
        localDw->backupTimer = (MwbDouble)((0));
        localDw->closeConfirmTimer = (MwbDouble)((0));
        localDw->escapeFailureTimer = (MwbDouble)((0));
        localDw->stopRecoveryTimer = (MwbDouble)((0));
        localDw->backupArmed = (MwbDouble)((0));
        localDw->desiredDirection = (MwbDouble)((0));
        localDw->candidateDirection = (MwbDouble)((0));
        localDw->candidateTimer = (MwbDouble)((0));
      }
      else
      {
        /* nothing to do. */
      }
    }
    if (localDw->backupState < 0.5)
    {
      if (localDw->directionLock > 0.5)
      {
        if (fc > localDw->frontRelease && localDw->frEff > localDw->frontDiagonalRelease)
        {
          localDw->directionLock = (MwbDouble)((0));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->rightPathAllowed > 0.5 && (localDw->leftPathAllowed < 0.5 || localDw->rightScore > localDw->leftScore + 
        localDw->directionSwitchMargin))
        {
          localDw->directionLock = (MwbDouble)(((-1)));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5)
        {
          localDw->directionLock = (MwbDouble)((0));
        }
        else
        {
          /* nothing to do. */
        }
      }
      else if (localDw->directionLock < (-0.5))
      {
        if (fc > localDw->frontRelease && localDw->flEff > localDw->frontDiagonalRelease)
        {
          localDw->directionLock = (MwbDouble)((0));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->leftPathAllowed > 0.5 && (localDw->rightPathAllowed < 0.5 || localDw->leftScore > localDw->rightScore + 
        localDw->directionSwitchMargin))
        {
          localDw->directionLock = (MwbDouble)((1));
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
        else if (localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5)
        {
          localDw->directionLock = (MwbDouble)((0));
        }
        else
        {
          /* nothing to do. */
        }
      }
      else
      {
        localDw->desiredDirection = (MwbDouble)((0));
        if (localDw->avoidRequest > 0.5)
        {
          if (localDw->leftPathAllowed > 0.5 && localDw->rightPathAllowed < 0.5)
          {
            localDw->desiredDirection = (MwbDouble)((1));
          }
          else if (localDw->rightPathAllowed > 0.5 && localDw->leftPathAllowed < 0.5)
          {
            localDw->desiredDirection = (MwbDouble)(((-1)));
          }
          else if (localDw->leftPathAllowed > 0.5 && localDw->rightPathAllowed > 0.5)
          {
            if (localDw->leftScore > localDw->rightScore + localDw->directionHysteresis)
            {
              localDw->desiredDirection = (MwbDouble)((1));
            }
            else
            {
              localDw->desiredDirection = (MwbDouble)(((-1)));
            }
          }
          else
          {
            /* nothing to do. */
          }
        }
        else
        {
          /* nothing to do. */
        }
        if (localDw->desiredDirection > 0.5 || localDw->desiredDirection < (-0.5))
        {
          if (localDw->candidateDirection > 0.5 && localDw->desiredDirection > 0.5 || localDw->candidateDirection < (-0.5) && localDw->desiredDirection 
          < (-0.5))
          {
            localDw->candidateTimer = localDw->candidateTimer + localDw->controlStep;
          }
          else
          {
            localDw->candidateDirection = localDw->desiredDirection;
            localDw->candidateTimer = localDw->controlStep;
          }
          if (localDw->candidateTimer >= localDw->directionConfirmTime)
          {
            localDw->directionLock = localDw->candidateDirection;
            localDw->candidateDirection = (MwbDouble)((0));
            localDw->candidateTimer = (MwbDouble)((0));
          }
          else
          {
            /* nothing to do. */
          }
        }
        else
        {
          localDw->candidateDirection = (MwbDouble)((0));
          localDw->candidateTimer = (MwbDouble)((0));
        }
      }
    }
    else
    {
      /* nothing to do. */
    }
    if (localDw->backupState > 2.5)
    {
      *speed = (MwbDouble)((0));
    }
    else if (localDw->backupState > 1.5)
    {
      *speed = localDw->backupSpeedCmd;
    }
    else if (localDw->backupState > 0.5)
    {
      *speed = (MwbDouble)((0));
    }
    else if (fc <= localDw->frontEmergency || fcRaw >= 2 && fcRaw <= localDw->frontEmergency)
    {
      if (localDw->directionLock > 0.5 && localDw->leftPathAllowed > 0.5 || localDw->directionLock < (-0.5) && localDw->rightPathAllowed 
      > 0.5)
      {
        *speed = localDw->turnEscapeSpeed;
      }
      else
      {
        *speed = (MwbDouble)((0));
      }
    }
    else if (localDw->flEff <= localDw->frontSectorEmergency && localDw->frEff > localDw->frontSectorEmergency && localDw->rightPathAllowed 
    > 0.5)
    {
      *speed = localDw->turnEscapeSpeed;
    }
    else if (localDw->frEff <= localDw->frontSectorEmergency && localDw->flEff > localDw->frontSectorEmergency && localDw->leftPathAllowed 
    > 0.5)
    {
      *speed = localDw->turnEscapeSpeed;
    }
    else if (localDw->flEff <= localDw->frontSectorEmergency || localDw->frEff <= localDw->frontSectorEmergency)
    {
      *speed = (MwbDouble)((0));
    }
    else if (localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5)
    {
      *speed = (MwbDouble)((0));
    }
    else if (localDw->corridorPassAllowed > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5)
    {
      *speed = (MwbDouble)((90));
    }
    else if (localDw->directionLock > 0.5 || localDw->directionLock < (-0.5))
    {
      if (localDw->closestFront <= 8)
      {
        *speed = localDw->turnEscapeSpeed;
      }
      else if (localDw->closestFront <= 11)
      {
        *speed = (MwbDouble)((70));
      }
      else if (localDw->closestFront <= 16)
      {
        *speed = (MwbDouble)((100));
      }
      else
      {
        *speed = (MwbDouble)((130));
      }
    }
    else if (localDw->avoidRequest > 0.5)
    {
      *speed = (MwbDouble)((110));
    }
    else if (localDw->flEff < 8 || localDw->frEff < 8 || localDw->slEff < localDw->sideEmergency || localDw->srEff < localDw->sideEmergency)
    {
      *speed = (MwbDouble)((90));
    }
    else if (fc <= 32 || localDw->flEff < 26 || localDw->frEff < 26)
    {
      *speed = (MwbDouble)((140));
    }
    else
    {
      *speed = (MwbDouble)((160));
    }
    if (localDw->backupState > 2.5)
    {
      *steer = (MwbDouble)((0));
    }
    else if (localDw->backupState > 1.5)
    {
      if (localDw->backupTimer < localDw->backupStraightTime)
      {
        *steer = (MwbDouble)((0));
      }
      else if (localDw->backupEscapeDirection > 0.5)
      {
        *steer = -(localDw->backupSteerMagnitude);
      }
      else if (localDw->backupEscapeDirection < (-0.5))
      {
        *steer = localDw->backupSteerMagnitude;
      }
      else
      {
        *steer = (MwbDouble)((0));
      }
    }
    else if (localDw->backupState > 0.5)
    {
      *steer = (MwbDouble)((0));
    }
    else if (localDw->flEff <= localDw->frontSectorEmergency && localDw->frEff > localDw->frontSectorEmergency && localDw->rightPathAllowed 
    > 0.5)
    {
      *steer = (-0.58);
      localDw->directionLock = (MwbDouble)(((-1)));
    }
    else if (localDw->frEff <= localDw->frontSectorEmergency && localDw->flEff > localDw->frontSectorEmergency && localDw->leftPathAllowed 
    > 0.5)
    {
      *steer = 0.58;
      localDw->directionLock = (MwbDouble)((1));
    }
    else if (localDw->slEff < localDw->sideEmergency && !((localDw->srEff < localDw->sideEmergency)))
    {
      *steer = (-0.58);
      localDw->directionLock = (MwbDouble)(((-1)));
    }
    else if (localDw->srEff < localDw->sideEmergency && !((localDw->slEff < localDw->sideEmergency)))
    {
      *steer = 0.58;
      localDw->directionLock = (MwbDouble)((1));
    }
    else if (localDw->avoidRequest > 0.5 && localDw->leftPathAllowed < 0.5 && localDw->rightPathAllowed < 0.5 && localDw->corridorPassAllowed 
    < 0.5)
    {
      *steer = (MwbDouble)((0));
    }
    else if (localDw->directionLock > 0.5 || localDw->directionLock < (-0.5))
    {
      if (localDw->closestFront <= 12)
      {
        localDw->steeringMagnitude = 0.58;
      }
      else if (localDw->closestFront <= 18)
      {
        localDw->steeringMagnitude = 0.56;
      }
      else
      {
        localDw->steeringMagnitude = 0.48;
      }
      *steer = localDw->directionLock * localDw->steeringMagnitude;
    }
    else
    {
      if (localDw->leftScore - localDw->rightScore > localDw->normalDeadband || localDw->rightScore - localDw->leftScore > localDw->normalDeadband)
      {
        localDw->normalSteer = 0.02 * (localDw->leftScore - localDw->rightScore);
      }
      else
      {
        localDw->normalSteer = (MwbDouble)((0));
      }
      if (localDw->slEff < localDw->sideCorrection)
      {
        localDw->normalSteer = localDw->normalSteer - 0.055 * (localDw->sideCorrection - localDw->slEff);
      }
      else
      {
        /* nothing to do. */
      }
      if (localDw->srEff < localDw->sideCorrection)
      {
        localDw->normalSteer = localDw->normalSteer + 0.055 * (localDw->sideCorrection - localDw->srEff);
      }
      else
      {
        /* nothing to do. */
      }
      if (localDw->normalSteer > 0.4)
      {
        *steer = 0.4;
      }
      else if (localDw->normalSteer < (-0.4))
      {
        *steer = (-0.4);
      }
      else
      {
        *steer = localDw->normalSteer;
      }
    }
    *gapS = (MwbDouble)((0));
    *servo = (MwbDouble)((0));
  }
}
void ajgb520_team27SteeringratelimiterInit(MwbDouble target, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, 
  struct b520_team27SteeringratelimiterB* localB, struct gb520_team27SteeringratelimiterDw* localDw)
{
  localDw->k = 0.16;
  localDw->k_b = (-0.16);
  localDw->initCond = (MwbDouble)((0));
  localDw->yb = localDw->initCond;
}

void a20_team27Steeringratelimiter(MwbDouble target, MwbDouble* y, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct 
b520_team27SteeringratelimiterB* localB, struct gb520_team27SteeringratelimiterDw* localDw)
{
  localB->y_a = localDw->k;
  localB->y_c = localDw->k_b;
  localB->y_d = localDw->yb;
  localB->y_e = target - localB->y_d;
  if (localB->y_e > localB->y_a)
  {
    localB->y_g = localB->y_a;
  }
  else if (localB->y_e < localB->y_c)
  {
    localB->y_g = localB->y_c;
  }
  else
  {
    localB->y_g = localB->y_e;
  }
  *y = localB->y_g + localB->y_d;
  localDw->yb = *y;
}
void Obsavoidcontroller_team27_mwo28(MwbDouble front_dist, MwbDouble rear_dist, MwbDouble right_dist, MwbDouble left_dist, MwbDouble 
  fu_dist, MwbDouble* speed, MwbDouble* steer, MwbDouble* gap, MwbDouble* fu_sensor_cmd, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, 
  struct Obsavoidcontroller_team27_mwor2* localB, struct Obsavoidcontroller_team27_mwor3* localDw)
{
  m27FilterfcInit(localB->y, &localDw->temp3, for_code_jgb520_team27GbMd, &localB->filterFC, &localDw->filterFC);
  m27FilterflInit(localB->y_b, &localDw->temp1, for_code_jgb520_team27GbMd, &localB->filterFL, &localDw->filterFL);
  m27FilterfrInit(localB->y_d, &localDw->temp4, for_code_jgb520_team27GbMd, &localB->filterFR, &localDw->filterFR);
  m27FilterslInit(localB->y_f, &localDw->temp2, for_code_jgb520_team27GbMd, &localB->filterSL, &localDw->filterSL);
  m27FiltersrInit(localB->y_h, &localDw->temp, for_code_jgb520_team27GbMd, &localB->filterSR, &localDw->filterSR);
  for_code_jgb520_team27ChartInit(localDw->temp, localDw->temp1, localDw->temp2, localDw->temp3, localDw->temp4, localB->y, speed, 
  &localDw->temp5, gap, fu_sensor_cmd, for_code_jgb520_team27GbMd, &localB->chart, &localDw->chart);
  ajgb520_team27SteeringratelimiterInit(localDw->temp5, &localDw->u_l, for_code_jgb520_team27GbMd, &localB->steeringRateLimiter, &localDw->steeringRateLimiter);
  
  localDw->k = 0.58;
  localDw->k_j = (-0.58);
}

void Obsavoidcontroller_team27_mwo27(MwbDouble front_dist, MwbDouble rear_dist, MwbDouble right_dist, MwbDouble left_dist, MwbDouble 
fu_dist, MwbDouble* speed, MwbDouble* steer, MwbDouble* gap, MwbDouble* fu_sensor_cmd, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, 
struct Obsavoidcontroller_team27_mwor2* localB, struct Obsavoidcontroller_team27_mwor3* localDw)
{
  localB->y = fabs(front_dist);
  localB->y_b = fabs(rear_dist);
  localB->y_d = fabs(fu_dist);
  localB->y_f = fabs(left_dist);
  localB->y_h = fabs(right_dist);
  for_code_jgb520_team27Filterfc(localB->y, &localDw->temp3, for_code_jgb520_team27GbMd, &localB->filterFC, &localDw->filterFC);
  for_code_jgb520_team27Filterfl(localB->y_b, &localDw->temp1, for_code_jgb520_team27GbMd, &localB->filterFL, &localDw->filterFL);
  
  for_code_jgb520_team27Filterfr(localB->y_d, &localDw->temp4, for_code_jgb520_team27GbMd, &localB->filterFR, &localDw->filterFR);
  
  for_code_jgb520_team27Filtersl(localB->y_f, &localDw->temp2, for_code_jgb520_team27GbMd, &localB->filterSL, &localDw->filterSL);
  
  for_code_jgb520_team27Filtersr(localB->y_h, &localDw->temp, for_code_jgb520_team27GbMd, &localB->filterSR, &localDw->filterSR);
  for_code_jgb520_team27Chart(localDw->temp, localDw->temp1, localDw->temp2, localDw->temp3, localDw->temp4, localB->y, speed, &localDw->temp5, 
  gap, fu_sensor_cmd, for_code_jgb520_team27GbMd, &localB->chart, &localDw->chart);
  a20_team27Steeringratelimiter(localDw->temp5, &localDw->u_l, for_code_jgb520_team27GbMd, &localB->steeringRateLimiter, &localDw->steeringRateLimiter);
  
  localB->y_i = localDw->k;
  localB->y_k = localDw->k_j;
  if (localDw->u_l > localB->y_i)
  {
    *steer = localB->y_i;
  }
  else if (localDw->u_l < localB->y_k)
  {
    *steer = localB->y_k;
  }
  else
  {
    *steer = localDw->u_l;
  }
}


/********************************************************************************
** end of file
********************************************************************************/
