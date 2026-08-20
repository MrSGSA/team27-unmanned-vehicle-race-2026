/***************************************************************************
///
/// Copyright (c) 2025, 苏州同元软控技术股份有限公司
/// All rights reserved.
///
/// @file           mb_capi.h
/// @brief          提供由CAPI生成的结构类型和常量(包含获取结构体中字段的宏)
///
/// @version        v2.0
/// @date           2025/04/09
///
***************************************************************************/

#ifndef MWS_MB_CAPI_H
#define MWS_MB_CAPI_H

#include "mwb_types.h"

#define MWB_ENUM_TYPE (((MwbUInt8)(255U))-1)
#define MWB_STRUCT    (((MwbUInt8)(255U)))
#define mwb_offsetof(s,el) offsetof(s,el)

/* 内置类型枚举项 */
typedef enum {
    MWB_DOUBLE = 0,
    MWB_SINGLE = 1,
    MWB_INT8 = 2,
    MWB_UINT8 = 3,
    MWB_INT16 = 4,
    MWB_UINT16 = 5,
    MWB_INT32 = 6,
    MWB_UINT32 = 7,
    MWB_INT64 = 8,
    MWB_UINT64 = 9,
    MWB_BOOLEAN = 10,
    MWB_STRING = 11
} Mwb_Builtin_Data_TypeId;

/* 定点缩放类型的枚举项 */
typedef enum {
  Mwb_CAPI_FIX_UNIFORM_SCALING,
  Mwb_CAPI_FIX_NONUNIFORM_SCALING,
  Mwb_CAPI_FIX_RESERVED
} Mwb_CAPI_FixPtScalingType;

/* 数据存储方式的枚举项 */
typedef enum {
  Mwb_CAPI_SCALAR,
  Mwb_CAPI_VECTOR,
  Mwb_CAPI_MATRIX_ROW_MAJOR,
  Mwb_CAPI_MATRIX_COL_MAJOR,
  Mwb_CAPI_MATRIX_COL_MAJOR_ND,
  Mwb_CAPI_MATRIX_ROW_MAJOR_ND
} Mwb_CAPI_Orientation;

typedef struct Mwb_CAPI_ModelMappingInfo_tag Mwb_CAPI_ModelMappingInfo;

/* 信号结构体 */
typedef struct Mwb_CAPI_Signals_tag {
    MwbUInt       addrMapIndex;       /* 数据地址Map中的索引号 */
    MwbUInt       sysNum;             /* 系统层级号,0表示根级 */
    const MwbChar* blockPath;         /* 模块的完整路径 */
    const MwbChar* signalName;        /* 信号标签(没有标签名时设为空) */
    MwbUInt16     portNum;            /* 端口号(从0开始) */
    MwbUInt16     dataTypeIndex;      /* 数据类型Map中的索引号 */
    MwbUInt16     dimIndex;           /* 维度Map中的索引号 */
    MwbUInt16     fxpIndex;           /* 定点信息Map中的索引号 */
    MwbUInt8      sTimeIndex;         /* 采样时间Map中的索引号 */
} Mwb_CAPI_Signals;

/* 获取信号结构体中字段的宏 */
#define Mwb_CAPI_GetSignalAddrIdx(p, i)       ((p)[(i)].addrMapIndex)
#define Mwb_CAPI_GetSignalSysNum(p, i)        ((p)[(i)].sysNum)
#define Mwb_CAPI_GetSignalBlockPath(p, i)     ((p)[(i)].blockPath)
#define Mwb_CAPI_GetSignalName(p, i)          ((p)[(i)].signalName)
#define Mwb_CAPI_GetSignalPortNum(p, i)       ((p)[(i)].portNum)
#define Mwb_CAPI_GetSignalDataTypeIdx(p, i)   ((p)[(i)].dataTypeIndex)
#define Mwb_CAPI_GetSignalDimensionIdx(p, i)  ((p)[(i)].dimIndex)
#define Mwb_CAPI_GetSignalFixPtIdx(p, i)      ((p)[(i)].fxpIndex)
#define Mwb_CAPI_GetSignalSampleTimeIdx(p, i) ((p)[(i)].sTimeIndex)

