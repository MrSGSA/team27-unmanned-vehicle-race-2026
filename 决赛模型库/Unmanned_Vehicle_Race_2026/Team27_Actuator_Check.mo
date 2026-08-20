model Team27_Actuator_Check
  "Team27执行器联调：舵机限幅、左右电机架空标定"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(modelType=Control,PortArrangement(Right(steer_actual,scanner_actual,motor_id2_actual,motor_id1_actual)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.02,OutputInterval=0.02),experiment(Algorithm=Euler,Interval=0.02,StartTime=0,StopTime=120),CodeGeneration(Config={"code_placement":{"mode":"Compact"},"code_replacement":{"standard_c_library":"C99"},"custom_code":{"code":{"function_declare":{"head":"","item_head":"","item_tail":"","tail":"void motor_send_cmd(int id, double speed, int time_ms);\nvoid steer_cmd(double steer);\nvoid front_sensor_cmd(double steer);\nvoid rear_sensor_cmd(double angle);\nvoid Terminate();"},"function_define":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_declare":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_define":{"head":"","item_head":"","item_tail":"","tail":"void motor_send_cmd(int id, double speed, int time_ms)\n{\n  char cmd_buf[20] = {0};\n  int pwm = (int)(speed / 0.003 / 100.0);\n  int pulse = 1500 + pwm;\n  sprintf(cmd_buf, \"#%03dP%04dT%04d!\", id, pulse, time_ms);\n  write(fd, cmd_buf, strlen(cmd_buf));\n}\n\nvoid Terminate()\n{\n  motor_send_cmd(2, 0.0, 0);\n  motor_send_cmd(1, 0.0, 0);\n  steer_cmd(0.0);\n  front_sensor_cmd(0.0);\n  rear_sensor_cmd(0.0);\n}\n"},"include":{"head":"","item_head":"","item_tail":"","tail":""},"macro":{"head":"","item_head":"","item_tail":"","tail":""},"type":{"head":"#include <stdio.h>\n#include <string.h>\n#include <unistd.h>\nextern int fd;","item_head":"","item_tail":"","tail":""}},"code_protection":{"integer_division_by_zero":false,"overflow":false}},"data_type":{"real_as_float":false},"experiment":{"task_and_sample":{"muti_task_mode":false,"whether_to_use_prefix":false}},"hardware_platform":{"largest_atomic_size":{"floating_point":"32","integer":"32"}},"identifier":{"max_length":32,"style":{"function":"camelCase","local_variable":"camelCase","macro":"camelCase","mem_var":"camelCase","type":"camelCase"
}},"interface":{"array_layout"
:"row_major","function_name":{"initialize":"Init","step":"Step","terminate":""},"generate_a2l_file":false,"generate_capi_for_param":true,"generate_capi_for_root_IO":true,"generate_capi_for_signal":true,"generate_capi_for_state":false,"have_terminate":false
,"include_internal_data":false},"is_expand":{"is_expand":false},"optimization":{"array_loop_threshold":5,"logical_operator":"logical","parameter_mode":"tunable"}},
Sim_seting={"sim_seting":{"output":"D:/mworks比赛/team27-unmanned-vehicle-race-2026-main/决赛模型库/Unmanned_Vehicle_Race_2026/Team27_OneClick/generated_actuator_check"}}),version="26.3.0"));

  // 只复用赛会提供的硬件接口块；控制命令全部来自本MWORKS模型。
  for_code_JGB520.SubSystem1.CCaller hardwareInit 
    annotation(Placement(transformation(origin={-88,-75},extent={{-10,-7},{10,7}})));
  for_code_JGB520.SubSystem1.CCaller1 steerWriter 
    annotation(Placement(transformation(origin={45,60},extent={{-12,-7},{12,7}})));
  for_code_JGB520.SubSystem1.CCaller3 scannerWriter 
    annotation(Placement(transformation(origin={45,25},extent={{-12,-7},{12,7}})));
  MotorWriter motorId2Writer 
    annotation(Placement(transformation(origin={45,-15},extent={{-12,-14},{12,14}})));
  MotorWriter motorId1Writer 
    annotation(Placement(transformation(origin={45,-55},extent={{-12,-14},{12,14}})));

  // 只操作这四个command参数；初始均为0。
  SysplorerEmbeddedCoder.Sources.Constant steerCommand(k=0) 
    annotation(Placement(transformation(origin={-82,60},extent={{-7,-7},{7,7}})));
  SysplorerEmbeddedCoder.Sources.Constant scannerCommand(k=0) 
    annotation(Placement(transformation(origin={-82,25},extent={{-7,-7},{7,7}})));
  SysplorerEmbeddedCoder.Sources.Constant motorId2Command(k=0.000000) 
    annotation(Placement(transformation(origin={-82,-15},extent={{-7,-7},{7,7}})));
  SysplorerEmbeddedCoder.Sources.Constant motorId1Command(k=0) 
    annotation(Placement(transformation(origin={-82,-55},extent={{-7,-7},{7,7}})));

  // 模型内硬限幅：前轮±0.15，顶部±0.20，单电机±60。
  // 电机默认仍为0；±60仅用于架空时逐级查找启动死区。
  SysplorerEmbeddedCoder.Discontinuities.Saturation steerLimit(
    zeroCross=false,upLimit=0.15,lowLimit=-0.15) 
    annotation(Placement(transformation(origin={-48,60},extent={{-8,-7},{8,7}})));
  SysplorerEmbeddedCoder.Discontinuities.Saturation scannerLimit(
    zeroCross=false,upLimit=0.20,lowLimit=-0.20) 
    annotation(Placement(transformation(origin={-48,25},extent={{-8,-7},{8,7}})));
  SysplorerEmbeddedCoder.Discontinuities.Saturation motorId2Limit(
    zeroCross=false,upLimit=60,lowLimit=-60) 
    annotation(Placement(transformation(origin={-48,-15},extent={{-8,-7},{8,7}})));
  SysplorerEmbeddedCoder.Discontinuities.Saturation motorId1Limit(
    zeroCross=false,upLimit=60,lowLimit=-60) 
    annotation(Placement(transformation(origin={-48,-55},extent={{-8,-7},{8,7}})));

  // 固定硬件配置：ID2、ID1。T=0与赛会正式顶层模型保持一致。
  SysplorerEmbeddedCoder.Sources.Constant motorId2(k=2) 
    annotation(Placement(transformation(origin={-15,-7},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(Type(inherit=InheritType.none,ref="int32"))))));
  SysplorerEmbeddedCoder.Sources.Constant motorId1(k=1) 
    annotation(Placement(transformation(origin={-15,-47},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(Type(inherit=InheritType.none,ref="int32"))))));
  SysplorerEmbeddedCoder.Sources.Constant watchdogId2Ms(k=0) 
    annotation(Placement(transformation(origin={-15,-23},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(Type(inherit=InheritType.none,ref="int32"))))));
  SysplorerEmbeddedCoder.Sources.Constant watchdogId1Ms(k=0) 
    annotation(Placement(transformation(origin={-15,-63},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(Type(inherit=InheritType.none,ref="int32"))))));

  SysplorerEmbeddedCoder.MathOperation.Gain monitorSteer(k=1) 
    annotation(Placement(transformation(origin={10,72},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorScanner(k=1) 
    annotation(Placement(transformation(origin={10,38},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorMotorId2(k=1) 
    annotation(Placement(transformation(origin={75,-5},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorMotorId1(k=1) 
    annotation(Placement(transformation(origin={75,-45},extent={{-6,-5},{6,5}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));

  SysplorerEmbeddedCoder.Port.Outport steer_actual 
    annotation(Placement(transformation(origin={95,72},extent={{-5,-5},{5,5}})));
  SysplorerEmbeddedCoder.Port.Outport scanner_actual 
    annotation(Placement(transformation(origin={95,38},extent={{-5,-5},{5,5}})));
  SysplorerEmbeddedCoder.Port.Outport motor_id2_actual 
    annotation(Placement(transformation(origin={95,-5},extent={{-5,-5},{5,5}})));
  SysplorerEmbeddedCoder.Port.Outport motor_id1_actual 
    annotation(Placement(transformation(origin={95,-45},extent={{-5,-5},{5,5}})));

  block MotorWriter
    "只声明电机外部函数；JGB520.c由顶层资源唯一编译"
    annotation(__MWORKS(
      PortArrangement(Left(id,speed,time_ms),Right()),
      PortLabels(labelType="CustomType",labels(
        label(text="id",instance="id"),
        label(text="speed",instance="speed"),
        label(text="time_ms",instance="time_ms"))),
      BlockSystem(blockKind=BlockKind.atomic,bltBlockKind=BltBlockKind.ccaller,SampleTime=-1),
      independentInstance=true,
      sourceModel=SysplorerEmbeddedCoder.Utilities.CCaller,
      ExternalFunctionBlock,
      hide=true));

    function writeMotor
      input SysplorerEmbeddedCoder.Types.Auto id 
        annotation(__MWORKS(BlockSystem(CParamName="id",
          Type(inherit=InheritType.none,ref="int32"),
          Dimension(dimensionType=DimensionType.none)=1)));
      input SysplorerEmbeddedCoder.Types.Auto speed 
        annotation(__MWORKS(BlockSystem(CParamName="speed",
          Type(inherit=InheritType.none,ref="double"),
          Dimension(dimensionType=DimensionType.none)=1)));
      input SysplorerEmbeddedCoder.Types.Auto time_ms 
        annotation(__MWORKS(BlockSystem(CParamName="time_ms",
          Type(inherit=InheritType.none,ref="int32"),
          Dimension(dimensionType=DimensionType.none)=1)));
      external "C" motor_send_cmd(id,speed,time_ms) 
        annotation(__MWORKS(BlockSystem(
          functionProto="void motor_send_cmd(int id,double speed,int time_ms)")));
    end writeMotor;

    SysplorerEmbeddedCoder.Port.Inport id 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="int32"),
        Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport speed 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport time_ms 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="int32"),
        Dimension(dimensionType=DimensionType.none)=1)));
  equation
    writeMotor(id,speed,time_ms);
  end MotorWriter;

  model ModelWorkspace
    annotation(__MWORKS(hide=true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;

equation
  connect(steerCommand.y,steerLimit.u);
  connect(steerLimit.y,steerWriter.src);
  connect(steerLimit.y,monitorSteer.u);
  connect(monitorSteer.y,steer_actual);

  connect(scannerCommand.y,scannerLimit.u);
  connect(scannerLimit.y,scannerWriter.src);
  connect(scannerLimit.y,monitorScanner.u);
  connect(monitorScanner.y,scanner_actual);

  connect(motorId2Command.y,motorId2Limit.u);
  connect(motorId2.y,motorId2Writer.id);
  connect(motorId2Limit.y,motorId2Writer.speed);
  connect(watchdogId2Ms.y,motorId2Writer.time_ms);
  connect(motorId2Limit.y,monitorMotorId2.u);
  connect(monitorMotorId2.y,motor_id2_actual);

  connect(motorId1Command.y,motorId1Limit.u);
  connect(motorId1.y,motorId1Writer.id);
  connect(motorId1Limit.y,motorId1Writer.speed);
  connect(watchdogId1Ms.y,motorId1Writer.time_ms);
  connect(motorId1Limit.y,monitorMotorId1.u);
  connect(monitorMotorId1.y,motor_id1_actual);
end Team27_Actuator_Check;