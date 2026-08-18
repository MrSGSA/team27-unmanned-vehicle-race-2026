model ObsAvoidController_Sysblock2 "避障控制（Sysblock）"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(version="26.3.0",modelType=Control,PortArrangement(Left(front_dist, rear_dist, left_dist, right_dist), Right(speed, steer)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.01,OutputInterval=0.01),SysblockVersion="1.0"),Icon(coordinateSystem(preserveAspectRatio=false)),experiment(Algorithm=Dassl,Interval=0.01,InlineIntegrator=false,InlineStepSize=false,StartTime=0,StopTime=1,Tolerance=0.0001),Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
grid={2,2}),graphics = {Text(origin={-115,52.75},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="前方传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-115,22.25},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="后方传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-115,-8.25},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="左方传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-115,-38.75},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="右方传感器距离",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={263,37.5},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="预期车速",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={263,-23.5},
lineColor={0,0,0},
extent={{-19,10},{19,-10}},
textString="预期转向",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None)}),Protection(access=Access.diagram));
  SysplorerEmbeddedCoder.Port.Inport front_dist 
    annotation (Placement(transformation(origin={-80,52.75},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-101.8,75},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  SysplorerEmbeddedCoder.Port.Inport rear_dist 
    annotation (Placement(transformation(origin={-80,22.25},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-101.8,25},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  SysplorerEmbeddedCoder.Port.Inport left_dist 
    annotation (Placement(transformation(origin={-80,-8.25},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-101.8,-25},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  SysplorerEmbeddedCoder.Port.Inport right_dist 
    annotation (Placement(transformation(origin={-80,-38.75},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={-101.8,-75},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  SysplorerEmbeddedCoder.Port.Outport speed 
    annotation (Placement(transformation(origin={220,37.5},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={101.8,50},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  SysplorerEmbeddedCoder.Port.Outport steer 
    annotation (Placement(transformation(origin={220,-23.5},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={101.8,-50},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  model ModelWorkspace
    annotation(__MWORKS(hide = true,BlockSystem(blockKind=BlockKind.modelWorkspace)),Protection(access=Access.diagram));
    parameter RealAuto speed_Cruise = 1 "巡航速度" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto front_safe = 1 "前方安全距离" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto side_safe = 0.3 "侧边安全距离" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto k_rep_front = 2 "前向增益" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto k_rep_side = 1 "侧向增益" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto k_steer = 0.6 "前后避障转角增益" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto speed_avoid_front = 0.5 "前向避障速度" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto speed_avoid_side = 1.5 "左右避障速度" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto speed_error = -0.8 "紧急避障速度" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto k_steer_side = 3 "左右避障转角增益" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto steer_error = 0.8 "紧急避障角度" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    parameter RealAuto error_side = 0.15 "左右避障范围" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    constant RealAuto eps = 1e-4 "最小距离防止除零" annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    constant RealAuto Param1 = 0 annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"))),HideResult=true);
    end ModelWorkspace;
  equation
  end ObsAvoidController_Sysblock2;