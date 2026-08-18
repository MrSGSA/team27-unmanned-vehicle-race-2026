#ifndef _COMMON_DEFINE_H_
#define _COMMON_DEFINE_H_

#define MagineFixNameString  (const char*)("RTSolverMulti")
#define ServerLogName             "RTSolverMulti.log"
#define DATAINDEX_MAX 100

#if defined(__GNUC__) || defined(__clang__)
#define FUNC_NAME __PRETTY_FUNCTION__
#elif defined(_MSC_VER)
#define FUNC_NAME __FUNCTION__
#else
#define FUNC_NAME __func__
#endif

#define PRINT_FUNC              printf("Recive: [%s] \n", FUNC_NAME)

#ifndef _CGT_LINUX_
#include <QString>
#include <unordered_map>
#include <vector>

#define MagineFixName           QString("RTSolverMulti")
#define TOOL_INSTALL_PATH       (QApplication::applicationDirPath() + QString("/Addins/ExternalMode/"))
#define TOOL_INSTALL_RASP       (QApplication::applicationDirPath() + QString("/Addins/ExternalMode/board/raspberry"))
#define TOOL_INSTALL_STM32      (QApplication::applicationDirPath() + QString("/Addins/ExternalMode/board/stm32"))
#define TOOL_INSTALL_STM32_TCP  (QApplication::applicationDirPath() + QString("/Addins/ExternalMode/board/stm32H750_tcp"))
#define TOOL_INSTALL_PX4        (QApplication::applicationDirPath() + QString("/Addins/ExternalMode/board/px4"))
#define TOOL_INSTALL_BOARD      (QApplication::applicationDirPath() + QString("/Addins/ExternalMode/board"))
#define RUN_EXE_                QString("RunDevice.out")
#define BUILD_LOG               QString("deploy.log")

#define INI_DEFAULT             QString("default")
#define INI_RASP_LIB            QString("RaspberryLib")
#define INI_PX4_ENV             QString("Px4Env")
#define INI_STM32_PRO           QString("Stm32Pro")
#define INI_STM32_ENV           QString("Stm32Env")
#define INI_PX4_BOARD_TYPE      QString("Board")
#define INI_SERIAL_COM          QString("COM")
#define INI_SERIAL_BIT          QString("Bitrate")

#define INI_PX4_APP_SRC         QString("home/Firmware/src/modules/px4_Sysplorer_app")
#define INI_STM32_PROJECT       QString("/USER/")
#define INI_STM32_APP_SRC       (INI_STM32_PROJECT + QString("Model/"))
#define INI_STM32_PROJECT_FILE  QString("OBJ/NewProject.hex")


// 硬件板卡设置
struct BoardSettings
{
    // Board Parameters
    QString boardName;
    QString deviceAddr;
    QString userName;
    QString password;
    QString remotePath;
    QString px4ProjPath;
    QString bitRate;
    QString comPort;
    QString stm32_Env;
    QString stm32_ProjPath;
    QString keilPath;
    QString flashToolPath;
    int type; 
};

struct TMagineInfo
{
    QString ip;
    QString port;
    QString user;
    QString password;
};

enum emCompParam
{
    emComp_BlockSignalTable = 0,
    emComp_BlockParamTable,
    emComp_RootInputs,
    emComp_RootOutputs,
    emComp_ModelParamTable,
};

struct TApiInfo
{
    int dataMapIndex;   // 索引
    int dtIndex;        // 数据类型 动态
    int dimNum;         // 维度
    QString compName;
    QString compPort;
};

struct TXmlToModelInfo
{
    int dataMapIndex;   // 索引
    int dtIndex;        // 数据类型 动态
    int outportType;    // 非复合模块为-1，复合模块内部信号：0，复合模块整体输出信号：1
    int dimNum;         // 维度
    std::vector<int> dimentions; // 维度具体数据
};

struct TXmlInfo
{
    bool bOpen;
    QString modelName;
    QString stopTime;
    QString stepSize;

    // Comp Name
    std::unordered_map<std::string, TXmlToModelInfo> mapCompNum;
    // Index, typeName
    std::unordered_map<int, QString> mapIndexType;

    void Clear()
    {
        mapIndexType.clear();
        mapCompNum.clear();
    }
};
#endif

enum emSimDataType
{
    emSimDataType_real = 0,
    emSimDataType_int,
    emSimDataType_bool
};


#define CopyPSZ(src, dst, size) \
{ \
    for (int index = 0; index < size; ++index) \
    { \
        dst[index] = src[index]; \
    }\
}

#define ResetSZ(pSz) \
if (pSz != NULL) \
{ \
    delete[] pSz; \
} \
pSz = NULL;

#endif