/* 模块参数结构体 */
typedef struct Mwb_CAPI_BlockParameters_tag {
  MwbUInt       addrMapIndex;       /* 数据地址Map中的索引号 */
  const MwbChar *blockPath;         /* 模块的完整路径 */
  const MwbChar *paramName;         /* 参数名 */
  MwbUInt16     dataTypeIndex;      /* 数据类型Map中的索引号 */
  MwbUInt16     dimIndex;           /* 维度Map中的索引号 */
  MwbUInt16     fxpIndex;           /* 定点信息Map中的索引号 */
} Mwb_CAPI_BlockParameters;

/* 获取模块参数结构体中字段的宏 */
#define Mwb_CAPI_GetBlockParameterAddrIdx(p, i)      ((p)[(i)].addrMapIndex)
#define Mwb_CAPI_GetBlockParameterBlockPath(p, i)    ((p)[(i)].blockPath)
#define Mwb_CAPI_GetBlockParameterName(p, i)         ((p)[(i)].paramName)
#define Mwb_CAPI_GetBlockParameterDataTypeIdx(p, i)  ((p)[(i)].dataTypeIndex)
#define Mwb_CAPI_GetBlockParameterDimensionIdx(p, i) ((p)[(i)].dimIndex)
#define Mwb_CAPI_GetBlockParameterFixPtIdx(p, i)     ((p)[(i)].fxpIndex)

/* 模型参数结构体 */
typedef struct Mwb_CAPI_ModelParameters_tag {
  MwbUInt       addrMapIndex;       /* 数据地址Map中的索引号 */
  const MwbChar *varName;           /* 参数名 */
  MwbUInt16     dataTypeIndex;      /* 数据类型Map中的索引号 */
  MwbUInt16     dimIndex;           /* 维度Map中的索引号 */
  MwbUInt16     fxpIndex;           /* 定点信息Map中的索引号 */
} Mwb_CAPI_ModelParameters;

/* 获取模型参数结构体中字段的宏 */
#define Mwb_CAPI_GetModelParameterAddrIdx(p, i)      ((p)[(i)].addrMapIndex)
#define Mwb_CAPI_GetModelParameterName(p, i)         ((p)[(i)].varName)
#define Mwb_CAPI_GetModelParameterDataTypeIdx(p, i)  ((p)[(i)].dataTypeIndex)
#define Mwb_CAPI_GetModelParameterDimensionIdx(p, i) ((p)[(i)].dimIndex)
#define Mwb_CAPI_GetModelParameterFixPtIdx(p, i)     ((p)[(i)].fxpIndex)

/* 状态结构体 */
typedef struct Mwb_CAPI_States_tag {
  MwbUInt       addrMapIndex;       /* 数据地址Map中的索引号 */
  MwbInt        contStateStartIndex;/* 模型连续状态中的起始索引(为离散状态时设为-1) */
  const MwbChar *blockPath;         /* 模块的完整路径 */
  const MwbChar *stateName;         /* 状态名 */
  const MwbChar *pathAlias;         /* 别名在模型中的路径 */
  MwbUInt16     dWorkIndex;         /* 模块DWork的索引号(连续状态时设为0) */
  MwbUInt16     dataTypeIndex;      /* 数据类型Map中的索引号 */
  MwbUInt16     dimIndex;           /* 维度Map中的引号 */
  MwbUInt16     fxpIndex;           /* 定点信息Map中的索引号 */
  MwbUInt8      sTimeIndex;         /* 采样时间Map中的索引号 */
  MwbUInt8      isContinuous;       /* 是否为连续状态(1为连续) */
  MwbInt        hierInfoIdx;        /* 状态的层次信息索引号(没有层次信息时设为-1) */
  MwbUInt       flatElemIdx;        /* 层次结构中的平面元素索引号 */
} Mwb_CAPI_States;

