/********************************************************************************
 * Copyright (C) 2005-2026, Suzhou Tongyuan Software&Control Technology Co.,Ltd.
 * All rights reserved.
 * 版权所有 (C) 2005-2026， 苏州同元软控技术股份有限公司
 * 保留所有权利。
 *
 * 该文件由MWORKS内核代码生成器自动生成。
 *
 * 文件名称: for_code_JGB520_Team27.c
 * 生成时间: 2026-08-12 20:35:14
 *
********************************************************************************/

#include "for_code_JGB520_Team27.h"
#include "mwb_runtime.h"
#include "for_code_JGB520_Team27_private.h"
#include "for_code_JGB520_Team27_extern_include.h"

struct for_code_jgb520_team27B for_code_jgb520_team27GbB;
struct for_code_jgb520_team27Dw for_code_jgb520_team27GbDw;
static struct for_code_jgb520_team27TagEmd for_code_jgb520_team27StMd;
for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd = &for_code_jgb520_team27StMd;
void steer_cmd(double steer);

void Terminate()
{
  motor_send_cmd(2, 0, 0);
  motor_send_cmd(1, 0, 0);
  steer_cmd(0.0);
  if (fd >= 0) serialClose(fd);
}

void Step(void)
{
  for_code_jgb520_team27GbB.y_ca = for_code_jgb520_team27GbDw.k_ba;
  for_code_jgb520_team27GbB.y_ea = for_code_jgb520_team27GbDw.k_da;
  for_code_jgb520_team27GbB.y_ga = for_code_jgb520_team27GbDw.k_fa;
  for_code_jgb520_team27GbB.y_ia = for_code_jgb520_team27GbDw.k_ha;
  for_code_jgb520_team27GbB.y_ka = for_code_jgb520_team27GbDw.k_ja;
  {
    void rear_sensor_cmd(const MwbDouble);
    rear_sensor_cmd(for_code_jgb520_team27GbB.y_ka);
  }
  {
    void front_sensor_cmd(const MwbDouble);
    front_sensor_cmd(for_code_jgb520_team27GbB.y_ka);
  }
  {
    void GetCarMsg(MwbDouble* , MwbDouble* , MwbDouble* , MwbDouble* , MwbDouble* );
    GetCarMsg(&(for_code_jgb520_team27GbB.sensor1_distence), &(for_code_jgb520_team27GbB.sensor2_distence), &(for_code_jgb520_team27GbB.sensor3_distence), 
    &(for_code_jgb520_team27GbB.sensor4_distence), &(for_code_jgb520_team27GbB.sensor5_distence));
  }
  for_code_jgb520_team27GbB.y = for_code_jgb520_team27GbDw.k * for_code_jgb520_team27GbB.sensor1_distence;
  for_code_jgb520_team27GbB.y_c = for_code_jgb520_team27GbDw.k_d * for_code_jgb520_team27GbB.sensor2_distence;
  for_code_jgb520_team27GbB.y_f = for_code_jgb520_team27GbDw.k_g * for_code_jgb520_team27GbB.sensor3_distence;
  for_code_jgb520_team27GbB.y_i = for_code_jgb520_team27GbDw.k_j * for_code_jgb520_team27GbB.sensor4_distence;
  for_code_jgb520_team27GbB.y_l = for_code_jgb520_team27GbDw.k_m * for_code_jgb520_team27GbB.sensor5_distence;
  Obsavoidcontroller_team27_fflf7(for_code_jgb520_team27GbB.y, for_code_jgb520_team27GbB.y_c, for_code_jgb520_team27GbB.y_f, for_code_jgb520_team27GbB.y_i, 
  for_code_jgb520_team27GbB.y_l, &for_code_jgb520_team27GbDw.u_u, &for_code_jgb520_team27GbDw.u_n, for_code_jgb520_team27GbMd, &for_code_jgb520_team27GbB.subSystem, 
  &for_code_jgb520_team27GbDw.subSystem);
  for_code_jgb520_team27GbB.y_o = for_code_jgb520_team27GbDw.k_p * for_code_jgb520_team27GbDw.u_n;
  {
    void steer_cmd(const MwbDouble);
    steer_cmd(for_code_jgb520_team27GbB.y_o);
  }
  for_code_jgb520_team27GbB.y_s = for_code_jgb520_team27GbDw.k_t * for_code_jgb520_team27GbDw.u_u;
  {
    void  motor_send_cmd(int id,double speed,int time_ms);
    motor_send_cmd(for_code_jgb520_team27GbB.y_ea, for_code_jgb520_team27GbB.y_s, for_code_jgb520_team27GbB.y_ia);
  }
  for_code_jgb520_team27GbB.y_v = for_code_jgb520_team27GbDw.k_w * for_code_jgb520_team27GbDw.u_u;
  {
    void  motor_send_cmd(int id,double speed,int time_ms);
    motor_send_cmd(for_code_jgb520_team27GbB.y_ca, for_code_jgb520_team27GbB.y_v, for_code_jgb520_team27GbB.y_ga);
  }
  ++for_code_jgb520_team27GbMd->m_timeTickCount;
}

void Init(void)
{
  for_code_jgb520_team27GbMd->m_stepSize = 0.05;
  for_code_jgb520_team27GbDw.k_ba = 2;
  for_code_jgb520_team27GbDw.k_da = 1;
  for_code_jgb520_team27GbDw.k_fa = 0;
  for_code_jgb520_team27GbDw.k_ha = 0;
  for_code_jgb520_team27GbDw.k_ja = (MwbDouble)((0));
  for_code_jgb520_team27GbDw.k = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_d = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_g = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_j = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_m = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_p = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_t = (MwbDouble)((1));
  for_code_jgb520_team27GbDw.k_w = (MwbDouble)(((-1)));
  {
    void rasInit(void);
    rasInit();
  }
}


void Obsavoidcontroller_team27_fflf7(MwbDouble sensor1, MwbDouble sensor2, MwbDouble sensor3, MwbDouble sensor4, MwbDouble sensor5, 
  MwbDouble* speed, MwbDouble* steer, for_code_jgb520_team27Emd*const for_code_jgb520_team27GbMd, struct Obsavoidcontroller_team27_fflf2* 
  localB, struct Obsavoidcontroller_team27_fflf3* localDw)
{
  {
    void Team27_ControllerStep(const MwbDouble, const MwbDouble, const MwbDouble, const MwbDouble, const MwbDouble, MwbDouble* , MwbDouble* 
    );
    Team27_ControllerStep(sensor1, sensor2, sensor3, sensor4, sensor5, &(*speed), &(*steer));
  }
}


/********************************************************************************
** end of file
********************************************************************************/
