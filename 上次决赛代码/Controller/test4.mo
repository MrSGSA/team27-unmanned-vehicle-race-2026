model test4 "避障控制+差速（Sysblock）决赛版本"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(version="2025a",modelType=Control,PortArrangement(Left(front_dist, fl_dist, right_dist, left_dist, fr_dist), Right(speed, steer, gap, u4)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.05),SysblockVersion="1.0",ContinueSimConfig(SaveContinueFile="false",SaveBeforeStop="false",NumberBeforeStop=1,FixedContinueInterval="false",ContinueIntervalLength=100,ContinueTimeVector),BindDataXml(XML="modelica://Unmanned_Vehicle_Race/../../../../../ObsAvoidController_Sysblock2.modd")),Icon(coordinateSystem(preserveAspectRatio=false)),experiment(Algorithm=Rkfix4,Interval=0.05,InlineIntegrator=false,InlineStepSize=false,StartTime=0,StopTime=100,Tolerance=0.0001,IntegratorStep=0.05),Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2}),graphics = {Text(origin={-171,58}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="前方传感器距离", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None), Text(origin={-171,16}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="左前方传感器距离", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None), Text(origin={-171,-64.3}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="左方传感器距离", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None), Text(origin={-171,-18.6}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="右方传感器距离", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None), Text(origin={221,58}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="预期车速", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None), Text(origin={221,-58}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="前轮转角", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None), Text(origin={-171,-110}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="右前方传感器距离", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None), Text(origin={221,-110}, 
lineColor={0,0,0}, 
extent={{-19,10},{19,-10}}, 
textString="后轮差速", 
textStyle={TextStyle.None}, 
textColor={0,0,0}, 
horizontalAlignment=LinePattern.None)}));
  SysplorerEmbeddedCoder.Port.Inport front_dist 
    annotation (Placement(transformation(origin={-136,58}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={-101.8,80}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport fl_dist 
    annotation (Placement(transformation(origin={-136,16}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={-101.8,40}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport left_dist 
    annotation (Placement(transformation(origin={-136,-64.3}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={-101.8,-40}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport right_dist 
    annotation (Placement(transformation(origin={-136,-18.6}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={-101.8,0}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport speed 
    annotation (Placement(transformation(origin={178,58}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={101.8,75}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport steer 
    annotation (Placement(transformation(origin={178,-58}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={101.8,25}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
  Chart chart 
    annotation (Placement(transformation(origin={-5,0.4}, 
extent={{-29,-29},{29,29}})),__MWORKS(ComponentNamePlacement(BOTTOM),BlockSystem(SampleTime(group="D1")=0.02),PortLabels(labelType="PortName",labels(label(text="df",instance="df"),label(text="dfl",instance="dfl"),label(text="dr",instance="dr"),label(text="dl",instance="dl"),label(text="speed",instance="speed"),label(text="steer",instance="steer"),label(text="dfr",instance="dfr"),label(text="gapS",instance="gapS")))));
  SysplorerEmbeddedCoder.MathOperation.Sum sum1(isSaturate=false,inputs="+-") 
    annotation (Placement(transformation(origin={140,28}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double") ,Dimension=1) ,u2(Type(ref="double") ,Dimension=1)) ,y(Type(ref="double") ,Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap) ,SampleTime(group="D1")=0.02),PortLabels(labelType="CustomType",labels(label(text="+",instance="u1"),label(text="-",instance="u2")))));
  SysplorerEmbeddedCoder.MathOperation.Sum sum2(isSaturate=false,inputs="++") 
    annotation (Placement(transformation(origin={52,-26.5}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double") ,Dimension=1) ,u2(Type(ref="double") ,Dimension=1)) ,y(Type(ref="double") ,Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap) ,SampleTime(group="D1")=0.02),PortLabels(labelType="CustomType",labels(label(text="+",instance="u1"),label(text="+",instance="u2")))));
  SysplorerEmbeddedCoder.Sources.Constant constant1(k=pi) 
    annotation (Placement(transformation(origin={1,-58}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true,group="D1")=0.02,Instance(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="double") ,Dimension=1)))));
  SysplorerEmbeddedCoder.MathOperation.RoundingFunction roundingFunction 
    annotation (Placement(transformation(origin={62,16}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.MathOperation.Product product1(isSaturate=false,inputs="*/") 
    annotation (Placement(transformation(origin={94,-31.5}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double") ,Dimension=1) ,u2(Type(ref="double") ,Dimension=1)) ,y(Type(ref="double") ,Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap) ,SampleTime(group="D1")=0.02),PortLabels(labelType="CustomType",labels(label(text="*",instance="u1"),label(text="/",instance="u2")))));
  SysplorerEmbeddedCoder.Sources.Constant constant2(k=2*pi) 
    annotation (Placement(transformation(origin={52,-58}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true,group="D1")=0.02,Instance(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="double") ,Dimension=1)))));
  SysplorerEmbeddedCoder.MathOperation.Gain gain(k=2*pi) 
    annotation (Placement(transformation(origin={94,16}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1) ,k(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.MathOperation.Abs abs1 
    annotation (Placement(transformation(origin={-98,58}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.MathOperation.Abs abs2 
    annotation (Placement(transformation(origin={-98,16}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.MathOperation.Abs abs3 
    annotation (Placement(transformation(origin={-98,-64.3}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.MathOperation.Abs abs4 
    annotation (Placement(transformation(origin={-98,-18.6}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Discontinuities.Saturation saturation(zeroCross=true,upLimit=0.8,lowLimit=-0.8) 
    annotation (Placement(transformation(origin={140,-31.5}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(zeroCross=true ,Instance(dynamicSaturation(upperLimit(Type(ref="double") ,Dimension=1) ,u(Type(ref="double") ,Dimension=1) ,lowerLimit(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)) ,u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1) ,constant_up(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="") ,Dimension=1)) ,constant_low(y(Type(ref="double") ,Dimension=1) ,k(Type(ref="") ,Dimension=1)) ,upLimit(Type(ref="") ,Dimension=1) ,lowLimit(Type(ref="") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport fr_dist 
    annotation (Placement(transformation(origin={-136,-110}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={-101.8,-80}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none ,ref="double") ,Dimension(dimensionType=DimensionType.none)=1 ,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.MathOperation.Abs abs5 
    annotation (Placement(transformation(origin={-98,-110}, 
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(Instance(u(Type(ref="double") ,Dimension=1) ,y(Type(ref="double") ,Dimension=1)),SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport gap 
    annotation (Placement(transformation(origin={178,-110}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={101.8,-25}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport u4 
    annotation (Placement(transformation(origin={200,10}, 
extent={{-10,-10},{10,10}}), 
iconTransformation(origin={101.8,-75}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  block Chart "状态机"
    annotation (__MWORKS(BlockSystem(blockKind = BlockKind.stateMachine,SampleTime(auto = true),independent = true,StateMachine(virtual = false,functionPack = FunctionPack.auto,functionName = "",sourceFile = "",parallel=true)),PortArrangement(Left(df, dfl, dr, dl, dfr), Right(speed, steer, gapS, u4)),sourceModel=SysplorerEmbeddedCoder.StateMachine.Chart,independentInstance=true,hide=true), 
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
    SysplorerEmbeddedCoder.Port.Inport dfl annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Port.Inport dr annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Port.Inport dl annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Port.Outport speed(start=0) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Port.Outport steer(start=0) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Types.Auto mindis(start=30) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto safeF(start=40) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    State zongde 
      annotation (Placement(transformation(origin={-224,-321.25}, 
  extent={{-393,-238.75},{393,238.75}})),__MWORKS(BlockSystem(StateMachine(priority=1))));
    SysplorerEmbeddedCoder.Types.Auto flag annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="boolean"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto speedC(start=10) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto speedA(start=-5) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto steerA(start=0.523) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport dfr annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Types.Auto safeFLR(start=40) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Outport gapS(start=0) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Types.Auto k_rep(start=20) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto k_steer(start=0.7) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto k_speed(start=0.6) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto v_max(start=20) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto epsilon(start=0.01) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto F_front annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto F_right annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto d_safe(start=15) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto F_left annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto speed_min(start=-0.1) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto front_threshold annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto speed_base annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto flag1 annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="boolean"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto fl annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Types.Auto fr annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Outport u4(start=0) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
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
       Diagram(coordinateSystem(extent={{-393,-238.75},{393,238.75}}, 
  initialScale=1, 
  grid={2,2}),graphics = {State(origin={0,0}, 
  stateTitle=Text(origin={0,0}, 
  lineColor={74,84,154}, 
  extent={{-391,230.75},{391,238.75}}, 
  textString="%name", 
  fontSize=16, 
  textStyle={TextStyle.Bold}, 
  textColor={74,84,154}, 
  horizontalAlignment=TextAlignment.Left), 
  stateText=Text(origin={0,0}, 
  lineColor={74,84,154}, 
  extent={{-391,-238.75},{391,230.75}}, 
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
         Diagram(coordinateSystem(extent={{-28.5,-52},{28.5,52}}, 
  initialScale=1, 
  grid={2,2}),graphics = {State(origin={0,0}, 
  stateTitle=Text(origin={0,0}, 
  lineColor={74,84,154}, 
  extent={{-26.5,44},{26.5,52}}, 
  textString="%name", 
  fontSize=16, 
  textStyle={TextStyle.Bold}, 
  textColor={74,84,154}, 
  horizontalAlignment=TextAlignment.Left), 
  stateText=Text(origin={0,0}, 
  lineColor={74,84,154}, 
  extent={{-26.5,-52},{26.5,44}}, 
  textString="%algorithm", 
  fontSize=16, 
  textColor={74,84,154}, 
  horizontalAlignment=TextAlignment.Left, 
  verticalAlignment=TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
      algorithm
      annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  speed := -80;

          steer := 0;
      end State2;
      State2 cruise 
      annotation(Placement(transformation(origin={-325.5,155.25}, 
extent={{-28.5,-52},{28.5,52}})),__MWORKS(BlockSystem(StateMachine)));
      State3 state 
      annotation(Placement(transformation(origin={111.75,41.25}, 
extent={{-220.25,-141},{220.25,141}})),__MWORKS(BlockSystem(StateMachine)));
      State state1 
        annotation (Placement(transformation(origin={-282,43.25}, 
extent={{-60,-42},{60,42}})),__MWORKS(BlockSystem(StateMachine)));
      block State3 "状态"
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
         Diagram(coordinateSystem(extent={{-220.25,-141},{220.25,141}}, 
  initialScale=1, 
  grid={2,2}),graphics = {State(origin={0,0}, 
  stateTitle=Text(origin={0,0}, 
  lineColor={74,84,154}, 
  extent={{-218.25,133},{218.25,141}}, 
  textString="%name", 
  fontSize=16, 
  textStyle={TextStyle.Bold}, 
  textColor={74,84,154}, 
  horizontalAlignment=TextAlignment.Left), 
  stateText=Text(origin={0,0}, 
  lineColor={74,84,154}, 
  extent={{-218.25,-141},{218.25,133}}, 
  textString="%algorithm", 
  fontSize=16, 
  textColor={74,84,154}, 
  horizontalAlignment=TextAlignment.Left, 
  verticalAlignment=TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
      algorithm
      annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry))));  k_rep := 7000;
        k_steer := 0.3;
        epsilon := 0.5;
        speed_base := -20;
        front_threshold := 30;
        speed_min := -0.1;
        flag := false;
      algorithm
      annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.during))));  F_front := -k_rep / ((df + epsilon) * (df + epsilon));
        F_right := k_rep / ((dr + epsilon) * (dr + epsilon));
        F_left := k_rep / ((dl + epsilon) * (dl + epsilon));
        if df > 40 then
          steer := -atan2(0.707 * (F_right - F_left), 0.707 * (F_left + F_right)) * k_steer * 1.5;
        else
          steer := -atan2(0.707 * (F_right - F_left), F_front + 0.707 * (F_left + F_right)) * k_steer;
        end if;
        steer := max(min(steer, 0.3), -0.3);
        speed := -70 * min(df / 20, 1.0);
      end State3;
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
         Diagram(coordinateSystem(extent={{-60,-42},{60,42}}, 
initialScale=1, 
grid={2,2}),graphics = {State(origin={0,0}, 
stateTitle=Text(origin={0,0}, 
lineColor={74,84,154}, 
extent={{-58,34},{58,42}}, 
textString="%name", 
fontSize=16, 
textStyle={TextStyle.Bold}, 
textColor={74,84,154}, 
horizontalAlignment=TextAlignment.Left), 
stateText=Text(origin={0,0}, 
lineColor={74,84,154}, 
extent={{-58,-42},{58,34}}, 
textString="%algorithm", 
fontSize=16, 
textColor={74,84,154}, 
horizontalAlignment=TextAlignment.Left, 
verticalAlignment=TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
      algorithm
      annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.entry or ActionKind.during))));  speed := 30;
        if abs(dr - dl) < 5 then
          steer := 0.2;
          speed := max(30 * (1.0 - df / 20) + 2, 20);
        elseif dr > dl then
          speed := max(30 * (1.0 - df / 20) + 2, 20);
          steer := -0.4;
        elseif dr < dl then
          speed := max(30 * (1.0 - df / 20) + 2, 20);
          steer := 0.4;
        end if;
      end State;
      equation
      transition(cruise, state, df <=40 or dr <= 30 or dl<30, reset = false) 
      annotation(Line(origin={-426.75,-135.166}, 
      points={{-94.25,15.8399},{94.25,-15.8399}}, 
      color={113,119,170}, 
      smooth=Smooth.Bezier),Text(origin={-22.1466,9.11018}, 
      lineColor={74,84,154}, 
      extent={{0,-3},{0,3}}, 
      textString="%condition", 
      fontSize=10, 
      textStyle={TextStyle.Bold}, 
      textColor={74,84,154}, 
      horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText ="[df <=40 or dr <= 30 or dl<30]");
      transition(state, cruise, df >45, reset = false) 
      annotation(Line(origin={-427.399,-144.19}, 
      points={{94.8992,-27.366},{-32.9863,5.58765},{-93.6008,7.63397}}, 
      color={113,119,170}, 
      smooth=Smooth.Bezier),Text(origin={-26.2391,6.71889}, 
      lineColor={74,84,154}, 
      extent={{0,-3},{0,3}}, 
      textString="%condition", 
      fontSize=10, 
      textStyle={TextStyle.Bold}, 
      textColor={74,84,154}, 
      horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[df >45]");
      transition(state, state1, df<30 or dl<20 or dr<20 or dfr <45, reset = false, priority = 2) 
      annotation(Line(origin={-439.601,-203.931}, 
      points={{107.101,-14.321},{-60.711,-32.069}}, 
      color={113,119,170}, 
      smooth=Smooth.Bezier),Text(origin={0,0}, 
      lineColor={74,84,154}, 
      extent={{0,-3},{0,3}}, 
      textString="%condition", 
      fontSize=10, 
      textStyle={TextStyle.Bold}, 
      textColor={74,84,154}, 
      horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText ="[df<30 or dl<20 or dr<20 or dfr <45]");
      transition(state1, state, dfr>40 and after(1,sec), reset = false) 
      annotation(Line(origin={-389.25,-276.713}, 
      points={{-56.75,0},{56.75,0}}, 
      color={113,119,170}, 
      smooth=Smooth.Bezier),Text(origin={-11.8425,7.04148}, 
      lineColor={74,84,154}, 
      extent={{0,-3},{0,3}}, 
      textString="%condition", 
      fontSize=10, 
      textStyle={TextStyle.Bold}, 
      textColor={74,84,154}, 
      horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[dfr>40 and after(1,sec)]");
      end State;
    equation
    initialState(zongde.cruise, true, 1) 
    annotation(Line(origin={-546,-104}, 
    points={{0,10},{0,-10}}, 
    color={113,119,170}, 
    smooth=Smooth.Bezier),Text(origin={0,0}, 
    lineColor={74,84,154}, 
    extent={{0,-3},{0,3}}, 
    textString="%condition", 
    fontSize=10, 
    textStyle={TextStyle.Bold}, 
    textColor={74,84,154}), displayText = "[true]");
    end Chart;
  model ModelWorkspace
    annotation(__MWORKS(hide = true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;
  equation
  connect(front_dist, abs1.u) 
  annotation(Line(origin={-71,36}, 
points={{-53,22},{-38.8,22}}, 
color={0,0,0}));
  connect(chart.speed, speed) 
  annotation(Line(origin={85,26}, 
points={{-59.2,-3.85},{-59.2,32},{81,32}}, 
color={0,0,0}));
  connect(saturation.u, sum1.y) 
  annotation(Line(origin={105,-58}, 
points={{23.2,26.5},{15,26.5},{15,60},{51,60},{51,86},{46.8,86}}, 
color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(chart.steer, sum1.u1) 
  annotation(Line(origin={45,-37}, 
points={{-19.2,44.65},{-19.2,70},{83.2,70}}, 
color={0,0,0}));
  connect(constant1.y, sum2.u2) 
  annotation(Line(origin={9,-98}, 
points={{3.8,40},{21,40},{21,66.5},{31.2,66.5}}, 
color={0,0,0}));
  connect(chart.steer, sum2.u1) 
  annotation(Line(origin={16,-49}, 
points={{9.8,56.65},{24.2,56.65},{24.2,27.5}}, 
color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(constant2.y, product1.u2) 
  annotation(Line(origin={41,-81}, 
points={{22.8,23},{33,23},{33,44.5},{41.2,44.5}}, 
color={0,0,0}));
  connect(sum2.y, product1.u1) 
  annotation(Line(origin={59,-45}, 
points={{4.8,18.5},{23.2,18.5}}, 
color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(product1.y, roundingFunction.u) 
  annotation(Line(origin={77,-8}, 
points={{28.8,-23.5},{35,-23.5},{35,0},{-35,0},{-35,24},{-26.8,24}}, 
color={0,0,0}));
  connect(roundingFunction.y, gain.u) 
  annotation(Line(origin={78,16}, 
  points={{-4.2,0},{4.2,0}}, 
  color={0,0,0}));
  connect(gain.y, sum1.u2) 
  annotation(Line(origin={117,20}, 
points={{-11.2,-4},{-4.1,-4},{-4.1,3},{11.2,3}}, 
color={0,0,0}));
  connect(fl_dist, abs2.u) 
  annotation(Line(origin={-117,16}, 
  points={{-7,0},{7.2,0}}, 
  color={0,0,0}));
  connect(left_dist, abs3.u) 
  annotation(Line(origin={-117,-64.3}, 
points={{-7,0},{7.2,0}}, 
color={0,0,0}));
  connect(right_dist, abs4.u) 
  annotation(Line(origin={-117,-18.6}, 
points={{-7,0},{7.2,0}}, 
color={0,0,0}));
  connect(fr_dist, abs5.u) 
  annotation(Line(origin={-117,-110}, 
  points={{-7,0},{7.2,0}}, 
  color={0,0,0}));
  connect(abs5.y, chart.dfr) 
  annotation(Line(origin={-67,-70}, 
points={{-19.2,-40},{9,-40},{9,47.2},{31.2,47.2}}, 
color={0,0,0}));
  connect(chart.gapS, gap) 
  annotation(Line(origin={89,-68}, 
points={{-63.2,61.15},{-63.2,-42},{77,-42}}, 
color={0,0,0}));
  connect(abs2.y, chart.dfl) 
  annotation(Line(origin={-67,10}, 
points={{-19.2,6},{-19.2,2},{31.2,2}}, 
color={0,0,0}));
  connect(abs1.y, chart.df) 
  annotation(Line(origin={-67,37}, 
points={{-19.2,21},{31.2,21},{31.2,-13.4}}, 
color={0,0,0}));
  connect(abs4.y, chart.dr) 
  annotation(Line(origin={-67,-13}, 
points={{-19.2,-5.6},{-19.2,13.4},{31.2,13.4}}, 
color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(abs3.y, chart.dl) 
  annotation(Line(origin={-67,-41}, 
points={{-19.2,-23.3},{31.2,-23.3},{31.2,29.8}}, 
color={0,0,0}));
  connect(saturation.y, steer) 
  annotation(Line(origin={159,-45}, 
  points={{-7.2,13.5},{7,13.5},{7,-13}}, 
  color={0,0,0}));
  connect(chart.u4, u4) 
  annotation(Line(origin={110,-6}, 
points={{-84.2,-15.35},{78,-15.35},{78,16}}, 
color={0,0,0}));
  end test4;