/* 获取状态结构体中字段的宏 */
#define Mwb_CAPI_GetStateAddrIdx(p, i)         ((p)[(i)].addrMapIndex)
#define Mwb_CAPI_GetContStateStartIndex(p, i)  ((p)[(i)].contStateStartIndex)
#define Mwb_CAPI_GetStateBlockPath(p, i)       ((p)[(i)].blockPath)
#define Mwb_CAPI_GetStateName(p, i)            ((p)[(i)].stateName)
#define Mwb_CAPI_GetStatePathAlias(p, i)       ((p)[(i)].pathAlias)
#define Mwb_CAPI_GetStateDWorkIdx(p, i)        ((p)[(i)].dWorkIndex)
#define Mwb_CAPI_GetStateDataTypeIdx(p, i)     ((p)[(i)].dataTypeIndex)
#define Mwb_CAPI_GetStateDimensionIdx(p, i)    ((p)[(i)].dimIndex)
#define Mwb_CAPI_GetStateFixPtIndex(p, i)      ((p)[(i)].fxpIndex)
#define Mwb_CAPI_GetStateSampleTimeIdx(p, i)   ((p)[(i)].sTimeIndex)
#define Mwb_CAPI_IsAContinuousState(p, i)      ((p)[(i)].isContinuous == 1)
#define Mwb_CAPI_GetStateHierInfoIdx(p, i)     ((p)[(i)].hierInfoIdx)
#define Mwb_CAPI_GetStateFlatElemIdx(p, i)     ((p)[(i)].flatElemIdx)

/* 数据类型Map结构体 */
typedef struct Mwb_CAPI_DataTypeMap_tag {
  const MwbChar *cDataName;         /* C语言中的数据类型名 */
  const MwbChar *mwsDataName;       /* MWS数据类型名(声明在mws_common_decl.h中的) */
  MwbUInt16     numElements;        /* number of elements, 0 for non-structure data */
  MwbUInt16     elemMapIndex;       /* index into the ElementMap, gives Bus Info    */
  MwbUInt16     dataSize;           /* 数据所占的字节大小 */
  MwbUInt8      slDataId;           /* enumerated data type from simstruc_types.h   */
  MwbUInt32     isComplex:1;        /* 是否是复数(复数设为1,实型设为0) */
  MwbUInt32     isPointer:1;        /* 是否是指针(是设为1,不是设为0) */
  MwbUInt8      enumStorageType;    /* 枚举数据类型的存储类型 */
} Mwb_CAPI_DataTypeMap;

/* 获取数据类型Map结构体中字段的宏 */
#define Mwb_CAPI_GetDataTypeCName(p, i)       ((p)[(i)].cDataName)
#define Mwb_CAPI_GetDataTypeMWSName(p, i)     ((p)[(i)].mwsDataName)
#define Mwb_CAPI_GetDataTypeNumElements(p, i) ((p)[(i)].numElements)
#define Mwb_CAPI_GetDataTypeElemMapIndex(p,i) ((p)[(i)].elemMapIndex)
#define Mwb_CAPI_GetDataTypeSize(p, i)        ((p)[(i)].dataSize)
#define Mwb_CAPI_GetDataTypeSLId(p, i)        ((p)[(i)].slDataId)
#define Mwb_CAPI_GetDataIsComplex(p, i)       ((p)[(i)].isComplex)
#define Mwb_CAPI_GetDataIsPointer(p, i)       ((p)[(i)].isPointer)
#define Mwb_CAPI_GetDataIsEnum(p, i)          ((p)[(i)].slDataId == MWB_ENUM_TYPE)
#define Mwb_CAPI_GetDataEnumStorageType(p, i) ((p)[(i)].enumStorageType)

/* 元素Map结构体 */
typedef struct Mwb_CAPI_ElementMap_tag {
  const MwbChar   *elementName;     /* 元素名 */
  MwbUInt32  elementOffset;         /* 以字节为单位的结构元素偏移量 */
  MwbUInt16  dataTypeIndex;         /* 数据类型Map中的索引号 */
  MwbUInt16  dimIndex;              /* 维度Map中的索引号 */
  MwbUInt16  fxpIndex;              /* 定点信息Map中的索引号 */
} Mwb_CAPI_ElementMap;

/* 获取元素Map结构体中字段的宏 */
#define Mwb_CAPI_GetElementName(p, i)         ((p)[(i)].elementName)
#define Mwb_CAPI_GetElementOffset(p, i)       ((p)[(i)].elementOffset)
#define Mwb_CAPI_GetElementDataTypeIdx(p, i)  ((p)[(i)].dataTypeIndex)
#define Mwb_CAPI_GetElementDimensionIdx(p, i) ((p)[(i)].dimIndex)
#define Mwb_CAPI_GetElementFixPtIdx(p, i)     ((p)[(i)].fxpIndex)

