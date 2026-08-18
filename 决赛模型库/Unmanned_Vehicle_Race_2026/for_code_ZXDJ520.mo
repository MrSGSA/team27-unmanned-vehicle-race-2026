model for_code_ZXDJ520 "代码生成部署（电机型号ZXDJ520）"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(modelType = Control,PortArrangement,BlockSystem(blockKind = BlockKind.userModel,SampleTime(auto=true,group = "")=0.02,ExternalCResource(IncludeFile = {"ZXDJ520.h"}, SourceFile = {"ZXDJ520.c"}, Library, IncludeDirectory = {"classDirectory()/Raspberry_Pi_Interface/Source"}, LibraryDirectory = {"classDirectory()/Raspberry_Pi_Interface/Source"}, SavedInRelationPath = false),OutputInterval=0.02),CodeGeneration(Config = {"code_comments":{"blocks":false, "descriptions":false, "eliminated_objects":false, "enable":false, "nested_objects":false}, "code_placement":{"mode":"Compact"}, "code_replacement":{"fixed_point_library":"Fixed-TY", "standard_c_library":"C99"}, "code_report":{"enable":false}, "custom_code":{"code":{"function_declare":{"head":"", "item_head":"", "item_tail":"", "tail":"void Terminate();"}, "function_define":{"head":"", "item_head":"", "item_tail":"", "tail":""}, "global_variable_declare":{"head":"", "item_head":"", "item_tail":"", "tail":""}, "global_variable_define":{"head":"", "item_head":"", "item_tail":"", "tail":"void Terminate()\n{\n  fd = serialOpen(\"/dev/ttyAMA0\", 115200);\n  delayMicroseconds(20000);\n  void vehicle_speed(int, double);\n  vehicle_speed(0, 0);\n}"}, "include":{"head":"", "item_head":"", "item_tail":"", "tail":""}, "macro":{"head":"", "item_head":"", "item_tail":"", "tail":""}, "type":{"head":"#include <wiringPi.h>\n#include <wiringSerial.h>\n#include <softPwm.h>\n#include <signal.h>\n#include <math.h>\n#include <stdlib.h>\n#include <unistd.h>\n\nextern int fd;", "item_head":"", "item_tail":"", "tail":""}}, "code_protection":{"integer_division_by_zero":false, "overflow":false}}, "data_type":{"real_as_float":false}, "experiment":{"task_and_sample":{"muti_task_mode":false}}, "hardware_platform":{"byte_ordering":"Big Endian", "largest_atomic_size":{"floating_point":"32", "integer":"32"}, "number_of_bits":{"char":8, "double":64, "float":32, "int":32, "long":32, "long_long":0, "pointer":32, "ptrdiff_t"
:
32, "size_t":32}, "support_dynamic_memory_allocation":false, "support_float_point"
:true, "target":"get",
"type_platform":"ARM Cortex-M0", "vendor":"中颖科技"}, "identifier":{"format":{"function":"{{model_name}}{{name}}", "global_variable":"{{model_name}}{{data_type}}{{prefix}}{{name}}", "local_variable":"{{data_type}}{{prefix}}{{name}}", "macro":"{{model_name}}{{name}}", "mem_var":"{{model_name}}{{name}}", "type":"{{model_name}}{{name}}"}, "format_string":{"boolean":"b", "input":"in", "integer":"i", "output":"out", "parameter":"p", "real":"r"}, "max_length":32, "style":{"function":"camelCase", "global_variable":"camelCase", "local_variable":"camelCase", "macro":"camelCase", "mem_var":"camelCase", "type":"camelCase"}}, "interface":{"array_layout":"row_major", "function_name":{"initialize":"Init", "step":"Step", "terminate":""}, "generate_a2l_file":false, "generate_capi_for_param":true, "generate_capi_for_root_IO":true, "generate_capi_for_signal":true, "generate_capi_for_state":true, "have_terminate":false, "include_internal_data":false}, "optimization":{"Code":"size", "array_loop_threshold":5, "logical_operator":"logical", "parameter_mode":"tunable"}}, Sim_seting = {"sim_seting":{"output":"C:/Users/TR/Documents/MWORKS/Simulation"}}),version = "26.3.0"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}},
    grid = {2, 2}), graphics = {Rectangle(origin = {0, 0},
    fillColor = {255, 245, 225},
    fillPattern = FillPattern.Solid,
    extent = {{-100, -100}, {100, 100}}), Rectangle(origin = {0, 7.10543e-15},
    lineColor = {0, 0, 0},
    fillColor = {179, 179, 179},
    lineThickness = 1,
    extent = {{-60, 60}, {60, -60}},
    radius = 10), Rectangle(origin = {0, 0},
    lineColor = {0, 0, 0},
    fillColor = {179, 179, 179},
    lineThickness = 1,
    extent = {{-45, 45}, {45, -45}}), Line(origin = {-65.5437, -8},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-65.5437, 24},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-65.5437, 8},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-65.5437, 40},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-65.5437, -24},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-65.5437, -40},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {66.0833, -8},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {66.0833, 24},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {66.0833, 8},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {66.0833, 40},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {66.0833, -24},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {66.0833, -40},
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {8, 65.4261},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-24, 65.4261},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-8, 65.4261},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-40, 65.4261},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {24, 65.4261},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {40, 65.4261},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {8, -65.9799},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-24, -65.9799},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-8, -65.9799},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {-40, -65.9799},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {24, -65.9799},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Line(origin = {40, -65.9799},
    rotation = 90,
    points = {{-5, 0}, {5, 0}},
    thickness = 1,
    smooth = Smooth.Bezier,
    __MWorks_Manhattanize = true), Text(origin = {0, -120},
    extent = {{-150, 20}, {150, -20}},
    textString = "%name",
    fontSize = 14,
    verticalAlignment = TextAlignment.Top)}), experiment(DoublePrecision = false, Interval = -1, Algorithm = Euler, IntegratorStep = -1), Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
