model Team27_Servo_Check "Team27安全舵机检查：驱动电机始终为零"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(modelType=Control,PortArrangement(Right(steer_actual, scanner_actual)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.02,ExternalCResource(
IncludeFile={"JGB520.h"},
SourceFile={"JGB520.c"},
Library,
IncludeDirectory={"classDirectory()/Raspberry_Pi_Interface/Source"},
LibraryDirectory={"classDirectory()/Raspberry_Pi_Interface/Source"},
SavedInRelationPath=false),OutputInterval=0.02),experiment(Algorithm=Euler,Interval=0.02,StartTime=0,StopTime=120),CodeGeneration(Config = {"code_placement":{"mode":"Compact"},"code_replacement":{"standard_c_library":"C99"},"custom_code":{"code":{"function_declare":{"head":"","item_head":"","item_tail":"","tail":"void motor_send_cmd(int id, double speed, int time_ms);\nvoid steer_cmd(double steer);\nvoid front_sensor_cmd(double steer);\nvoid rear_sensor_cmd(double angle);\nvoid Terminate();"},"function_define":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_declare":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_define":{"head":"","item_head":"","item_tail":"","tail":"void Terminate()\n{\n  motor_send_cmd(2, 0.0, 0);\n  motor_send_cmd(1, 0.0, 0);\n  steer_cmd(0.0);\n  front_sensor_cmd(0.0);\n  rear_sensor_cmd(0.0);\n}\n"},"include":{"head":"","item_head":"","item_tail":"","tail":""},"macro":{"head":"","item_head":"","item_tail":"","tail":""},"type":{"head":"","item_head":"","item_tail":"","tail":""}},"code_protection":{"integer_division_by_zero":false,"overflow":false}},"data_type":{"real_as_float":false},"experiment":{"task_and_sample":{"muti_task_mode":false,"whether_to_use_prefix":false}},"hardware_platform":{"largest_atomic_size":{"floating_point":"32","integer":"32"}},"identifier":{"max_length":32,"style":{"function":"camelCase","local_variable":"camelCase","macro":"camelCase","mem_var":"camelCase","type":"camelCase"}},"interface":{"array_layout":"row_major","function_name":{"initialize":"Init","step":"Step","terminate":""},"generate_a2l_file":false,"generate_capi_for_param":false,"generate_capi_for_root_IO":true,"generate_capi_for_signal":true,"generate_capi_for_state":false,"have_terminate":false,"include_internal_data":false},"is_expand":{"is_expand":false},"optimization":{"array_loop_threshold":5,"logical_operator":"logical","parameter_mode":"tunable"}}, Sim_seting = {"sim_seting":{"output":"D:/mworks比赛/team27-unmanned-vehicle-race-2026-main/决赛模型库/Unmanned_Vehicle_Race_2026/Team27_OneClick/generated_servo_check"
}}),version="26.3.0"));

  // 只复用需要的赛会硬件接口，避免把两路电机 CCaller 再次展开，
  // 从而与 ExternalCResource 中唯一编译的 JGB520.c 重复定义。
  for_code_JGB520.SubSystem1.CCaller hardwareInit 
    annotation(Placement(transformation(origin={5,-70},extent={{-10,-7},{10,7}})));
  for_code_JGB520.SubSystem1.CCaller1 steerWriter 
    annotation(Placement(transformation(origin={45,55},extent={{-12,-7},{12,7}})));
  for_code_JGB520.SubSystem1.CCaller3 scannerWriter 
    annotation(Placement(transformation(origin={45,20},extent={{-12,-7},{12,7}})));
  for_code_JGB520.SubSystem1.CCaller4 rearWriter 
    annotation(Placement(transformation(origin={45,-10},extent={{-12,-7},{12,7}})));

  SysplorerEmbeddedCoder.Sources.Constant steerCommand(k=0)
    "前轮转向测试指令；从0开始，建议只测试正负0.08" 
    annotation(Placement(transformation(origin={-75,55},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(SampleTime(auto=true,group="D1")=0.02,
        Instance(y(Type(ref="double"),Dimension=1),k(Type(ref="double"),Dimension=1)))));
  SysplorerEmbeddedCoder.Discontinuities.Saturation steerLimit(
    zeroCross=false,upLimit=0.15,lowLimit=-0.15) 
    annotation(Placement(transformation(origin={-35,55},extent={{-9,-8},{9,8}})),
      __MWORKS(BlockSystem(SampleTime(group="D1")=0.02)));

  SysplorerEmbeddedCoder.Sources.Constant scannerCommand(k=0)
    "顶部扫描舵机方向标定已完成：实车确认+0.15指向车辆左侧；默认恢复回中" 
    annotation(Placement(transformation(origin={-75,20},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(SampleTime(auto=true,group="D1")=0.02,
        Instance(y(Type(ref="double"),Dimension=1),k(Type(ref="double"),Dimension=1)))));
  SysplorerEmbeddedCoder.Discontinuities.Saturation scannerLimit(
    zeroCross=false,upLimit=0.20,lowLimit=-0.20) 
    annotation(Placement(transformation(origin={-35,20},extent={{-9,-8},{9,8}})),
      __MWORKS(BlockSystem(SampleTime(group="D1")=0.02)));

  SysplorerEmbeddedCoder.Sources.Constant zeroRear(k=0) 
    annotation(Placement(transformation(origin={-55,-10},extent={{-7,-6},{7,6}})));

  SysplorerEmbeddedCoder.MathOperation.Gain monitorSteer(k=1) 
    annotation(Placement(transformation(origin={10,65},extent={{-7,-6},{7,6}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorScanner(k=1) 
    annotation(Placement(transformation(origin={10,40},extent={{-7,-6},{7,6}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));

  SysplorerEmbeddedCoder.Port.Outport steer_actual 
    annotation(Placement(transformation(origin={90,65},extent={{-6,-6},{6,6}})));
  SysplorerEmbeddedCoder.Port.Outport scanner_actual 
    annotation(Placement(transformation(origin={90,40},extent={{-6,-6},{6,6}})));

  model ModelWorkspace
    annotation(__MWORKS(hide=true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;

equation
  connect(steerCommand.y, steerLimit.u);
  connect(steerLimit.y, steerWriter.src);
  connect(steerLimit.y, monitorSteer.u);
  connect(monitorSteer.y, steer_actual);

  connect(scannerCommand.y, scannerLimit.u);
  connect(scannerLimit.y, scannerWriter.src);
  connect(scannerLimit.y, monitorScanner.u);
  connect(monitorScanner.y, scanner_actual);

  connect(zeroRear.y, rearWriter.src);
end Team27_Servo_Check;