/* 维度Map结构体 */
typedef struct Mwb_CAPI_DimensionMap_tag {
  Mwb_CAPI_Orientation  orientation;    /* 数据存储方式 */
  MwbUInt               dimArrayIndex;  /* 维度数组中的索引号 */
  MwbUInt8              numberDims;     /* 维数 */
  MwbUInt               vardimsIndex;   /* 地址数组中的索引号 */
} Mwb_CAPI_DimensionMap;

/* 获取维度Map结构体中字段的宏 */
#define Mwb_CAPI_GetOrientation(p, i)                       ((p)[(i)].orientation)
#define Mwb_CAPI_GetDimArrayIndex(p, i)                     ((p)[(i)].dimArrayIndex)
#define Mwb_CAPI_GetNumberDims(p, i)                        ((p)[(i)].numberDims)
#define Mwb_CAPI_GetDimsIsVariable(vardimsAddrMap, p, i)    (vardimsAddrMap[(p)[(i)].vardimsIndex] != NULL)

/* 定点信息Map结构体 */
typedef struct Mwb_CAPI_FixPtMap_tag {
  MwbDouble                 fracSlope;      /* 斜率分数值 */
  MwbDouble                 bias;           /* 偏差值 */
  Mwb_CAPI_FixPtScalingType scaleType;      /* 定点缩放类型 */
  MwbUInt32                 wordLength;     /* 存储所需位长 */
  MwbInt32                  exponent;       /* 指数值 */
  MwbBool                   isSigned;       /* 是否有符号(有符号设为1,无符号设为0) */
} Mwb_CAPI_FixPtMap;

/* 获取定点信息Map结构体中字段的宏 */
#define Mwb_CAPI_GetFxpFracSlope(p, i)    ((p)[(i)].fracSlope)
#define Mwb_CAPI_GetFxpBias(p, i)         ((p)[(i)].bias)
#define Mwb_CAPI_GetFxpScaling(p, i)      ((p)[(i)].scaleType)
#define Mwb_CAPI_GetFxpWordLength(p, i)   ((p)[(i)].wordLength)
#define Mwb_CAPI_GetFxpExponent(p, i)     ((p)[(i)].exponent)
#define Mwb_CAPI_GetFxpIsSigned(p, i)     ((p)[(i)].isSigned)

/* 采样时间Map结构体 */
typedef struct Mwb_CAPI_SampleTimeMap_tag {
  MwbDouble             samplePeriod;     /* 采样时间周期 */
  MwbDouble             sampleOffset;     /* 采样时间偏移量 */
  MwbInt8               tid;              /* 任务ID */
  MwbUInt8              samplingMode;     /* 1 = FrameBased, 0 = SampleBased */
} Mwb_CAPI_SampleTimeMap;

/* 获取采样时间Map结构体中字段的宏 */
#define Mwb_CAPI_GetSamplePeriod(p, i)    ((p)[(i)].samplePeriod)
#define Mwb_CAPI_GetSampleOffset(p, i)    ((p)[(i)].sampleOffset)
#define Mwb_CAPI_GetSampleTimeTID(p, i)   ((p)[(i)].tid)
#define Mwb_CAPI_GetSamplingMode(p, i)    ((p)[(i)].samplingMode)

/* 模型映射静态信息结构体 */
typedef struct Mwb_CAPI_ModelMappingStaticInfo_tag {
    /* 信号 */
    struct {
        Mwb_CAPI_Signals const  *signals;       /* 信号数组 */
        MwbUInt                 numSignals;     /* 信号个数 */
        Mwb_CAPI_Signals const  *rootInputs;    /* 根级输入数组 */
        MwbUInt                 numRootInputs;  /* 根级输入个数 */
        Mwb_CAPI_Signals const  *rootOutputs;   /* 根级输出数组 */
        MwbUInt                 numRootOutputs; /* 根级输出个数 */
    } Signals;

    /* 参数 */
    struct {
        Mwb_CAPI_BlockParameters const *blockParameters;    /* 模块参数数组 */
        MwbUInt                         numBlockParameters; /* 模块参数个数 */
        Mwb_CAPI_ModelParameters const *modelParameters;    /* 模型参数数组 */
        MwbUInt                         numModelParameters; /* 模型参数个数 */
    } Params;

    /* 状态 */
    struct {
        Mwb_CAPI_States const   *states;   /* 状态数组 */
        MwbUInt                 numStates; /* 状态个数 */
    } States;

    /* 静态maps */
    struct {
        Mwb_CAPI_DataTypeMap    const   *dataTypeMap;       /* 数据类型Map */
        Mwb_CAPI_DimensionMap   const   *dimensionMap;      /* 维度Map */
        Mwb_CAPI_FixPtMap       const   *fixPtMap;          /* 定点信息Map */
        Mwb_CAPI_ElementMap     const   *elementMap;        /* 元素map */
        Mwb_CAPI_SampleTimeMap  const   *sampleTimeMap;     /* 采样时间Map */
        MwbUInt               const     *dimensionArray;    /* 维度数组 */
    } Maps;

    MwbChar const *targetType;          /* 目标类型 */
    MwbBool isProtectedModel;           /* 当前实例是否在受保护的模型内 */
} Mwb_CAPI_ModelMappingStaticInfo;

