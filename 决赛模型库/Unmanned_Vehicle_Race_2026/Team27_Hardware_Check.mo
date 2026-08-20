model Team27_Hardware_Check "Team27首次上车只读硬件检查：全部执行器保持零"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(modelType=Control,PortArrangement(Right(front_dist, scanner_dist, right_dist, left_dist, rear_dist)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.05,ExternalCResource(IncludeFile={"JGB520.h"},SourceFile={"JGB520.c"},Library,IncludeDirectory={"classDirectory()/Raspberry_Pi_Interface/Source"},LibraryDirectory={"classDirectory()/Raspberry_Pi_Interface/Source"},SavedInRelationPath=false),OutputInterval=0.02),experiment(Algorithm=Euler,Interval=0.05,StartTime=0,StopTime=100),CodeGeneration(Config = {"code_placement":{"mode":"Compact"},"code_replacement":{"standard_c_library":"C99"},"custom_code":{"code":{"function_declare":{"head":"","item_head":"","item_tail":"","tail":"void motor_send_cmd(int id, double speed, int time_ms);\nvoid steer_cmd(double steer);\nvoid front_sensor_cmd(double steer);\nvoid rear_sensor_cmd(double angle);\nvoid Terminate();"},"function_define":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_declare":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_define":{"head":"","item_head":"","item_tail":"","tail":"void Terminate()\n{\n  motor_send_cmd(2, 0.0, 0);\n  motor_send_cmd(1, 0.0, 0);\n  steer_cmd(0.0);\n  front_sensor_cmd(0.0);\n  rear_sensor_cmd(0.0);\n}\n"},"include":{"head":"","item_head":"","item_tail":"","tail":""},"macro":{"head":"","item_head":"","item_tail":"","tail":""},"type":{"head":"","item_head":"","item_tail":"","tail":""}},"code_protection":{"integer_division_by_zero":false,"overflow":false}},"data_type":{"real_as_float":false},"experiment":{"task_and_sample":{"muti_task_mode":false,"whether_to_use_prefix":false}},"hardware_platform":{"largest_atomic_size":{"floating_point":"32","integer":"32"}},"identifier":{"max_length":32,"style":{"function":"camelCase","local_variable":"camelCase","macro":"camelCase","mem_var":"camelCase","type":"camelCase"}},"interface":{"array_layout":"row_major","function_name":{"initialize":"Init","step":"Step","terminate"
:""},"generate_a2l_file":false,"generate_capi_for_param":false,"generate_capi_for_root_IO":true,"generate_capi_for_signal":true,"generate_capi_for_state":false,"have_terminate":false,"include_internal_data"
:false},"is_expand":{"is_expand":false},"optimization":{"array_loop_threshold":5,"logical_operator":"logical","parameter_mode":"tunable"}}, Sim_seting = {"sim_seting":{"output":"D:/mworks比赛/team27-unmanned-vehicle-race-2026-main/决赛模型库/Unmanned_Vehicle_Race_2026/Team27_OneClick/generated_hardware_check"
}}),version="26.3.0"));

  for_code_JGB520.SubSystem2 raspberry_GetMsg 
    annotation(Placement(transformation(origin={-60,30}, extent={{-20,-20},{20,20}})));
  for_code_JGB520.SubSystem1.CCaller hardwareInit 
    annotation(Placement(transformation(origin={-75,-55}, extent={{-12,-8},{12,8}})));

  SysplorerEmbeddedCoder.MathOperation.Gain monitorFront(k=1) 
    annotation(Placement(transformation(origin={35,70}, extent={{-8,-7},{8,7}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorScanner(k=1) 
    annotation(Placement(transformation(origin={35,50}, extent={{-8,-7},{8,7}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorRight(k=1) 
    annotation(Placement(transformation(origin={35,30}, extent={{-8,-7},{8,7}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorLeft(k=1) 
    annotation(Placement(transformation(origin={35,10}, extent={{-8,-7},{8,7}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));
  SysplorerEmbeddedCoder.MathOperation.Gain monitorRear(k=1) 
    annotation(Placement(transformation(origin={35,-10}, extent={{-8,-7},{8,7}})),
      __MWORKS(BlockSystem(Instance(y(OutputFlagForCAPI=true)))));

  SysplorerEmbeddedCoder.Port.Outport front_dist 
    annotation(Placement(transformation(origin={90,70}, extent={{-6,-6},{6,6}})));
  SysplorerEmbeddedCoder.Port.Outport scanner_dist 
    annotation(Placement(transformation(origin={90,50}, extent={{-6,-6},{6,6}})));
  SysplorerEmbeddedCoder.Port.Outport right_dist 
    annotation(Placement(transformation(origin={90,30}, extent={{-6,-6},{6,6}})));
  SysplorerEmbeddedCoder.Port.Outport left_dist 
    annotation(Placement(transformation(origin={90,10}, extent={{-6,-6},{6,6}})));
  SysplorerEmbeddedCoder.Port.Outport rear_dist 
    annotation(Placement(transformation(origin={90,-10}, extent={{-6,-6},{6,6}})));

  model ModelWorkspace
    annotation(__MWORKS(hide=true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;

equation
  connect(raspberry_GetMsg.dis1, monitorFront.u);
  connect(raspberry_GetMsg.dis2, monitorScanner.u);
  connect(raspberry_GetMsg.dis3, monitorRight.u);
  connect(raspberry_GetMsg.dis4, monitorLeft.u);
  connect(raspberry_GetMsg.dis5, monitorRear.u);
  connect(monitorFront.y, front_dist);
  connect(monitorScanner.y, scanner_dist);
  connect(monitorRight.y, right_dist);
  connect(monitorLeft.y, left_dist);
  connect(monitorRear.y, rear_dist);
end Team27_Hardware_Check;