grid={2,2}),graphics = {Rectangle(origin={-155.00005,29.9582},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
extent={{-65.6667,86.0418},{65.6667,-86.0418}}), Text(origin={-154,-22},
lineColor={0,0,0},
extent={{-35,10},{35,-10}},
textString="从树莓派获取5个超声波
距离传感器的模型",
fontSize=18,
textStyle={TextStyle.None},
textColor={0,0,0}), Text(origin={-154,-40.0836},
lineColor={255,0,0},
extent={{-46,10},{46,-10}},
textString="参赛选手不需改动此模型",
fontSize=22,
fontName="黑体",
textStyle={TextStyle.None},
textColor={255,0,0}), Rectangle(origin={-6.66665,29.9582},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
extent={{-65.6667,86.0418},{65.6667,-86.0418}}), Text(origin={-5.33335,-42},
lineColor={0,85,255},
extent={{-48.6667,12.0001},{48.6667,-12.0001}},
textString="参赛选手小车控制模型
（基于初赛模型迭代）",
fontSize=22,
fontName="黑体",
textStyle={TextStyle.None},
textColor={0,85,255}), Rectangle(origin={149,29.9582},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
extent={{-67.33335,86.0418},{67.33335,-86.0418}}), Text(origin={152.33335,-24},
lineColor={0,0,0},
extent={{-35,10},{35,-10}},
textString="将车速和转角等数据
发送给树莓派的模型",
fontSize=18,
textStyle={TextStyle.None},
textColor={0,0,0}), Text(origin={152.33335,-42},
lineColor={255,0,0},
extent={{-48.6667,12.0001},{48.6667,-12.0001}},
textString="参赛选手不需改动此模型",
fontSize=22,
fontName="黑体",
textStyle={TextStyle.None},
textColor={255,0,0}), Text(origin={-5.33335,4.0001},
lineColor={0,0,0},
extent={{-57,-12.0001},{57,12.0001}},
textString="左轮：
speed：（前转：-0-300RPM，后转：300-0RPM）",
textStyle={TextStyle.None,TextStyle.Bold},
textColor={0,0,0},
horizontalAlignment=TextAlignment.Left), Text(origin={-5.33335,-21.6939},
lineColor={0,0,0},
extent={{-57,-12.0001},{57,12.0001}},
textString="右轮：
speed：（前转：0-300RPM，后转：-300-0RPM）
",
textStyle={TextStyle.None,TextStyle.Bold},
textColor={0,0,0},
horizontalAlignment=TextAlignment.Left), Text(origin={-5.33335,99.9999},
lineColor={255,0,0},
extent={{-57,-12.0001},{57,12.0001}},
textString="前轮转角steer：
最大不可超过0.6 rad，否则可能导致前轮转向舵机及连杆损坏",
textStyle={TextStyle.Bold},
textColor={255,0,0},
horizontalAlignment=TextAlignment.Left)}));
  SubSystem1 raspberry_SetMsg annotation(Placement(transformation(origin = {152.33335, 52.1873},
    extent = {{-33, -35.4412}, {33, 35.4412}})), __MWORKS(ComponentNamePlacement(BOTTOM), PortLabels(labelType = "SignalName", labels(label(text = "u1", instance = "u1"), label(text = "u2", instance = "u2"), label(text = "u3", instance = "u3"), label(text = "u4", instance = "u4"), label(text = "u5", instance = "u5")))));
  SysplorerEmbeddedCoder.Sources.Constant constant1(k = 0) 
    annotation(Placement(transformation(origin = {71.58333, 59.2755},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(SampleTime(auto = true, group = "D1") = -1, Instance(y(Type(ref = "double"), Dimension = 1), k(Type(ref = "double"), Dimension = 1)))));
  SubSystem subSystem 
    annotation(Placement(transformation(origin = {-5.33335, 52.1873},
    extent = {{-33, -35.4412}, {33, 35.4412}})), __MWORKS(PortLabels(labelType = "PortName")));
  SubSystem2 raspberry_GetMsg 
    annotation(Placement(transformation(origin = {-161.33335, 52.1873},
    extent = {{-33, -35.4412}, {33, 35.4412}})), __MWORKS(PortLabels(labelType = "PortName")));
  SysplorerEmbeddedCoder.MathOperation.Gain gain 
    annotation(Placement(transformation(origin = {-105.58333, 80.54026},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain1 
    annotation(Placement(transformation(origin = {-105.58333, 66.3638},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain2 
    annotation(Placement(transformation(origin = {-105.583, 52.1873},
    extent = {{-5.58333, -6}, {5.58332, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain3 
    annotation(Placement(transformation(origin = {-105.58333, 38.0108},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain4 
    annotation(Placement(transformation(origin = {-105.58333, 23.8343},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain6(k = 1) 
    annotation(Placement(transformation(origin = {71.58333, 80.54026},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain7(k = -1) 
    annotation(Placement(transformation(origin = {71.58333, 38.0108},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain8 
    annotation(Placement(transformation(origin = {71.58333, 22.7461},
    extent = {{-5.58333, -6}, {5.58333, 6}})), __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI = true)))));
  model ModelWorkspace
    annotation(__MWORKS(hide = true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;
  block SubSystem1 "选择子系统模块的设置。 要启用涉及代码生成的相关参数, 请选择 '视为原子单元' 。"
      annotation(__MWORKS(PortArrangement(Left(steer, u4, u5, left_speed, right_speed)),BlockSystem(blockKind = BlockKind.subSystem, SampleTime(auto = true), SubSystem(virtual = true, functionPack = FunctionPack.auto, functionName = "", sourceFile = "")),independentInstance = true,hide = true,sourceModel = SysplorerEmbeddedCoder.SubSystems.SubSystem), Icon(coordinateSystem(extent = {{-300, -120}, {300, 120}}, grid = {2, 2}), graphics = {Rectangle(origin = {0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-300, 120}, {300, -120}}), Text(origin = {6.217248937900877e-15, -142}, lineColor = {0, 0, 0}, extent = {{0, 20}, {0, -20}}, textString = "%name", fontSize = 14, textStyle = {TextStyle.None}, textColor = {0, 0, 0}, verticalAlignment = TextAlignment.Top)}), Protection(access = Access.packageDuplicate), Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
grid={2,2}))
      );
    CCaller c_caller 

      annotation(Placement(transformation(origin={76,132},
extent={{-20,-10},{20,10}})), __MWORKS(BlockSystem(SampleTime(group = "D1") = 0.02)));
    CCaller1 c_caller1 
      annotation(Placement(transformation(origin={76,-48},
extent={{-20,-10},{20,10}})), __MWORKS(BlockSystem(SampleTime(group = "D1") = 0.02)));
    CCaller3 c_caller3 
      annotation(Placement(transformation(origin={76,-84},
extent={{-20,-10},{20,10}})), __MWORKS(BlockSystem(SampleTime(group = "D1") = 0.02)));
    CCaller4 c_caller4 
      annotation(Placement(transformation(origin={76,-130},
extent={{-20,-10},{20,10}})), __MWORKS(BlockSystem(SampleTime(group = "D1") = 0.02)));
    SysplorerEmbeddedCoder.Port.Inport steer 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.auto) = 1, SampleTime(auto = true, group = "D1") = 0.02)), Placement(transformation(origin={44.2,-48},
extent={{-3.6,-3.6},{3.6,3.6}}),
iconTransformation(origin={-301.8,96},
extent={{-1.8,-1.8},{1.8,1.8}})));
    SysplorerEmbeddedCoder.Port.Inport u4 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.auto) = 1, SampleTime(auto = true, group = "D1") = 0.02)), Placement(transformation(origin={44.2,-84},
extent={{-3.6,-3.6},{3.6,3.6}}),
iconTransformation(origin={-301.8,48},
extent={{-1.8,-1.8},{1.8,1.8}})));
    SysplorerEmbeddedCoder.Port.Inport u5 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.auto) = 1, SampleTime(auto = true, group = "D1") = 0.02)), Placement(transformation(origin={44.2,-130},
extent={{-3.6,-3.6},{3.6,3.6}}),
iconTransformation(origin={-301.8,0},
extent={{-1.8,-1.8},{1.8,1.8}})));
    CCaller5 c_caller5 
      annotation (Placement(transformation(origin={76,69},
extent={{-20,-29},{20,29}})),__MWORKS(BlockSystem(SampleTime=-1)));
    SysplorerEmbeddedCoder.Port.Inport left_speed 
      annotation (Placement(transformation(origin={24,54.5},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-301.8,-48},
extent={{-1.8,-1.8},{1.8,1.8}})));
    CCaller2 c_caller2 
      annotation (Placement(transformation(origin={76,7},
extent={{-20,-29},{20,29}})),__MWORKS(BlockSystem(SampleTime=-1)));
    SysplorerEmbeddedCoder.Sources.Constant constant1(k=2) 
      annotation (Placement(transformation(origin={24,83.5},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(y(Type(inherit=InheritType.none,ref="int32"))),SampleTime(auto=true)=-1)));
    SysplorerEmbeddedCoder.Sources.Constant constant2(k=1) 
      annotation (Placement(transformation(origin={24,21.5},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(y(Type(inherit=InheritType.none,ref="int32"))),SampleTime(auto=true)=-1)));
    SysplorerEmbeddedCoder.Port.Inport right_speed 
      annotation (Placement(transformation(origin={24,-7.5},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-301.8,-96},
extent={{-1.8,-1.8},{1.8,1.8}})));
    block CCaller

      annotation(
        __MWORKS(PortArrangement(Left(), Right()), BlockSystem(blockKind = BlockKind.atomic, bltBlockKind = BltBlockKind.ccaller, SampleTime = -1), independentInstance = true, sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller, ExternalFunctionBlock, hide = true),
        Icon(coordinateSystem(extent = {{-200.0, -100.0}, {200.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0}), graphics = {Rectangle(origin = {0.0, 0.0},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0},
        extent = {{-200.0, 20.0}, {200, -20}},
        textString = "rasInit",
        verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0},
        lineColor = {0, 0, 0},
        extent = {{-150, 20}, {150, -20}},
        textString = "%name",
        fontSize = 14,
        textStyle = {TextStyle.None},
        textColor = {0, 0, 0},
        verticalAlignment = TextAlignment.Top)}),
        Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0})));
      function func_CCaller
      external "C" rasInit() 
        annotation(Include = "#include <wiringPi.h>
#include <wiringSerial.h>
#include <softPwm.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

#define Trig1 4     // 传感器 Trig端口
#define Echo1 5    // 正前方传感器 Echo端口
#define Echo2 12    // 正前方舵机传感器 Echo端口
#define Echo3 13    // 右侧方传感器 Echo端口
#define Echo4 14    // 左侧方传感器 Echo端口
#define Echo5 6    // 后方传感器 Echo端口
#define PWM_PIN1 26    // 转向舵机引脚
#define PWM_PIN2 23    // 正前方传感器舵机引脚
#define PWM_PIN3 2    // 后方传感器舵机引脚
#define Zx_Motor_FRAME_HEADER1  0XFA
#define Zx_Motor_FRAME_HEADER2  0XAF
#define Zx_Motor_READ_ANGLE     0X02
#define Zx_Motor_FRAME_END      0XED
#define Zx_Motor_RUNS           0XFD
#define Zx_Motor_RUNN           0XFE
#define uint8     char
#define uint32    unsigned int   
#define GET_LOW_BYTE(A)  ((char)(A))
#define GET_HIGH_BYTE(A) ((char)((A) >> 8))
#define PI acos(-1)
double distances[5];
double SPEED;
int fd=0;

double geted_msg[5];
double vehicle_speed_seted;
double vehicle_gap_seted;
double steer_cmd_seted;
double front_sensor_cmd_seted;
double rear_sensor_cmd_seted;

int rasInit()
{
	 if(wiringPiSetup() == -1)
	 {   
	 	printf(\"硬件初始化失败！\\n\");
	 	return 1;
	 }
  printf(\"wiringPiSetup ok!\\n\");
	pinMode(Trig1, OUTPUT);   // 配置端口为输出模式
	pinMode(Echo1, INPUT);   // 配置端口为输入模式
	pinMode(Echo2, INPUT);   // 配置端口为输入模式
	pinMode(Echo3, INPUT);   // 配置端口为输入模式
	pinMode(Echo4, INPUT);   // 配置端口为输入模式
	pinMode(Echo5, INPUT);   // 配置端口为输入模式
	pullUpDnControl(Echo1, PUD_UP); // 对一个设置 IO 模式为 INPUT 的输入引脚设置拉电阻模式
	pullUpDnControl(Echo2, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo3, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo4, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo5, PUD_UP);	// PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pinMode(PWM_PIN1, PWM_OUTPUT);
	pinMode(PWM_PIN2, PWM_OUTPUT);
	pinMode(PWM_PIN3, OUTPUT);
	pwmSetMode(PWM_MODE_MS);
	pwmSetClock(192);
	pwmSetRange(2000);
	softPwmCreate(PWM_PIN3, 0, 200);
	
  printf(\" Raspberry Pi Setup ok!\\n\");
  fd = serialOpen(\"/dev/ttyAMA0\", 115200);
  if(fd == -1)
  {
    printf(\"open serial failed\\n\");
    while(1)
    {}
  }
	return 0;
}

/**
* @brief  获取超声波传感器探测的距离
**/
double getDistance(int echoPin)
{
	double dis;
	long start;
	long end;
	struct timeval tv1;
	struct timeval tv2;
 
  int cot = 0;

	digitalWrite(Trig1, LOW);   // 先通入低电平，避免后续误差过大
	delayMicroseconds(2);
	digitalWrite(Trig1, HIGH);
	delayMicroseconds(10);   // 树莓派发送 10us 脉冲信号
	digitalWrite(Trig1, LOW);

  while((digitalRead(echoPin) != HIGH)&&(cot++ < 31000)); // HIGH（1），检测到高电平时跳出循环
	gettimeofday(&tv1, NULL);   // 获取时间（此为高电平开始时间）
  cot = 0;
  while((digitalRead(echoPin) != LOW)&&(cot++ < 36000));   // LOW（0），检测到低电平跳出循环
	gettimeofday(&tv2, NULL);   // 获取时间（此为低电平开始时间，即为高电平结束时间）
  cot = 0;
	start = tv1.tv_sec * 1000000 + tv1.tv_usec;   // 单位（微秒）
	end = tv2.tv_sec * 1000000 + tv2.tv_usec;   // 单位（微秒）
	dis = (double)(end - start) / 1000000 * 34000 / 2;   // 距离计算（高电平时间 * 音速 / 2）

	delayMicroseconds(15000);   // 树莓派等待10ms
  return dis;
}


// /**
// * @brief  CRC校验
// * @param[in] inst  buf[]
// */
// char Zx_MotorCheckSum(char buf[])
// {
// 	int i;
// 	unsigned int sum = 0;
// 	for (i = 2; i < 8; i++)
// 	{
// 		sum += buf[i];
// 	}
// 	if (sum > 255)sum &= 0x00FF;
// 	return sum;
// }

// /**
// * @brief  电机正转
// * @param[in] inst  fd:串口标识位
// * @param[in] inst  id:电机id号
// * @param[in] inst  speed:车速
// */
// void Zx_MotorRunS(double id, double speed)
// {
// 	int rpm = speed / (2 * PI * 3.4) * 60;
// 	int idi = (int)id;
// 	char  buf[10];
// 	buf[0] = 0XFA;
// 	buf[1] = 0XAF;
// 	buf[2] = idi;
// 	buf[3] = 0x01;
// 	buf[4] = 0XFD;
// 	buf[5] = 0x00;
// 	buf[6] = (char)((rpm) >> 8);
// 	buf[7] = (char)(rpm);
// 	buf[8] = Zx_MotorCheckSum(buf);
// 	buf[9] = 0XED;
// 	write(fd, buf, 10);//将指令发送出去
// 	delayMicroseconds(10000);   // 树莓派等待50ms
// }

// /**
// * @brief  电机反转
// * @param[in] inst  fd:串口标识位
// * @param[in] inst  id:电机id号
// * @param[in] inst  rpm:给定电机转速
// */
// void Zx_MotorRunN(double id, double speed)
// {
// 	int rpm = speed / (2 * PI * 3.4) * 60;
// 	int idi = (int)id;
// 	char  buf[10];
// 	buf[0] = 0XFA;
// 	buf[1] = 0XAF;
// 	buf[2] = idi;
// 	buf[3] = 0x01;
// 	buf[4] = 0XFE;
// 	buf[5] = 0x00;
// 	buf[6] = (char)((rpm) >> 8);
// 	buf[7] = (char)(rpm);
// 	buf[8] = Zx_MotorCheckSum(buf);
// 	buf[9] = 0XED;
// 	write(fd, buf, 10);//将指令发送出去
// 	delayMicroseconds(10000);   // 树莓派等待50ms
// }

// /**
// * @brief  获取电机转速
// * @param[in] inst  fd:串口文件描述符
// * @param[in] inst  id:电机ID号
// */
// double GetMotorSpeed(double id)
// {
// 	int idi = (int)id;
// 	int rpm;
// 	double speed;
// 	int n;
// 	char  buf[10];
// 	buf[0] = 0XFA;
// 	buf[1] = 0XAF;
// 	buf[2] = idi;
// 	buf[3] = 0X02;
// 	buf[4] = 0X00;
// 	buf[5] = 0x00;
// 	buf[6] = 0x00;
// 	buf[7] = 0x00;
// 	buf[8] = Zx_MotorCheckSum(buf);
// 	buf[9] = 0XED;
// 	write(fd, buf, 10);//将指令发送出去

// 	n = read(fd,buf,10);
// 	if(n!=0)
// 	{
// 		rpm = buf[7];
// 		//printf(\"speed = %d\\n rpm\",rpm);
// 	}
// 	speed = rpm * 2 * PI * 3.4 / 60;
//   printf(\"speed = %d\\n \",speed);
// 	return speed;
// }

// /**
// * @brief  运行小车
// * @param[in] inst  fd:串口文件描述符
// * @param[in] inst  speed:车速
// * @param[in] inst  gap:差速
// */
// void vehicle_speed(double speed, double gap)
// {
//   vehicle_speed_seted=speed;
//   vehicle_gap_seted=gap;
  
//   if(gap > 0.00001)
//   {
//     gap = gap-(speed*0.1);//标定值
//   }
//   else
//   {
//     gap=0;
//   }
	
  
// 	if(speed > 0)
// 	{
// 		Zx_MotorRunN(2, speed+gap);   //电机2正转
// 		Zx_MotorRunS(1, speed-gap);   //电机1正转
// 	}
// 	else
// 	{
// 		Zx_MotorRunS(2, fabs(speed)+gap);   //电机2反转
// 		Zx_MotorRunN(1, fabs(speed)-gap);   //电机1反转
// 	}
//   printf(\"\\n rigth speed = %5.2fcm, left speed= %5.2fcm\\n\", speed+gap, speed-gap);
// 	return;
// }

void steer_cmd(double steer)
{
steer_cmd_seted=steer;

	int PulseWidth;
	PulseWidth = (int)(steer*100+150);
	pwmWrite(PWM_PIN1 ,PulseWidth);
  printf(\"steer_cmd:%f\\n\", steer);
  return;
	
}

void front_sensor_cmd(double steer)
{
front_sensor_cmd_seted=steer;

	int PulseWidth;
	PulseWidth = (int)(steer*100+150);
	pwmWrite(PWM_PIN2 ,PulseWidth);
  return;
}

void rear_sensor_cmd(double angle)
{
rear_sensor_cmd_seted=angle;

	int cmd = angle * 20 / 180 + 5;
	softPwmWrite(PWM_PIN3, cmd);
	return;
  //printf(\"可变雷达角度:%f\\n\", angle);
}

/**
* @brief  复位
*/


void wait(double delayTime)
{
  delayMicroseconds(delayTime * 1000000);
}

void GetCarMsg(double* sensor1_distence,double* sensor2_distence,double* sensor3_distence,double* sensor4_distence,double* sensor5_distence)
{
	// 获取传感器探测的距离
	*sensor1_distence=getDistance(Echo1);
	*sensor2_distence=getDistance(Echo2);
	*sensor3_distence=getDistance(Echo3);
	*sensor4_distence=getDistance(Echo4);
	*sensor5_distence=getDistance(Echo5);	
  
  geted_msg[0]= *sensor1_distence;
  geted_msg[1]= *sensor2_distence;
  geted_msg[2]= *sensor3_distence;
  geted_msg[3]= *sensor4_distence;
  geted_msg[4]= *sensor5_distence;  
  printf(\"sensor out: front| fl|right| left| fr|\\n\");
  printf(\"sensor out: %5.1f|%5.1f|%5.1f|%5.1f|%5.1f|\\n\",*sensor1_distence ,*sensor2_distence,*sensor3_distence,*sensor4_distence,*sensor5_distence);
}
"      );
      end func_CCaller;
    initial equation

      func_CCaller();
    end CCaller;
    block CCaller1

      annotation(
        __MWORKS(PortArrangement(Left(src), Right(out)), BlockSystem(blockKind = BlockKind.atomic, bltBlockKind = BltBlockKind.ccaller, SampleTime = -1), independentInstance = true, sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller, ExternalFunctionBlock, hide = true),
        Icon(coordinateSystem(extent = {{-200.0, -100.0}, {200.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0}), graphics = {Rectangle(origin = {0.0, 0.0},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0},
        extent = {{-200.0, 20.0}, {200, -20}},
        textString = "steer_cmd",
        verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0},
        lineColor = {0, 0, 0},
        extent = {{-150, 20}, {150, -20}},
        textString = "%name",
        fontSize = 14,
        textStyle = {TextStyle.None},
        textColor = {0, 0, 0},
        verticalAlignment = TextAlignment.Top)}),
        Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0})));
      function func_CCaller1
        input SysplorerEmbeddedCoder.Types.Auto src annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.none) = 1)));
      external "C" steer_cmd(src);
      end func_CCaller1;
      SysplorerEmbeddedCoder.Port.Inport src 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}})));
    equation
      func_CCaller1(src);
    end CCaller1;
    block CCaller3

      annotation(
        __MWORKS(PortArrangement(Left(src), Right(out)), BlockSystem(blockKind = BlockKind.atomic, bltBlockKind = BltBlockKind.ccaller, SampleTime = -1), independentInstance = true, sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller, ExternalFunctionBlock, hide = true),
        Icon(coordinateSystem(extent = {{-200.0, -100.0}, {200.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0}), graphics = {Rectangle(origin = {0.0, 0.0},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0},
        extent = {{-200.0, 20.0}, {200, -20}},
        textString = "front_sensor_cmd",
        verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0},
        lineColor = {0, 0, 0},
        extent = {{-150, 20}, {150, -20}},
        textString = "%name",
        fontSize = 14,
        textStyle = {TextStyle.None},
        textColor = {0, 0, 0},
        verticalAlignment = TextAlignment.Top)}),
        Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0})));
      function func_CCaller3
        input SysplorerEmbeddedCoder.Types.Auto src annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.none) = 1)));
      external "C" front_sensor_cmd(src);
      end func_CCaller3;
      SysplorerEmbeddedCoder.Port.Inport src 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}})));
    equation
      func_CCaller3(src);
    end CCaller3;
    block CCaller4

      annotation(
        __MWORKS(PortArrangement(Left(src), Right(out)), BlockSystem(blockKind = BlockKind.atomic, bltBlockKind = BltBlockKind.ccaller, SampleTime = -1), independentInstance = true, sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller, ExternalFunctionBlock, hide = true),
        Icon(coordinateSystem(extent = {{-200.0, -100.0}, {200.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0}), graphics = {Rectangle(origin = {0.0, 0.0},
        fillColor = {255, 255, 255},
        fillPattern = FillPattern.Solid,
        extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0},
        extent = {{-200.0, 20.0}, {200, -20}},
        textString = "rear_sensor_cmd",
        verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0},
        lineColor = {0, 0, 0},
        extent = {{-150, 20}, {150, -20}},
        textString = "%name",
        fontSize = 14,
        textStyle = {TextStyle.None},
        textColor = {0, 0, 0},
        verticalAlignment = TextAlignment.Top)}),
        Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}},
        preserveAspectRatio = false,
        initialScale = 0.1,
        grid = {2.0, 2.0})));
      function func_CCaller4
        input SysplorerEmbeddedCoder.Types.Auto src annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.none) = 1)));
      external "C" rear_sensor_cmd(src);
      end func_CCaller4;
      SysplorerEmbeddedCoder.Port.Inport src 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"), Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}})));
    equation
      func_CCaller4(src);
    end CCaller4;
    block CCaller5
      annotation(
         __MWORKS(PortArrangement(Left(id,speed), Right()),PortLabels(labelType="CustomType",labels(label(text="id",instance="id"),label(text="speed",instance="speed"))), BlockSystem(CCaller(currentFile = "ZXDJ520.h"), blockKind = BlockKind.atomic, bltBlockKind = BltBlockKind.ccaller), independentInstance = true, sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller, ExternalFunctionBlock, hide = true),
              Icon(coordinateSystem(extent = { {-200.0, -100.0}, {200.0, 100.0} },
              preserveAspectRatio = false,
              initialScale = 0.1,
              grid = { 2.0, 2.0 }), graphics = { Rectangle(sizePolicy=SizePolicy.Expanding,
              rotationPolicy = RotationPolicy.Follow, origin = { 0.0, 0.0 },
              fillColor = {255, 255, 255},
              fillPattern = FillPattern.Solid,
              extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0},
              extent = {{-100.0, 20.0}, {100, -20}},
              textString = "vehicle_speed",
              fontSize=15, textStyle = { TextStyle.None },
             verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0},
              lineColor = {0, 0, 0},
              extent = {{-150, 20}, {150, -20}},
              textString = "%name",
              fontSize = 14,
             textStyle = {TextStyle.None},
              textColor = {0, 0, 0},
              verticalAlignment = TextAlignment.Top) },sizePolicy=SizePolicy.Fixed,rotationPolicy=RotationPolicy.Ignore),
          Diagram(coordinateSystem(extent = { {-100.0, -100.0}, {100.0, 100.0} },
              preserveAspectRatio = false,
              initialScale = 0.1,
              grid = { 2.0, 2.0 })));
    function CCallerFunction
      input SysplorerEmbeddedCoder.Types.Auto id annotation(__MWORKS(BlockSystem(CParamName = "id", Type(inherit = InheritType.none, ref="int32"), Dimension(dimensionType = DimensionType.none) = 1)));

      input SysplorerEmbeddedCoder.Types.Auto speed annotation(__MWORKS(BlockSystem(CParamName = "speed", Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));

    external "C" vehicle_speed(id, speed) annotation(__MWORKS(BlockSystem(functionProto = "void  vehicle_speed(int id,double speed)")));
    end CCallerFunction;
      SysplorerEmbeddedCoder.Port.Inport id 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "int32"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Inport speed 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));

    equation

      CCallerFunction(id, speed);
    end CCaller5;
    block CCaller2
      annotation(
         __MWORKS(PortArrangement(Left(id,speed), Right()),PortLabels(labelType="CustomType",labels(label(text="id",instance="id"),label(text="speed",instance="speed"))), BlockSystem(CCaller(currentFile = "ZXDJ520.h"), blockKind = BlockKind.atomic, bltBlockKind = BltBlockKind.ccaller), independentInstance = true, sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller, ExternalFunctionBlock, hide = true),
              Icon(coordinateSystem(extent = { {-200.0, -100.0}, {200.0, 100.0} },
              preserveAspectRatio = false,
              initialScale = 0.1,
              grid = { 2.0, 2.0 }), graphics = { Rectangle(sizePolicy=SizePolicy.Expanding,
              rotationPolicy = RotationPolicy.Follow, origin = { 0.0, 0.0 },
              fillColor = {255, 255, 255},
              fillPattern = FillPattern.Solid,
              extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0},
              extent = {{-100.0, 20.0}, {100, -20}},
              textString = "vehicle_speed",
              fontSize=15, textStyle = { TextStyle.None },
             verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0},
              lineColor = {0, 0, 0},
              extent = {{-150, 20}, {150, -20}},
              textString = "%name",
              fontSize = 14,
             textStyle = {TextStyle.None},
              textColor = {0, 0, 0},
              verticalAlignment = TextAlignment.Top) },sizePolicy=SizePolicy.Fixed,rotationPolicy=RotationPolicy.Ignore),
          Diagram(coordinateSystem(extent = { {-100.0, -100.0}, {100.0, 100.0} },
              preserveAspectRatio = false,
              initialScale = 0.1,
              grid = { 2.0, 2.0 })));
    function CCallerFunction
      input SysplorerEmbeddedCoder.Types.Auto id annotation(__MWORKS(BlockSystem(CParamName = "id", Type(inherit = InheritType.none, ref="int32"), Dimension(dimensionType = DimensionType.none) = 1)));

      input SysplorerEmbeddedCoder.Types.Auto speed annotation(__MWORKS(BlockSystem(CParamName = "speed", Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));

    external "C" vehicle_speed(id, speed) annotation(__MWORKS(BlockSystem(functionProto = "void  vehicle_speed(int id,double speed)")));
    end CCallerFunction;
      SysplorerEmbeddedCoder.Port.Inport id 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "int32"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Inport speed 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));

    equation

      CCallerFunction(id, speed);
    end CCaller2;

  equation
    connect(steer, c_caller1.src) 
      annotation(Line(origin={0,-54},
points={{49.7582,6.03045},{54.2,6}},
color={0,0,0}));
    connect(u4, c_caller3.src) 
      annotation(Line(origin={0,-54},
points={{49.7582,-29.9695},{54.2,-30}},
color={0,0,0}));
    connect(u5, c_caller4.src) 
      annotation(Line(origin={0,-54},
points={{49.7582,-75.9695},{54.2,-76}},
color={0,0,0}));
    connect(c_caller5.speed, left_speed) 
    annotation(Line(origin={45,55},
points={{9.2,-0.5},{-8.99997,-0.5}},
color={0,0,0}));
    connect(constant1.y, c_caller5.id) 
    annotation(Line(origin={45,84},
    points={{-9.2,-0.5},{9.2,-0.5}},
    color={0,0,0}));
    connect(c_caller2.id, constant2.y) 
    annotation(Line(origin={45,22},
    points={{9.2,-0.5},{-9.2,-0.5}},
    color={0,0,0}));
    connect(c_caller2.speed, right_speed) 
    annotation(Line(origin={45,-7},
    points={{9.2,-0.5},{-8.99997,-0.5}},
    color={0,0,0}));
    end SubSystem1;
  block SubSystem2 "选择子系统模块的设置。 要启用涉及代码生成的相关参数, 请选择 '视为原子单元' 。"

    annotation (defaultComponentName="subSystem", __MWORKS(PortArrangement(Right(dis1, dis2, dis3, dis4, dis5)),BlockSystem(blockKind=BlockKind.subSystem, SampleTime(auto=true), SubSystem(virtual=true, functionPack=FunctionPack.auto, functionName="", sourceFile="")),PortLabels(labelType="PortName"),sourceModel=SysplorerEmbeddedCoder.SubSystems.SubSystem,independentInstance=true,hide=true), Icon(coordinateSystem(extent={{-300,-120},{300,120}},
  grid={2,2}),graphics = {Rectangle(sizePolicy=SizePolicy.Expanding,
  rotationPolicy=RotationPolicy.Follow,
  origin={0,0},
  fillColor={255,255,255},
  fillPattern=FillPattern.Solid,
  lineThickness=3,
  extent={{-300,120},{300,-120}}), Text(origin={0,-140},
  lineColor={0,0,0},
  extent={{0,-20},{0,20}},
  textString="%name",
  fontSize=14,
  textStyle={TextStyle.None},
  textColor={0,0,0},
  verticalAlignment=TextAlignment.Top)},sizePolicy=SizePolicy.Fixed,rotationPolicy=RotationPolicy.Ignore),Protection(access=Access.packageDuplicate),Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
grid={2,2})));
    block CCaller1

        annotation(
         __MWORKS(PortArrangement(Left(fd), Right(sensor1_distence,sensor2_distence,sensor3_distence,sensor4_distence,sensor5_distence)),BlockSystem(blockKind = BlockKind.atomic,bltBlockKind = BltBlockKind.ccaller,SampleTime=-1),independentInstance = true,sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller,ExternalFunctionBlock,hide = true),
              Icon(coordinateSystem(extent = { {-200.0, -100.0}, {200.0, 100.0} },
              preserveAspectRatio = false,
              initialScale = 0.1,
              grid = { 2.0, 2.0 }), graphics = { Rectangle(origin = {0.0, 0.0},
              fillColor = {255, 255, 255},
              fillPattern = FillPattern.Solid,
              extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0},
              extent = {{-200.0, 20.0}, {200, -20}},
              textString = "GetCarMsg",
              verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0},
              lineColor = {0, 0, 0},
              extent = {{-150, 20}, {150, -20}},
              textString = "%name",
              fontSize = 14,
             textStyle = {TextStyle.None},
              textColor = {0, 0, 0},
              verticalAlignment = TextAlignment.Top) }),
          Diagram(coordinateSystem(extent = { {-100.0, -100.0}, {100.0, 100.0} },
              preserveAspectRatio = false,
              initialScale = 0.1,
              grid = { 2.0, 2.0 })));
      function func_CCaller1
      output SysplorerEmbeddedCoder.Types.Auto sensor1_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
      output SysplorerEmbeddedCoder.Types.Auto sensor2_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
      output SysplorerEmbeddedCoder.Types.Auto sensor3_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
      output SysplorerEmbeddedCoder.Types.Auto sensor4_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
      output SysplorerEmbeddedCoder.Types.Auto sensor5_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    external "C" GetCarMsg(sensor1_distence,sensor2_distence,sensor3_distence,sensor4_distence,sensor5_distence);
    end func_CCaller1;
        SysplorerEmbeddedCoder.Port.Outport sensor1_distence 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
        SysplorerEmbeddedCoder.Port.Outport sensor2_distence 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
        SysplorerEmbeddedCoder.Port.Outport sensor3_distence 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
        SysplorerEmbeddedCoder.Port.Outport sensor4_distence 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
        SysplorerEmbeddedCoder.Port.Outport sensor5_distence 
        annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      equation

      (sensor1_distence, sensor2_distence, sensor3_distence, sensor4_distence, sensor5_distence) = func_CCaller1();
    end CCaller1;
    CCaller1 c_caller1 
      annotation (Placement(transformation(origin={-223.75,113.373},
extent={{-28,-45.6667},{28,45.6667}})),__MWORKS(ComponentNamePlacement(BOTTOM),BlockSystem(SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.Port.Outport dis1 
      annotation (Placement(transformation(origin={-134.75,149.906},
extent={{-6.5,-6.5},{6.5,6.5}}),
iconTransformation(origin={101.8,80},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.Port.Outport dis2 
      annotation (Placement(transformation(origin={-134.75,131.639},
extent={{-6.5,-6.5},{6.5,6.5}}),
iconTransformation(origin={101.8,40},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.Port.Outport dis3 
      annotation (Placement(transformation(origin={-134.75,113.373},
extent={{-6.5,-6.5},{6.5,6.5}}),
iconTransformation(origin={101.8,0},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.Port.Outport dis4 
      annotation (Placement(transformation(origin={-134.75,95.1058},
extent={{-6.5,-6.5},{6.5,6.5}}),
iconTransformation(origin={101.8,-40},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.Port.Outport dis5 
      annotation (Placement(transformation(origin={-134.75,76.8391},
extent={{-6.5,-6.5},{6.5,6.5}}),
iconTransformation(origin={101.8,-80},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  equation
    connect(c_caller1.sensor1_distence, dis1) 
    annotation(Line(origin={-171.75,126.039},
    points={{-22.2,23.86676},{28.5007,23.8837}},
    color={0,0,0}));
    connect(c_caller1.sensor2_distence, dis2) 
    annotation(Line(origin={-171.75,112.039},
    points={{-22.2,19.6001},{28.5007,19.6167}},
    color={0,0,0}));
    connect(c_caller1.sensor3_distence, dis3) 
    annotation(Line(origin={-171.75,97.0391},
    points={{-22.2,16.3334},{28.5007,16.3501}},
    color={0,0,0}));
    connect(c_caller1.sensor4_distence, dis4) 
    annotation(Line(origin={-171.75,82.0391},
    points={{-22.2,13.0667},{28.5007,13.0834}},
    color={0,0,0}));
    connect(c_caller1.sensor5_distence, dis5) 
    annotation(Line(origin={-171.75,68.0391},
    points={{-22.2,8.80004},{28.5007,8.81666}},
    color={0,0,0}));
    end SubSystem2;
  block SubSystem "选择子系统模块的设置。 要启用涉及代码生成的相关参数, 请选择 '视为原子单元' 。"

    annotation (defaultComponentName="subSystem", __MWORKS(PortArrangement(Left(sensor1, sensor2, sensor3, sensor4, sensor5), Right(speed, steer)),BlockSystem(blockKind=BlockKind.subSystem, SampleTime(auto=true), SubSystem(virtual=true, functionPack=FunctionPack.auto, functionName="", sourceFile="")),PortLabels(labelType="PortName"),sourceModel=SysplorerEmbeddedCoder.SubSystems.SubSystem,independentInstance=true,hide=true), Icon(coordinateSystem(extent={{-300,-120},{300,120}},
  grid={2,2}),graphics = {Rectangle(sizePolicy=SizePolicy.Expanding,
  rotationPolicy=RotationPolicy.Follow,
  origin={0,0},
  fillColor={255,255,255},
  fillPattern=FillPattern.Solid,
  lineThickness=3,
  extent={{-300,120},{300,-120}}), Text(origin={0,-140},
  lineColor={0,0,0},
  extent={{0,-20},{0,20}},
  textString="%name",
  fontSize=14,
  textStyle={TextStyle.None},
  textColor={0,0,0},
  verticalAlignment=TextAlignment.Top)},sizePolicy=SizePolicy.Fixed,rotationPolicy=RotationPolicy.Ignore),Protection(access=Access.packageDuplicate),Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
grid={2,2}),graphics = {Text(origin={106,157.373},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="预期车速",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={106,67.8725},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="前轮转角",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-289,157.373},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="1号传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-289,115.372875},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="2号传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-289,31.372625},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="4号传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-289,73.37275},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="3号传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-289,-10.6275},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="5号传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0})}));
    SysplorerEmbeddedCoder.MathOperation.Gain gain1(k=-1) 
      annotation (Placement(transformation(origin={-33,157.373},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1) ,k(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.MathOperation.Abs abs5 
      annotation (Placement(transformation(origin={-213,-10.6275},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Discontinuities.Saturation saturation(zeroCross=true,upLimit=0.6,lowLimit=-0.6) 
      annotation (Placement(transformation(origin={25,67.8725},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(zeroCross=true ,Instance(dynamicSaturation(upperLimit(Type(ref="double") ,Dimension=1) ,u(Type(ref="double") ,Dimension=1) ,lowerLimit(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)) ,u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1) ,constant_up(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="") ,Dimension=1)) ,constant_low(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="") ,Dimension=1)) ,upLimit(Type(ref="") ,Dimension=1) ,lowLimit(Type(ref="") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.MathOperation.Abs abs4 
      annotation (Placement(transformation(origin={-213,73.3725},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.MathOperation.Abs abs3 
      annotation (Placement(transformation(origin={-213,31.3726298},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.MathOperation.Abs abs2 
      annotation (Placement(transformation(origin={-213,115.373},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.MathOperation.Abs abs1 
      annotation (Placement(transformation(origin={-213,157.373},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.MathOperation.Gain gain(k=2*pi) 
      annotation (Placement(transformation(origin={-21,115.373},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1) ,k(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Sources.Constant constant2(k=2*pi) 
      annotation (Placement(transformation(origin={-63,41.3725},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true,group="D1")=0.02,Instance(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="double") ,Dimension=1)))));
    SysplorerEmbeddedCoder.MathOperation.Product product1(isSaturate=false,inputs="*/") 
      annotation (Placement(transformation(origin={-21,67.8725},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double") ,Dimension=1) ,u2(Type(ref="double") ,Dimension=1)) ,y(Type(ref="double") ,Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap) ,SampleTime(group="D1")=0.02),PortLabels(labelType="CustomType",labels(label(text="*",instance="u1"),label(text="/",instance="u2")))));
    SysplorerEmbeddedCoder.MathOperation.RoundingFunction roundingFunction 
      annotation (Placement(transformation(origin={-53,115.373},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Sources.Constant constant1(k=pi) 
      annotation (Placement(transformation(origin={-114,41.3725},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true,group="D1")=0.02,Instance(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="double") ,Dimension=1)))));
    SysplorerEmbeddedCoder.MathOperation.Sum sum2(isSaturate=false,inputs="++") 
      annotation (Placement(transformation(origin={-63,72.8725},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double") ,Dimension=1) ,u2(Type(ref="double") ,Dimension=1)) ,y(Type(ref="double") ,Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap) ,SampleTime(group="D1")=0.02),PortLabels(labelType="CustomType",labels(label(text="+",instance="u1"),label(text="+",instance="u2")))));
    SysplorerEmbeddedCoder.MathOperation.Sum sum1(isSaturate=false,inputs="+-") 
      annotation (Placement(transformation(origin={25,127.373},
  extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double") ,Dimension=1) ,u2(Type(ref="double") ,Dimension=1)) ,y(Type(ref="double") ,Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap) ,SampleTime(group="D1")=0.02),PortLabels(labelType="CustomType",labels(label(text="+",instance="u1"),label(text="-",instance="u2")))));
    SysplorerEmbeddedCoder.Port.Outport speed 
      annotation (Placement(transformation(origin={63,157.373},
  extent={{-10,-10},{10,10}}),
  iconTransformation(origin={301.8,60},
  extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Port.Inport sensor1 
      annotation (Placement(transformation(origin={-251,157.373},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-301.8,96},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Port.Outport steer 
      annotation (Placement(transformation(origin={63,67.8725},
  extent={{-10,-10},{10,10}}),
  iconTransformation(origin={301.8,-60},
  extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Port.Inport sensor2 
      annotation (Placement(transformation(origin={-251,115.372875},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-301.8,48},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Port.Inport sensor3 
      annotation (Placement(transformation(origin={-251,73.37275},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-301.8,0},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Port.Inport sensor4 
      annotation (Placement(transformation(origin={-251,31.372625},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-301.8,-48},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
    SysplorerEmbeddedCoder.Port.Inport sensor5 
      annotation (Placement(transformation(origin={-251,-10.6275},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-301.8,-96},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
    Chart chart 
      annotation (Placement(transformation(origin={-133,92.3725},
extent={{-29,-29},{29,29}})),__MWORKS(ComponentNamePlacement(BOTTOM),BlockSystem(SampleTime(group="D1")=0.02)));
    block Chart "状态机"
      annotation (__MWORKS(BlockSystem(blockKind = BlockKind.stateMachine,SampleTime(auto = true),independent = true,StateMachine(virtual = false,functionPack = FunctionPack.auto,functionName = "",sourceFile = "",parallel=true)),PortArrangement(Left(df, db, dr, dl, dfu),Right(speed, steer)),sourceModel=SysplorerEmbeddedCoder.StateMachine.Chart,independentInstance=true,hide=true),
        defaultComponentName = "chart",
        Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}},
          grid = {2.0, 2.0}), graphics = {Rectangle(origin = {0.0, 0.0},
          lineColor = {74, 84, 154},
          fillColor = {255, 255, 255},
          lineThickness = 1.0,
          extent = {{-100.0, 100.0}, {100.0, -100.0}},
          radius = 11.0), Rectangle(origin = {0.0, 27.0},
          lineColor = {74, 84, 154},
          fillColor = {255, 255, 255},
          lineThickness = 1.0,
          extent = {{-25.0, 20.0}, {25.0, -20.0}},
          radius = 10.0), Rectangle(origin = {-40.0, -27.0},
          lineColor = {74, 84, 154},
          fillColor = {255, 255, 255},
          lineThickness = 1.0,
          extent = {{-25.0, 20.0}, {25.0, -20.0}},
          radius = 10.0), Rectangle(origin = {40.0, -27.0},
          lineColor = {74, 84, 154},
          fillColor = {255, 255, 255},
          lineThickness = 1.0,
          extent = {{-25.0, 20.0}, {25.0, -20.0}},
          radius = 10.0), Line(origin = {-40.0, 13.0},
          points = {{-10.0, -13.0}, {-10.0, 7.0}, {10.0, 13.0}},
          color = {74, 84, 154},
          thickness = 1.0,
          arrow = {Arrow.None, Arrow.Filled},
          arrowSize = 8.0,
          smooth = Smooth.Bezier), Line(origin = {41.0, 13.0},
          points = {{-9.0, 13.0}, {9.0, 11.0}, {9.0, -13.0}},
          color = {74, 84, 154},
          thickness = 1.0,
          arrow = {Arrow.None, Arrow.Filled},
          arrowSize = 8.0,
          smooth = Smooth.Bezier), Line(origin = {0.0, -28.0},
          points = {{10.0, 0.0}, {-10.0, 0.0}},
          color = {74, 84, 154},
          thickness = 1.0,
          arrow = {Arrow.None, Arrow.Filled},
          arrowSize = 8.0,
          smooth = Smooth.Bezier), Text(origin = {0.0, -120.0},
          lineColor = {74, 84, 154},
          extent = {{0, 20.0}, {0, -20.0}},
          textString = "%name",
          fontSize = 14,
          textStyle = {TextStyle.None},
          textColor = {74, 84, 154},
          verticalAlignment = TextAlignment.Top)}),Protection(access=Access.packageDuplicate),Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
    grid={2,2})));
      SysplorerEmbeddedCoder.Port.Inport df annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
      SysplorerEmbeddedCoder.Port.Inport db annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
      SysplorerEmbeddedCoder.Port.Inport dr annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
      SysplorerEmbeddedCoder.Port.Inport dl annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
      SysplorerEmbeddedCoder.Port.Outport speed(start=0) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
      SysplorerEmbeddedCoder.Port.Outport steer(start=0) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
      SysplorerEmbeddedCoder.Types.Auto mindis(start=10) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Types.Auto safeF(start=40) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      State longitudinal 
        annotation (Placement(transformation(origin={-224,-505},
    extent={{-184,-95},{184,95}})),__MWORKS(BlockSystem(StateMachine(priority=1))));
      SysplorerEmbeddedCoder.Types.Auto flag(start=false) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="boolean"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Types.Auto speedC(start=10) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Types.Auto speedA(start=-5) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Types.Auto steerA(start=0.523) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Port.Inport dfu annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
      State1 lateral 
        annotation (Placement(transformation(origin={-29,-264},
    extent={{-379,-138},{379,138}})),__MWORKS(BlockSystem(StateMachine(priority=2))));
      SysplorerEmbeddedCoder.Types.Auto safeFLR(start=20) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Types.Auto flagS(start=false) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="boolean"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Types.Auto fu_disl annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      SysplorerEmbeddedCoder.Types.Auto fu_disr annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
      block State "状态"
        annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
         Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
           grid={2, 2}), graphics={Rectangle(origin = {0, 0},
           lineColor = {74, 84, 154},
           fillColor = {255, 255, 255},
           lineThickness = 1,
           extent = {{-100, 100}, {100, -100}},
           radius = 11), Line(origin = {0, 80},
           points = {{-100, 0}, {100, 0}},
           color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
           lineColor = {0, 0, 128},
           extent = {{-100, 10}, {100, -10}},
           textString = "%name",
           textStyle = {TextStyle.None},
           textColor = {0, 0, 128}), Text(origin = {0, -10},
           lineColor = {0, 0, 128},
           extent = {{-100, 90}, {100, -90}},
           textString = "algorithm",
           fontSize = 16,
           textStyle = {TextStyle.None},
           textColor = {0, 0, 128},
           horizontalAlignment = TextAlignment.Left,
           verticalAlignment = TextAlignment.Top)}),
         Diagram(coordinateSystem(extent={{-184,-95},{184,95}},
    initialScale=1,
    grid={2,2}),graphics = {State(origin={0,0},
    stateTitle=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-182,87},{182,95}},
    textString="%name",
    fontSize=16,
    textStyle={TextStyle.Bold},
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left),
    stateText=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-182,-95},{182,87}},
    textString="%algorithm",
    fontSize=16,
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left,
    verticalAlignment=TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
        block State2 "状态"
          annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
           Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
             grid={2, 2}), graphics={Rectangle(origin = {0, 0},
             lineColor = {74, 84, 154},
             fillColor = {255, 255, 255},
             lineThickness = 1,
             extent = {{-100, 100}, {100, -100}},
             radius = 11), Line(origin = {0, 80},
             points = {{-100, 0}, {100, 0}},
             color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
             lineColor = {0, 0, 128},
             extent = {{-100, 10}, {100, -10}},
             textString = "%name",
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128}), Text(origin = {0, -10},
             lineColor = {0, 0, 128},
             extent = {{-100, 90}, {100, -90}},
             textString = "algorithm",
             fontSize = 16,
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128},
             horizontalAlignment = TextAlignment.Left,
             verticalAlignment = TextAlignment.Top)}),
           Diagram(coordinateSystem(extent={{-54,-34.5},{54,34.5}},
    initialScale=1,
    grid={2,2}),graphics = {State(origin={0,0},
    stateTitle=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-52,26.5},{52,34.5}},
    textString="%name",
    fontSize=16,
    textStyle={TextStyle.Bold},
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left),
    stateText=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-52,-34.5},{52,26.5}},
    textString="%algorithm",
    fontSize=16,
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left,
    verticalAlignment=TextAlignment.Top),
    stateLine = Line(origin={0,0},
    color = {74, 84, 154},
    points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
        algorithm
        annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  speed := -60;
          flag := false;
        end State2;
        State2 cruise 
        annotation(Placement(transformation(origin={-120,23.5},
    extent={{-54,-34.5},{54,34.5}})),__MWORKS(BlockSystem(StateMachine)));
        State1 avoid 
          annotation (Placement(transformation(origin={91,21},
    extent={{-55,-32},{55,32}})),__MWORKS(BlockSystem(StateMachine)));
        block State1 "状态"
          annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
           Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
             grid={2, 2}), graphics={Rectangle(origin = {0, 0},
             lineColor = {74, 84, 154},
             fillColor = {255, 255, 255},
             lineThickness = 1,
             extent = {{-100, 100}, {100, -100}},
             radius = 11), Line(origin = {0, 80},
             points = {{-100, 0}, {100, 0}},
             color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
             lineColor = {0, 0, 128},
             extent = {{-100, 10}, {100, -10}},
             textString = "%name",
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128}), Text(origin = {0, -10},
             lineColor = {0, 0, 128},
             extent = {{-100, 90}, {100, -90}},
             textString = "algorithm",
             fontSize = 16,
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128},
             horizontalAlignment = TextAlignment.Left,
             verticalAlignment = TextAlignment.Top)}),
           Diagram(coordinateSystem(extent={{-55,-32},{55,32}},
    initialScale=1,
    grid={2,2}),graphics = {State(origin={0,0},
    stateTitle=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-53,24},{53,32}},
    textString="%name",
    fontSize=16,
    textStyle={TextStyle.Bold},
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left),
    stateText=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-53,-32},{53,24}},
    textString="%algorithm",
    fontSize=16,
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left,
    verticalAlignment=TextAlignment.Top),
    stateLine = Line(origin={0,0},
    color = {74, 84, 154},
    points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
        algorithm
        annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  speed := 30;
          flag := true;
        end State1;
        equation
        transition(avoid, cruise, df > safeF or db < mindis, reset = false) 
        annotation(Line(origin={-239,-466.474},
        points={{51,0},{-51,0}},
        color={113,119,170},
        smooth=Smooth.Bezier),Text(origin={-20.5269,-5.271},
        lineColor={74,84,154},
        extent={{0,-3},{0,3}},
        textString="%condition",
        fontSize=10,
        textStyle={TextStyle.Bold},
        textColor={74,84,154},
        horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[df > safeF or db < mindis]");
        transition(cruise, avoid, df <mindis, reset = false) 
        annotation(Line(origin={-239,-494.137},
        points={{-51,0},{51,0}},
        color={113,119,170},
        smooth=Smooth.Bezier),Text(origin={-15.7299,-5.15291},
        lineColor={74,84,154},
        extent={{0,-3},{0,3}},
        textString="%condition",
        fontSize=10,
        textStyle={TextStyle.Bold},
        textColor={74,84,154},
        horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[df <mindis]");
        initialState(cruise, true, 1) 
        annotation(Line(origin={-374,-437},
        points={{0,10},{0,-10}},
        color={113,119,170},
        smooth=Smooth.Bezier),Text(origin={0,0},
        lineColor={74,84,154},
        extent={{0,-3},{0,3}},
        textString="%condition",
        fontSize=10,
        textStyle={TextStyle.Bold},
        textColor={74,84,154}), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[true]");
        end State;
      block State1 "状态"
        annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),StateMachine),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
         Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
           grid={2, 2}), graphics={Rectangle(origin = {0, 0},
           lineColor = {74, 84, 154},
           fillColor = {255, 255, 255},
           lineThickness = 1,
           extent = {{-100, 100}, {100, -100}},
           radius = 11), Line(origin = {0, 80},
           points = {{-100, 0}, {100, 0}},
           color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
           lineColor = {0, 0, 128},
           extent = {{-100, 10}, {100, -10}},
           textString = "%name",
           textStyle = {TextStyle.None},
           textColor = {0, 0, 128}), Text(origin = {0, -10},
           lineColor = {0, 0, 128},
           extent = {{-100, 90}, {100, -90}},
           textString = "algorithm",
           fontSize = 16,
           textStyle = {TextStyle.None},
           textColor = {0, 0, 128},
           horizontalAlignment = TextAlignment.Left,
           verticalAlignment = TextAlignment.Top)}),
         Diagram(coordinateSystem(extent={{-379,-138},{379,138}},
    initialScale=1,
    grid={2,2}),graphics = {State(origin={0,0},
    stateTitle=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-377,130},{377,138}},
    textString="%name",
    fontSize=16,
    textStyle={TextStyle.Bold},
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left),
    stateText=Text(origin={0,0},
    lineColor={74,84,154},
    extent={{-377,-138},{377,130}},
    textString="%algorithm",
    fontSize=16,
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left,
    verticalAlignment=TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
        block State "状态"
          annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
           Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
             grid={2, 2}), graphics={Rectangle(origin = {0, 0},
             lineColor = {74, 84, 154},
             fillColor = {255, 255, 255},
             lineThickness = 1,
             extent = {{-100, 100}, {100, -100}},
             radius = 11), Line(origin = {0, 80},
             points = {{-100, 0}, {100, 0}},
             color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
             lineColor = {0, 0, 128},
             extent = {{-100, 10}, {100, -10}},
             textString = "%name",
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128}), Text(origin = {0, -10},
             lineColor = {0, 0, 128},
             extent = {{-100, 90}, {100, -90}},
             textString = "algorithm",
             fontSize = 16,
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128},
             horizontalAlignment = TextAlignment.Left,
             verticalAlignment = TextAlignment.Top)}),
           Diagram(coordinateSystem(extent={{-166,-92},{166,92}},
          initialScale=1,
          grid={2,2}),graphics = {State(origin={0,0},
          stateTitle=Text(origin={0,0},
          lineColor={74,84,154},
          extent={{-164,84},{164,92}},
          textString="%name",
          fontSize=16,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left),
          stateText=Text(origin={0,0},
          lineColor={74,84,154},
          extent={{-164,-92},{164,84}},
          textString="%algorithm",
          fontSize=16,
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left,
          verticalAlignment=TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
          block State "状态"
            annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
             Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
               grid={2, 2}), graphics={Rectangle(origin = {0, 0},
               lineColor = {74, 84, 154},
               fillColor = {255, 255, 255},
               lineThickness = 1,
               extent = {{-100, 100}, {100, -100}},
               radius = 11), Line(origin = {0, 80},
               points = {{-100, 0}, {100, 0}},
               color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
               lineColor = {0, 0, 128},
               extent = {{-100, 10}, {100, -10}},
               textString = "%name",
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128}), Text(origin = {0, -10},
               lineColor = {0, 0, 128},
               extent = {{-100, 90}, {100, -90}},
               textString = "algorithm",
               fontSize = 16,
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128},
               horizontalAlignment = TextAlignment.Left,
               verticalAlignment = TextAlignment.Top)}),
             Diagram(coordinateSystem(extent={{-24,-19.5},{24,19.5}},
            initialScale=1,
            grid={2,2}),graphics = {State(origin={0,0},
            stateTitle=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-22,11.5},{22,19.5}},
            textString="%name",
            fontSize=16,
            textStyle={TextStyle.Bold},
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left),
            stateText=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-22,-19.5},{22,11.5}},
            textString="%algorithm",
            fontSize=16,
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left,
            verticalAlignment=TextAlignment.Top),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
          algorithm
          annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  steer := 0;
          end State;
          State ini_state 
            annotation (Placement(transformation(origin={-84,50},
    extent={{-24,-19.5},{24,19.5}})),__MWORKS(BlockSystem(StateMachine)));
          State1 turn_right 
            annotation (Placement(transformation(origin={97,-44},
    extent={{-53,-20},{53,20}})),__MWORKS(BlockSystem(StateMachine)));
          State2 turn_left 
            annotation (Placement(transformation(origin={-81,-46},
    extent={{-51,-20},{51,20}})),__MWORKS(BlockSystem(StateMachine)));
          block State1 "状态"
            annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
             Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
               grid={2, 2}), graphics={Rectangle(origin = {0, 0},
               lineColor = {74, 84, 154},
               fillColor = {255, 255, 255},
               lineThickness = 1,
               extent = {{-100, 100}, {100, -100}},
               radius = 11), Line(origin = {0, 80},
               points = {{-100, 0}, {100, 0}},
               color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
               lineColor = {0, 0, 128},
               extent = {{-100, 10}, {100, -10}},
               textString = "%name",
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128}), Text(origin = {0, -10},
               lineColor = {0, 0, 128},
               extent = {{-100, 90}, {100, -90}},
               textString = "algorithm",
               fontSize = 16,
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128},
               horizontalAlignment = TextAlignment.Left,
               verticalAlignment = TextAlignment.Top)}),
             Diagram(coordinateSystem(extent={{-53,-20},{53,20}},
            initialScale=1,
            grid={2,2}),graphics = {State(origin={0,0},
            stateTitle=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-51,12},{51,20}},
            textString="%name",
            fontSize=16,
            textStyle={TextStyle.Bold},
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left),
            stateText=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-51,-20},{51,12}},
            textString="%algorithm",
            fontSize=16,
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left,
            verticalAlignment=TextAlignment.Top),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
          algorithm
          annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  steer := 0.6;
          end State1;
          block State2 "状态"
            annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
             Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
               grid={2, 2}), graphics={Rectangle(origin = {0, 0},
               lineColor = {74, 84, 154},
               fillColor = {255, 255, 255},
               lineThickness = 1,
               extent = {{-100, 100}, {100, -100}},
               radius = 11), Line(origin = {0, 80},
               points = {{-100, 0}, {100, 0}},
               color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
               lineColor = {0, 0, 128},
               extent = {{-100, 10}, {100, -10}},
               textString = "%name",
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128}), Text(origin = {0, -10},
               lineColor = {0, 0, 128},
               extent = {{-100, 90}, {100, -90}},
               textString = "algorithm",
               fontSize = 16,
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128},
               horizontalAlignment = TextAlignment.Left,
               verticalAlignment = TextAlignment.Top)}),
             Diagram(coordinateSystem(extent={{-51,-20},{51,20}},
            initialScale=1,
            grid={2,2}),graphics = {State(origin={0,0},
            stateTitle=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-49,12},{49,20}},
            textString="%name",
            fontSize=16,
            textStyle={TextStyle.Bold},
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left),
            stateText=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-49,-20},{49,12}},
            textString="%algorithm",
            fontSize=16,
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left,
            verticalAlignment=TextAlignment.Top),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
          algorithm
          annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  steer := -0.6;
          end State2;
        equation
          transition(ini_state, turn_left, dl - dr > mindis, reset = false) 
          annotation(Line(origin={-293.806,-271.75},
          points={{0,28.25},{0,-28.25}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={-28.0109,-4.46722},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dl - dr > mindis]");
          transition(turn_left, ini_state, dl - dr <= mindis, reset = false) 
          annotation(Line(origin={-306.027,-271.75},
          points={{0,-28.25},{0,28.25}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={-30.7073,14.5007},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dl - dr <= mindis]");
          transition(turn_right, ini_state, dr - dl <= mindis, reset = false) 
          annotation(Line(origin={-184.29002,-246.814},
          points={{37.41132,-51.186},{-81.71,6.88734}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={-36.5955,-7.88489},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dr - dl <= mindis]");
          transition(ini_state, turn_right, dr - dl > mindis, reset = false, priority = 2) 
          annotation(Line(origin={-166.08098,-235.84},
          points={{-99.919,8.13366},{45.89268,-62.16}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={-24.6651,0.00790729},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dr - dl > mindis]");
          initialState(ini_state, true, 1) 
          annotation(Line(origin={-289.974,-199.67302},
          points={{0,4.82698},{0,-4.82698}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={0,0},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154}), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[true]");
          end State;
        State curise_lateral 
        annotation(Placement(transformation(origin={-177,-10},
    extent={{-166,-92},{166,92}})),__MWORKS(BlockSystem(StateMachine)));
        State1 avoid_lateral 
          annotation (Placement(transformation(origin={179,-8},
    extent={{-168,-92},{168,92}})),__MWORKS(BlockSystem(StateMachine)));
        block State1 "状态"
          annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state, SampleTime(auto = true)),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
           Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
             grid={2, 2}), graphics={Rectangle(origin = {0, 0},
             lineColor = {74, 84, 154},
             fillColor = {255, 255, 255},
             lineThickness = 1,
             extent = {{-100, 100}, {100, -100}},
             radius = 11), Line(origin = {0, 80},
             points = {{-100, 0}, {100, 0}},
             color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
             lineColor = {0, 0, 128},
             extent = {{-100, 10}, {100, -10}},
             textString = "%name",
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128}), Text(origin = {0, -10},
             lineColor = {0, 0, 128},
             extent = {{-100, 90}, {100, -90}},
             textString = "algorithm",
             fontSize = 16,
             textStyle = {TextStyle.None},
             textColor = {0, 0, 128},
             horizontalAlignment = TextAlignment.Left,
             verticalAlignment = TextAlignment.Top)}),
           Diagram(coordinateSystem(extent={{-168,-92},{168,92}},
          initialScale=1,
          grid={2,2}),graphics = {State(origin={0,0},
          stateTitle=Text(origin={0,0},
          lineColor={74,84,154},
          extent={{-166,84},{166,92}},
          textString="%name",
          fontSize=16,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left),
          stateText=Text(origin={0,0},
          lineColor={74,84,154},
          extent={{-166,-92},{166,84}},
          textString="%algorithm",
          fontSize=16,
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left,
          verticalAlignment=TextAlignment.Top),
          stateLine = Line(origin={0,0},
          color = {74, 84, 154},
          points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
          block State "状态"
            annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
             Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
               grid={2, 2}), graphics={Rectangle(origin = {0, 0},
               lineColor = {74, 84, 154},
               fillColor = {255, 255, 255},
               lineThickness = 1,
               extent = {{-100, 100}, {100, -100}},
               radius = 11), Line(origin = {0, 80},
               points = {{-100, 0}, {100, 0}},
               color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
               lineColor = {0, 0, 128},
               extent = {{-100, 10}, {100, -10}},
               textString = "%name",
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128}), Text(origin = {0, -10},
               lineColor = {0, 0, 128},
               extent = {{-100, 90}, {100, -90}},
               textString = "algorithm",
               fontSize = 16,
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128},
               horizontalAlignment = TextAlignment.Left,
               verticalAlignment = TextAlignment.Top)}),
             Diagram(coordinateSystem(extent={{-29,-18},{29,18}},
            initialScale=1,
            grid={2,2}),graphics = {State(origin={0,0},
            stateTitle=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-27,10},{27,18}},
            textString="%name",
            fontSize=16,
            textStyle={TextStyle.Bold},
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left),
            stateText=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-27,-18},{27,10}},
            textString="%algorithm",
            fontSize=16,
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left,
            verticalAlignment=TextAlignment.Top),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
          algorithm
          annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  steer := 0;
          end State;
          State ini_state 
            annotation (Placement(transformation(origin={-107,36},
    extent={{-29,-18},{29,18}})),__MWORKS(BlockSystem(StateMachine)));
          State1 turn_left 
          annotation(Placement(transformation(origin={-101,-46},
    extent={{-51,-20},{51,20}})),__MWORKS(BlockSystem(StateMachine)));
          State2 turn_right 
          annotation(Placement(transformation(origin={69,-46},
    extent={{-53,-20},{53,20}})),__MWORKS(BlockSystem(StateMachine)));
          block State1 "状态"
            annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
             Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
               grid={2, 2}), graphics={Rectangle(origin = {0, 0},
               lineColor = {74, 84, 154},
               fillColor = {255, 255, 255},
               lineThickness = 1,
               extent = {{-100, 100}, {100, -100}},
               radius = 11), Line(origin = {0, 80},
               points = {{-100, 0}, {100, 0}},
               color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
               lineColor = {0, 0, 128},
               extent = {{-100, 10}, {100, -10}},
               textString = "%name",
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128}), Text(origin = {0, -10},
               lineColor = {0, 0, 128},
               extent = {{-100, 90}, {100, -90}},
               textString = "algorithm",
               fontSize = 16,
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128},
               horizontalAlignment = TextAlignment.Left,
               verticalAlignment = TextAlignment.Top)}),
             Diagram(coordinateSystem(extent={{-51,-20},{51,20}},
            initialScale=1,
            grid={2,2}),graphics = {State(origin={0,0},
            stateTitle=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-49,12},{49,20}},
            textString="%name",
            fontSize=16,
            textStyle={TextStyle.Bold},
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left),
            stateText=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-49,-20},{49,12}},
            textString="%algorithm",
            fontSize=16,
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left,
            verticalAlignment=TextAlignment.Top),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
          algorithm
          annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  steer := -0.6;
          end State1;
          block State2 "状态"
            annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
             Icon(coordinateSystem(extent={{-100, -100}, {100, 100}},
               grid={2, 2}), graphics={Rectangle(origin = {0, 0},
               lineColor = {74, 84, 154},
               fillColor = {255, 255, 255},
               lineThickness = 1,
               extent = {{-100, 100}, {100, -100}},
               radius = 11), Line(origin = {0, 80},
               points = {{-100, 0}, {100, 0}},
               color = {74, 84, 154}, thickness = 1), Text(origin = {0, 90},
               lineColor = {0, 0, 128},
               extent = {{-100, 10}, {100, -10}},
               textString = "%name",
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128}), Text(origin = {0, -10},
               lineColor = {0, 0, 128},
               extent = {{-100, 90}, {100, -90}},
               textString = "algorithm",
               fontSize = 16,
               textStyle = {TextStyle.None},
               textColor = {0, 0, 128},
               horizontalAlignment = TextAlignment.Left,
               verticalAlignment = TextAlignment.Top)}),
             Diagram(coordinateSystem(extent={{-53,-20},{53,20}},
            initialScale=1,
            grid={2,2}),graphics = {State(origin={0,0},
            stateTitle=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-51,12},{51,20}},
            textString="%name",
            fontSize=16,
            textStyle={TextStyle.Bold},
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left),
            stateText=Text(origin={0,0},
            lineColor={74,84,154},
            extent={{-51,-20},{51,12}},
            textString="%algorithm",
            fontSize=16,
            textColor={74,84,154},
            horizontalAlignment=TextAlignment.Left,
            verticalAlignment=TextAlignment.Top),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}))}),Protection(access=Access.packageDuplicate));
          algorithm
          annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  steer := 0.6;
          end State2;
        equation
          transition(ini_state, turn_left, dl < dr, reset = false) 
          annotation(Line(origin={27.3006,-276},
          points={{3.55271e-15,22},{-3.55271e-15,-22}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={3.15746,-1.93588},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dl < dr]");
          transition(ini_state, turn_right, dr < dl, reset = false, priority = 2) 
          annotation(Line(origin={150.092,-245.509},
          points={{-78.092,8.96332},{34.5644,-52.491}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={0,0},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dr < dl]");
          transition(turn_left, turn_right, dr<dl, reset = false) 
          annotation(Line(origin={133,-311.21},
          points={{-33,0},{33,0}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={-3.62135,3.84769},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dr<dl]");
          transition(turn_right, turn_left, dl<dr, reset = false) 
          annotation(Line(origin={133,-322.074},
          points={{33,0},{-33,0}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={-2.48968,-2.94235},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154},
          horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dl<dr]");
          initialState(ini_state, true, 1) 
          annotation(Line(origin={38,-208},
          points={{0,10},{0,-10}},
          color={113,119,170},
          smooth=Smooth.Bezier),Text(origin={0,0},
          lineColor={74,84,154},
          extent={{0,-3},{0,3}},
          textString="%condition",
          fontSize=10,
          textStyle={TextStyle.Bold},
          textColor={74,84,154}), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[true]");
          end State1;
      equation
        transition(avoid_lateral, curise_lateral, not flag, reset = false) 
        annotation(Line(origin={-30.2029,-148.623},
        points={{69.1344,-31.377},{0.129732,0.00178089},{-68.7286,-33.377}},
        color={113,119,170},
        smooth=Smooth.Bezier),Text(origin={-7.15991,7.15991},
        lineColor={74,84,154},
        extent={{0,-3},{0,3}},
        textString="%condition",
        fontSize=10,
        textStyle={TextStyle.Bold},
        textColor={74,84,154},
        horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[not flag]");
        transition(curise_lateral, avoid_lateral, flag, reset = false) 
        annotation(Line(origin={-30,-165.0168},
        points={{-30.9664,-16.9832},{30.9664,-14.9832}},
        color={113,119,170},
        smooth=Smooth.Bezier),Text(origin={0,0},
        lineColor={74,84,154},
        extent={{0,-3},{0,3}},
        textString="%condition",
        fontSize=10,
        textStyle={TextStyle.Bold},
        textColor={74,84,154},
        horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[flag]");
        initialState(curise_lateral, true, 1) 
        annotation(Line(origin={-241.907,-170.981},
        points={{0.0362665,14.1629},{-7.79013e-5,1.08237},{0.0362665,-11.0189}},
        color={113,119,170},
        smooth=Smooth.Bezier),Text(origin={-12.7065,1.36141},
        lineColor={74,84,154},
        extent={{0,-3},{0,3}},
        textString="%condition",
        fontSize=10,
        textStyle={TextStyle.Bold},
        textColor={74,84,154}), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[true]");
        end State1;
      equation
      end Chart;
    equation
    connect(sensor1, abs1.u) 
    annotation(Line(origin={-186,135.373},
    points={{-53,22.0000048},{-38.8,22}},
    color={0,0,0}));
    connect(saturation.u, sum1.y) 
    annotation(Line(origin={-10,41.3725},
    points={{23.2,26.5},{15,26.5},{15,60},{51,60},{51,86},{46.8,86}},
    color={0,0,0}));
    connect(constant1.y, sum2.u2) 
    annotation(Line(origin={-106,1.37252},
    points={{3.8,40},{27,40},{27,66.5},{31.2,66.5}},
    color={0,0,0}));
    connect(constant2.y, product1.u2) 
    annotation(Line(origin={-74,18.3725},
    points={{22.8,23},{33,23},{33,44.5},{41.2,44.5}},
    color={0,0,0}));
    connect(sum2.y, product1.u1) 
    annotation(Line(origin={-56,54.3725},
    points={{4.8,18.5},{23.2,18.5}},
    color={0,0,0}));
    connect(product1.y, roundingFunction.u) 
    annotation(Line(origin={-38,91.3725},
    points={{28.8,-23.5},{35,-23.5},{35,0},{-35,0},{-35,24},{-26.8,24}},
    color={0,0,0}));
    connect(roundingFunction.y, gain.u) 
    annotation(Line(origin={-37,115.373},
    points={{-4.2,0},{4.2,0}},
    color={0,0,0}));
    connect(gain.y, sum1.u2) 
    annotation(Line(origin={2,119.373},
    points={{-11.2,-4},{-4.1,-4},{-4.1,3},{11.2,3}},
    color={0,0,0}));
    connect(sensor2, abs2.u) 
    annotation(Line(origin={-232,115.373},
    points={{-6.99997,4.8e-6},{7.2,0}},
    color={0,0,0}));
    connect(sensor4, abs3.u) 
    annotation(Line(origin={-232,35.0725},
points={{-6.99997,-3.69987},{7.2,-3.69987}},
color={0,0,0}));
    connect(sensor3, abs4.u) 
    annotation(Line(origin={-232,80.7725},
points={{-6.99997,-7.39975},{7.2,-7.4}},
color={0,0,0}));
    connect(saturation.y, steer) 
    annotation(Line(origin={64,67.3725},
    points={{-27.2,0.5},{-13,0.500005}},
    color={0,0,0}));
    connect(sensor5, abs5.u) 
    annotation(Line(origin={-232,-10.6275},
    points={{-6.99997,4.8e-6},{7.2,0}},
    color={0,0,0}));
    connect(gain1.y, speed) 
    annotation(Line(origin={15,157.373},
    points={{-36.2,0},{36,4.8e-6}},
    color={0,0,0}));
    connect(sum2.u1, chart.steer) 
    annotation(Line(origin={-88,78},
    points={{13.2,-0.1275},{-14.2,-0.1275}},
    color={0,0,0}));
    connect(chart.speed, gain1.u) 
    annotation(Line(origin={-73,132},
    points={{-29.2,-25.1275},{-21,-25.1275},{-21,25.373},{28.2,25.373}},
    color={0,0,0}));
    connect(chart.steer, sum1.u1) 
    annotation(Line(origin={-44,105},
    points={{-58.2,-27.1275},{-42,-27.1275},{-42,27.373},{57.2,27.373}},
    color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
    connect(abs1.y, chart.df) 
    annotation(Line(origin={-182,136},
    points={{-19.2,21.373},{10,21.373},{10,-20.4275},{18.2,-20.4275}},
    color={0,0,0}));
    connect(abs2.y, chart.db) 
    annotation(Line(origin={-182,110},
    points={{-19.2,5.373},{0,5.373},{0,-6.0275},{18.2,-6.0275}},
    color={0,0,0}));
    connect(abs4.y, chart.dr) 
    annotation(Line(origin={-182,87},
points={{-19.2,-13.6275},{-10,-13.6275},{-10,5.3725},{18.2,5.3725}},
color={0,0,0}));
    connect(abs3.y, chart.dl) 
    annotation(Line(origin={-182,58},
points={{-19.2,-26.6274},{0,-26.6274},{0,22.7725},{18.2,22.7725}},
color={0,0,0}));
    connect(abs5.y, chart.dfu) 
    annotation(Line(origin={-182,29},
    points={{-19.2,-39.6275},{10,-39.6275},{10,40.1725},{18.2,40.1725}},
    color={0,0,0}));
    end SubSystem;
equation
  connect(constant1.y, raspberry_SetMsg.u4) 
    annotation(Line(origin = {80.5667, 12.7919},
    points = {{-1.60004, 46.4836}, {33.1666, 46.4836}, {33.1666, 53.5719}, {36.9666, 53.5719}},
    color = {0, 0, 0}), __MWORKS(BlockSystem(NamedSignal)));
  connect(constant1.y, raspberry_SetMsg.u5) 
    annotation(Line(origin = {80.5667, 6.79191},
    points = {{-1.60004, 52.4836}, {33.1666, 52.4836}, {33.1666, 45.3954}, {36.9666, 45.3954}},
    color = {0, 0, 0}), __MWORKS(BlockSystem(NamedSignal)));
  connect(gain7.y, raspberry_SetMsg.left_speed) 
    annotation(Line(origin = {78.66665, 75.9164},
    points = {{0.30001, -37.90558}, {38.8667, -37.90558}},
    color = {0, 0, 0}));
  connect(gain8.y, raspberry_SetMsg.right_speed) 
    annotation(Line(origin = {102.66665, 3.7461},
    points = {{-23.69999, 19}, {14.8667, 19}, {14.8667, 20.08824}},
    color = {0, 0, 0}));
  connect(raspberry_GetMsg.dis1, gain.u) 
    annotation(Line(origin = {-106, 81},
    points = {{-20.53335, -0.45972}, {-6.96666, -0.45974}},
    color = {0, 0, 0}));
  connect(gain.y, subSystem.sensor1) 
    annotation(Line(origin = {-63, 81},
    points = {{-35.2, -0.45974}, {22.8667, -0.45974}},
    color = {0, 0, 0}));
  connect(raspberry_GetMsg.dis2, gain1.u) 
    annotation(Line(origin = {-106, 66},
    points = {{-20.53335, 0.3638}, {-6.96666, 0.36378}},
    color = {0, 0, 0}));
  connect(gain1.y, subSystem.sensor2) 
    annotation(Line(origin = {-63, 66},
    points = {{-35.2, 0.36378}, {22.8667, 0.36378}},
    color = {0, 0, 0}));
  connect(raspberry_GetMsg.dis3, gain2.u) 
    annotation(Line(origin = {-99, 52},
    points = {{-27.53335, 0.18732}, {-13.9667, 0.1873}},
    color = {0, 0, 0}));
  connect(gain2.y, subSystem.sensor3) 
    annotation(Line(origin = {-56, 52},
    points = {{-42.2, 0.1873}, {15.8667, 0.1873}},
    color = {0, 0, 0}));
  connect(raspberry_GetMsg.dis4, gain3.u) 
    annotation(Line(origin = {-99, 38},
    points = {{-27.53335, 0.01084}, {-13.9667, 0.01082}},
    color = {0, 0, 0}));
  connect(gain3.y, subSystem.sensor4) 
    annotation(Line(origin = {-56, 38},
    points = {{-42.2, 0.01082}, {15.8667, 0.01082}},
    color = {0, 0, 0}));
  connect(raspberry_GetMsg.dis5, gain4.u) 
    annotation(Line(origin = {-99, 24},
    points = {{-27.53335, -0.16564}, {-13.9667, -0.16566}},
    color = {0, 0, 0}));
  connect(gain4.y, subSystem.sensor5) 
    annotation(Line(origin = {-56, 24},
    points = {{-42.2, -0.16566}, {15.8667, -0.16566}},
    color = {0, 0, 0}));
  connect(subSystem.speed, gain7.u) 
    annotation(Line(origin = {35, 76},
    points = {{-5.53335, -6.0921}, {15, -6.0921}, {15, -37.9892}, {29.2, -37.9892}},
    color = {0, 0, 0}));
  connect(subSystem.steer, gain6.u) 
    annotation(Line(origin = {35, 52},
    points = {{-5.53335, -17.5333}, {5, -17.5333}, {5, 28.5403}, {29.2, 28.5403}},
    color = {0, 0, 0}));
  connect(gain6.y, raspberry_SetMsg.steer) 
    annotation(Line(origin = {92, 55},
    points = {{-13.0333, 25.5403}, {25.5333, 25.5403}},
    color = {0, 0, 0}));
  connect(subSystem.speed, gain8.u) 
    annotation(Line(origin = {64, 49},
    points = {{-34.53335, 20.9079}, {-14, 20.9079}, {-14, -26.2539}, {0.2, -26.2539}},
    color = {0, 0, 0}), __MWORKS(BlockSystem(NamedSignal)));
end for_code_ZXDJ520;