/* 获取模型映射静态信息结构体中字段的宏 */
#define Mwb_CAPI_GetSignalsFromStaticMap(SM)             ((SM)->Signals.signals)
#define Mwb_CAPI_GetNumSignalsFromStaticMap(SM)          ((SM)->Signals.numSignals)
#define Mwb_CAPI_GetRootInputsFromStaticMap(SM)          ((SM)->Signals.rootInputs) 
#define Mwb_CAPI_GetNumRootInputsFromStaticMap(SM)       ((SM)->Signals.numRootInputs)
#define Mwb_CAPI_GetRootOutputsFromStaticMap(SM)         ((SM)->Signals.rootOutputs)
#define Mwb_CAPI_GetNumRootOutputsFromStaticMap(SM)      ((SM)->Signals.numRootOutputs)

#define Mwb_CAPI_GetBlockParametersFromStaticMap(SM)     ((SM)->Params.blockParameters)
#define Mwb_CAPI_GetNumBlockParametersFromStaticMap(SM)  ((SM)->Params.numBlockParameters) 
#define Mwb_CAPI_GetModelParametersFromStaticMap(SM)     ((SM)->Params.modelParameters)
#define Mwb_CAPI_GetNumModelParametersFromStaticMap(SM)  ((SM)->Params.numModelParameters)

#define Mwb_CAPI_GetStatesFromStaticMap(SM)              ((SM)->States.states)
#define Mwb_CAPI_GetNumStatesFromStaticMap(SM)           ((SM)->States.numStates)

#define Mwb_CAPI_GetDataTypeMapFromStaticMap(SM)         ((SM)->Maps.dataTypeMap)
#define Mwb_CAPI_GetDimensionMapFromStaticMap(SM)        ((SM)->Maps.dimensionMap)
#define Mwb_CAPI_GetFixPtMapFromStaticMap(SM)            ((SM)->Maps.fixPtMap)
#define Mwb_CAPI_GetElementMapFromStaticMap(SM)          ((SM)->Maps.elementMap)
#define Mwb_CAPI_GetSampleTimeMapFromStaticMap(SM)       ((SM)->Maps.sampleTimeMap)
#define Mwb_CAPI_GetDimensionArrayFromStaticMap(SM)      ((SM)->Maps.dimensionArray)

/* 模型映射信息结构体 */
struct Mwb_CAPI_ModelMappingInfo_tag {
    MwbUInt8 versionNumber;                     /* 模型映射信息版本号 */
    Mwb_CAPI_ModelMappingStaticInfo *staticMap; /* 静态模型数据的引用 */

    /* 实例Map */
    struct {
        const MwbChar*              path;                           /* 当前实例的路径 */
        MwbChar*                    fullPath;
        void**                      dataAddrMap;                    /* Data Address map      */
        Mwb_CAPI_ModelMappingInfo** childMMMIArray;                 /* array of child MMMI    */
        MwbUInt                     childMMMIArrayLen;              /* Number of child MMMIs  */
        MwbInt                  contStateStartIndex; 
    } InstanceMap;
};

/* 获取实际数据地址的宏 */
#define Mwb_CAPI_GetDataAddress(dataAddrMap, addrIdx) ((dataAddrMap)[(addrIdx)])

