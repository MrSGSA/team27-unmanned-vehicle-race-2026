/********************************************************************************
 * Copyright (C) 2005-2026, Suzhou Tongyuan Software&Control Technology Co.,Ltd.
 * All rights reserved.
 * 版权所有 (C) 2005-2026， 苏州同元软控技术股份有限公司
 * 保留所有权利。
 *
 * 该文件由MWORKS内核代码生成器自动生成。
 *
 * 文件名称: for_code_JGB520_Team27_capi.c
 * 生成时间: 2026-08-20 14:01:17
 *
********************************************************************************/

#include "for_code_JGB520_Team27.h"
#include "for_code_JGB520_Team27_capi.h"
#include "for_code_JGB520_Team27_private.h"
#include "mb_capi.h"

static const Mwb_CAPI_Signals MwRootInputs[] = {
  { 0, 0, (NULL), (NULL), 0, 0, 0, 0, 0 }
};

static const Mwb_CAPI_Signals MwRootOutputs[] = {
  { 0, 0, "for_code_JGB520_Team27", "front_center_dist_out", 0, 0, 0, 0, 0 },
  { 1, 0, "for_code_JGB520_Team27", "front_right_dist_out", 0, 0, 0, 0, 0 },
  { 2, 0, "for_code_JGB520_Team27", "side_right_dist_out", 0, 0, 0, 0, 0 },
  { 3, 0, "for_code_JGB520_Team27", "side_left_dist_out", 0, 0, 0, 0, 0 },
  { 4, 0, "for_code_JGB520_Team27", "front_left_dist_out", 0, 0, 0, 0, 0 },
  { 5, 0, "for_code_JGB520_Team27", "speed_cmd_out", 0, 0, 0, 0, 0 },
  { 6, 0, "for_code_JGB520_Team27", "steer_cmd_out", 0, 0, 0, 0, 0 },
  { 7, 0, "for_code_JGB520_Team27", "fixed_servo_cmd_out", 0, 0, 0, 0, 0 },
  { 0, 0, (NULL), (NULL), 0, 0, 0, 0, 0 }
};

extern struct for_code_jgb520_team27ExtY for_code_jgb520_team27GbOut;
static void* MwDataAddrMap[] = {
  &for_code_jgb520_team27GbOut.front_center_dist_out, 
  &for_code_jgb520_team27GbOut.front_right_dist_out, 
  &for_code_jgb520_team27GbOut.side_right_dist_out, 
  &for_code_jgb520_team27GbOut.side_left_dist_out, 
  &for_code_jgb520_team27GbOut.front_left_dist_out, 
  &for_code_jgb520_team27GbOut.speed_cmd_out, 
  &for_code_jgb520_team27GbOut.steer_cmd_out, 
  &for_code_jgb520_team27GbOut.fixed_servo_cmd_out
};

static const Mwb_CAPI_DataTypeMap MwDataTypeMap[] = {
  { "", "MwbDouble", 0, 0, sizeof(MwbDouble), (MwbUInt8)MWB_DOUBLE, 0, 0, 0 }
};

static const Mwb_CAPI_ElementMap MwElementMap[] = {
  { (NULL), 0, 0, 0, 0 }
};

static const Mwb_CAPI_DimensionMap MwDimensionMap[] = {
  { Mwb_CAPI_SCALAR, 0, 2, 0}
};

static const MwbUInt MwDimensionArray[] = {
  1, 1
};

static const Mwb_CAPI_FixPtMap MwFixPtMap[] = {
   { 0.0, 0.0, Mwb_CAPI_FIX_RESERVED, 0, 0, (MwbBool)0 }
};

static const Mwb_CAPI_SampleTimeMap MwSampleTimeMap[] = {
  { 0.05, 0, (MwbInt8)1, (MwbUInt8)0 }
};

static Mwb_CAPI_ModelMappingStaticInfo mmiStatic = {
  { (NULL), 0, MwRootInputs, 0, MwRootOutputs, 8 },
  { (NULL), 0, (NULL), 0 },
  { (NULL), 0 },
  { MwDataTypeMap, MwDimensionMap, MwFixPtMap, MwElementMap, MwSampleTimeMap, MwDimensionArray },
  "float",
  (MwbBool)0
};

const Mwb_CAPI_ModelMappingStaticInfo* for_code_JGB520_Team27_GetCAPIStaticMap(void)
{
  return &mmiStatic;
}

void for_code_JGB520_Team27_InitializeDataMapInfo(void)
{
  Mwb_CAPI_SetVersion(for_code_jgb520_team27GbMd->DataMapInfo.mmi, 1);
  Mwb_CAPI_SetStaticMap(for_code_jgb520_team27GbMd->DataMapInfo.mmi, &mmiStatic);
  Mwb_CAPI_SetDataAddressMap(for_code_jgb520_team27GbMd->DataMapInfo.mmi, MwDataAddrMap);
  Mwb_CAPI_SetChildMMIArray(for_code_jgb520_team27GbMd->DataMapInfo.mmi, (NULL));
  Mwb_CAPI_SetChildMMIArrayLen(for_code_jgb520_team27GbMd->DataMapInfo.mmi, 0);
}

/********************************************************************************
** end of file
********************************************************************************/