/* 获取模型映射信息结构体中字段的宏 */
#define Mwb_CAPI_GetSignals(MMMI)               Mwb_CAPI_GetSignalsFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetNumSignals(MMMI)            Mwb_CAPI_GetNumSignalsFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetRootInputs(MMMI)            Mwb_CAPI_GetRootInputsFromStaticMap((MMMI).staticMap) 
#define Mwb_CAPI_GetNumRootInputs(MMMI)         Mwb_CAPI_GetNumRootInputsFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetRootOutputs(MMMI)           Mwb_CAPI_GetRootOutputsFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetNumRootOutputs(MMMI)        Mwb_CAPI_GetNumRootOutputsFromStaticMap((MMMI).staticMap)

#define Mwb_CAPI_GetBlockParameters(MMMI)       Mwb_CAPI_GetBlockParametersFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetNumBlockParameters(MMMI)    Mwb_CAPI_GetNumBlockParametersFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetModelParameters(MMMI)       Mwb_CAPI_GetModelParametersFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetNumModelParameters(MMMI)    Mwb_CAPI_GetNumModelParametersFromStaticMap((MMMI).staticMap)

#define Mwb_CAPI_GetStates(MMMI)                Mwb_CAPI_GetStatesFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetNumStates(MMMI)             Mwb_CAPI_GetNumStatesFromStaticMap((MMMI).staticMap)

#define Mwb_CAPI_GetDataTypeMap(MMMI)           Mwb_CAPI_GetDataTypeMapFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetDimensionMap(MMMI)          Mwb_CAPI_GetDimensionMapFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetFixPtMap(MMMI)              Mwb_CAPI_GetFixPtMapFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetElementMap(MMMI)            Mwb_CAPI_GetElementMapFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetSampleTimeMap(MMMI)         Mwb_CAPI_GetSampleTimeMapFromStaticMap((MMMI).staticMap)
#define Mwb_CAPI_GetDimensionArray(MMMI)        Mwb_CAPI_GetDimensionArrayFromStaticMap((MMMI).staticMap)

#define Mwb_CAPI_GetVersion(MMMI)               ((MMMI).versionNumber)
#define Mwb_CAPI_GetPath(MMMI)                  ((MMMI).InstanceMap.path)
#define Mwb_CAPI_GetFullPath(MMMI)              ((MMMI).InstanceMap.fullPath)
#define Mwb_CAPI_GetDataAddressMap(MMMI)        ((MMMI).InstanceMap.dataAddrMap)
#define Mwb_CAPI_GetChildMMIArray(MMMI)         ((MMMI).InstanceMap.childMMMIArray)
#define Mwb_CAPI_GetChildMMIArrayLen(MMMI)      ((MMMI).InstanceMap.childMMMIArrayLen)
#define Mwb_CAPI_GetChildMMI(MMMI,i)            ((MMMI).InstanceMap.childMMMIArray[i])

#define Mwb_CAPI_MMIGetContStateStartIndex(MMMI)    ((MMMI).InstanceMap.contStateStartIndex)

/* 设置模型映射信息结构体中字段的宏 */
#define Mwb_CAPI_SetVersion(MMMI, n)                ((MMMI).versionNumber = (n))
#define Mwb_CAPI_SetStaticMap(MMMI, statMap)        (MMMI).staticMap = (statMap)
#define Mwb_CAPI_SetPath(MMMI,p)                    (MMMI).InstanceMap.path = (p)
#define Mwb_CAPI_SetFullPath(MMMI,p)                (MMMI).InstanceMap.fullPath = (p)
#define Mwb_CAPI_SetDataAddressMap(MMMI, dAddr)     (MMMI).InstanceMap.dataAddrMap = (dAddr)
#define Mwb_CAPI_SetChildMMIArray(MMMI,cMMMIs)      (MMMI).InstanceMap.childMMMIArray = (cMMMIs)
#define Mwb_CAPI_SetChildMMIArrayLen(MMMI,n)        (MMMI).InstanceMap.childMMMIArrayLen = (n)
#define Mwb_CAPI_SetChildMMI(MMMI,i,cMMMI)          (MMMI).InstanceMap.childMMMIArray[i] = (cMMMI)
#define Mwb_CAPI_MMISetContStateStartIndex(MMMI,i)  (MMMI).InstanceMap.contStateStartIndex = (i)

#endif /* MWS_MB_CAPI_H */

/***************************************************************************
//   end of file
***************************************************************************/
