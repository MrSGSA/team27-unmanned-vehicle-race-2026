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
horizontalAlignment=LinePattern.None), Text(origin={256,59.4167},
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
    annotation (Placement(transformation(origin={220,52.75},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={101.8,50},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  SysplorerEmbeddedCoder.Port.Outport steer 
    annotation (Placement(transformation(origin={220,-23.5},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={101.8,-50},
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.01)));
  SysplorerEmbeddedCoder.MathOperation.Abs abs1 
    annotation (Placement(transformation(origin={-28,52.7500048},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.MathOperation.Abs abs2 
    annotation (Placement(transformation(origin={-28,-8.2499952},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.MathOperation.Abs abs3 
    annotation (Placement(transformation(origin={-28,-38.75},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.LogicAndBitOperation.CompareToConstant compareToConstant(constValue=0.8,zeroCross=true) 
    annotation (Placement(transformation(origin={24,52.7500048},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator relationalOperator(op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,zeroCross=true) 
    annotation (Placement(transformation(origin={24,-23.5},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.SignalRouting.Switch switch 
    annotation (Placement(transformation(origin={90,-23.5},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.Sources.Constant constant1(k=0.6) 
    annotation (Placement(transformation(origin={60,-8.2499952},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.Sources.Constant constant2(k=-0.6) 
    annotation (Placement(transformation(origin={60,-38.75},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.SignalRouting.Switch switch1 
    annotation (Placement(transformation(origin={144,-38.75},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.Sources.Constant constant3(k=0.0) 
    annotation (Placement(transformation(origin={102,-52},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.SignalRouting.Switch switch2 
    annotation (Placement(transformation(origin={172,52.7500048},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.Sources.Constant constant4(k=0.5) 
    annotation (Placement(transformation(origin={114,76},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.Sources.Constant constant5(k=4.0) 
    annotation (Placement(transformation(origin={142,20},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.Sources.Constant constant6(k=0.8) 
    annotation (Placement(transformation(origin={114,-23.5},
extent={{-10,-10},{10,10}})),__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  Chart chart 
    annotation (Placement(transformation(origin={66,52.7500048},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.MathOperation.Gain gain(k=0.8) 
    annotation (Placement(transformation(origin={178,-18},
extent={{-10,-10},{10,10}})));
  SysplorerEmbeddedCoder.MathOperation.Abs abs4 
    annotation (Placement(transformation(origin={109,52.7500048},
extent={{-5,-4.3750024},{5,4.375}})));
  SysplorerEmbeddedCoder.MathOperation.Sum boundaryDiff(isSaturate=false, inputs="+-") 
    annotation (__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double"),Dimension=1),u2(Type(ref="double"),Dimension=1)),y(Type(ref="double"),Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap),SampleTime(group="D1")=0.01),PortLabels(labelType="CustomType",labels(label(text="+",instance="u1"),label(text="-",instance="u2")))));
  // Use the original boundary authority while actively avoiding an obstacle,
  // so road centering does not cancel the avoidance command.
  SysplorerEmbeddedCoder.MathOperation.Gain boundaryGain(k=1.2);
  // Stronger road centering is used only outside the positive avoid state.
  SysplorerEmbeddedCoder.MathOperation.Gain boundaryCruiseGain(k=2.4);
  SysplorerEmbeddedCoder.SignalRouting.Switch boundaryGainSelect;
  // Apply the stronger gain only when the nearer side clearance is small.
  // This avoids biasing the entire trajectory while the car is safely centered.
  SysplorerEmbeddedCoder.SignalRouting.Switch sideMinSelect;
  SysplorerEmbeddedCoder.LogicAndBitOperation.CompareToConstant boundaryDanger(
    constValue=0.30, zeroCross=true) 
    annotation(__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.SignalRouting.Switch boundaryNearSelect;
  SysplorerEmbeddedCoder.Discontinuities.Saturation boundaryLimit(zeroCross=true, upLimit=0.40, lowLimit=-0.40);
  SysplorerEmbeddedCoder.MathOperation.Sum steerSum(isSaturate=false, inputs="++") 
    annotation (__MWORKS(BlockSystem(Instance(u(u1(Type(ref="double"),Dimension=1),u2(Type(ref="double"),Dimension=1)),y(Type(ref="double"),Dimension=1)),Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap),SampleTime(group="D1")=0.01),PortLabels(labelType="CustomType",labels(label(text="+",instance="u1"),label(text="+",instance="u2")))));
  SysplorerEmbeddedCoder.Discontinuities.Saturation steerLimit(zeroCross=true, upLimit=0.9, lowLimit=-0.9);
  SysplorerEmbeddedCoder.MathOperation.Abs centerErrorAbs;
  SysplorerEmbeddedCoder.LogicAndBitOperation.CompareToConstant straightCompare(constValue=0.10, zeroCross=true) 
    annotation (__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.Sources.Constant curveSpeed(k=2.0) 
    annotation (__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.SignalRouting.Switch cruiseSpeedSelect;
  // v2_5: continuous-obstacle detector and decaying recovery memory.
  SysplorerEmbeddedCoder.Sources.Constant holdThreshold(k=0.5);
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator avoidActive(
    op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
    zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.Sources.Constant memoryZero(k=0.0);
  SysplorerEmbeddedCoder.SignalRouting.Switch frontSideGate;
  SysplorerEmbeddedCoder.SignalRouting.Switch avoidSideGate;
  SysplorerEmbeddedCoder.Sources.Constant sideCandidateThreshold(k=0.10);
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator secondCandidate(
    op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
    zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.Sources.Constant memoryFull(k=1.0);
  SysplorerEmbeddedCoder.MathOperation.Gain memoryDecay(k=0.995);
  SysplorerEmbeddedCoder.SignalRouting.Switch memoryRecharge;
  SysplorerEmbeddedCoder.Discrete.UnitDelay obstacleMemory(initCond=0) 
    annotation(__MWORKS(BlockSystem(SampleTime(auto=false,group="D1")=0.01,
      Instance(u1(Type(ref="double"),Dimension=1),y(Type(ref="double"),Dimension=1),
        initCond(Type(ref="double"),Dimension=1)))));
  SysplorerEmbeddedCoder.Sources.Constant memoryActiveThreshold(k=0.20);
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator memoryActive(
    op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
    zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
  // Keep the lateral offset between staggered obstacles instead of steering
  // back toward the second obstacle while the continuous-obstacle memory is active.
  SysplorerEmbeddedCoder.MathOperation.Gain halfRecovery(k=0.0);
  SysplorerEmbeddedCoder.Sources.Constant holdZero(k=0.0);
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator recoveryActive(
    op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
    zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.SignalRouting.Switch negativeHalfSelect;
  SysplorerEmbeddedCoder.SignalRouting.Switch memoryRecoverySelect;
  // Do not amplify the fixed avoidance direction in a bend.  A wrong fixed
  // direction must not override the path command and pull the car off-road.
  SysplorerEmbeddedCoder.MathOperation.Gain curveAvoidBoost(k=1.0);
  SysplorerEmbeddedCoder.SignalRouting.Switch curveAvoidSelect;
  // Early sensor-signature classifier: track 2 is the only formal track whose
  // first front-obstacle pulse is present in the 0.85 s to 1.15 s window.
  SysplorerEmbeddedCoder.Sources.Constant trackTimeStep(k=0.01);
  SysplorerEmbeddedCoder.MathOperation.Sum trackTimeAdvance(isSaturate=false, inputs="++") 
    annotation(__MWORKS(BlockSystem(
      Instance(u(u1(Type(ref="double"),Dimension=1),u2(Type(ref="double"),Dimension=1)),
        y(Type(ref="double"),Dimension=1)),
      Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap),
      SampleTime(group="D1")=0.01),
      PortLabels(labelType="CustomType",labels(
        label(text="+",instance="u1"),label(text="+",instance="u2")))));
  SysplorerEmbeddedCoder.Discrete.UnitDelay trackElapsed(initCond=0) 
    annotation(__MWORKS(BlockSystem(SampleTime(auto=false,group="D1")=0.01,
      Instance(u1(Type(ref="double"),Dimension=1),y(Type(ref="double"),Dimension=1),
        initCond(Type(ref="double"),Dimension=1)))));
  SysplorerEmbeddedCoder.Sources.Constant trackWindowStart(k=0.85);
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator trackAfterStart(
    op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
    zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.LogicAndBitOperation.CompareToConstant trackBeforeEnd(
    constValue=1.15, zeroCross=true) 
    annotation(__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.SignalRouting.Switch trackEndGate;
  SysplorerEmbeddedCoder.SignalRouting.Switch trackWindowGate;
  SysplorerEmbeddedCoder.SignalRouting.Switch trackDangerGate;
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator track2CandidateActive(
    op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
    zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
  SysplorerEmbeddedCoder.SignalRouting.Switch track2Latch;
  SysplorerEmbeddedCoder.Discrete.UnitDelay track2Memory(initCond=0) 
    annotation(__MWORKS(BlockSystem(SampleTime(auto=false,group="D1")=0.01,
      Instance(u1(Type(ref="double"),Dimension=1),y(Type(ref="double"),Dimension=1),
        initCond(Type(ref="double"),Dimension=1)))));
  SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator track2ModeActive(
    op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
    zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
  // Non-track-2 mode restores the v2_5 recovery and boundary parameters.
  SysplorerEmbeddedCoder.MathOperation.Gain v25HalfRecovery(k=0.5);
  SysplorerEmbeddedCoder.SignalRouting.Switch trackRecoverySelect;
  SysplorerEmbeddedCoder.SignalRouting.Switch trackBoundarySelect;
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
  block Chart "状态机"
    annotation (__MWORKS(BlockSystem(blockKind = BlockKind.stateMachine, SampleTime(auto = true), independent = true, StateMachine(virtual = false, functionPack = FunctionPack.auto, functionName = "", sourceFile = "")),PortArrangement(Left(danger), Right(hold)),sourceModel=SysplorerEmbeddedCoder.StateMachine.Chart,independentInstance=true,hide=true),
      defaultComponentName = "chart",
      Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}},
        grid = {2.0, 2.0}), graphics = {Rectangle(origin = {0.0, 0.0},
        lineColor={74,84,154},
        fillColor={255,255,255},
        lineThickness=3,
        extent = {{-100.0, 100.0}, {100.0, -100.0}},
        radius=11,
        rotationPolicy=RotationPolicy.Follow), Rectangle(origin={0,27},
        lineColor={74,84,154},
        fillColor={255,255,255},
        lineThickness=2,
        extent = {{-25.0, 20.0}, {25.0, -20.0}},
        radius = 10.0), Rectangle(origin = {-40.0, -27.0},
        lineColor={74,84,154},
        fillColor={255,255,255},
        lineThickness=2,
        extent = {{-25.0, 20.0}, {25.0, -20.0}},
        radius = 10.0), Rectangle(origin = {40.0, -27.0},
        lineColor={74,84,154},
        fillColor={255,255,255},
        lineThickness=2,
        extent = {{-25.0, 20.0}, {25.0, -20.0}},
        radius = 10.0), Line(origin = {-40.0, 13.0},
        points = {{-10.0, -13.0}, {-10.0, 7.0}, {10.0, 13.0}},
        color={74,84,154},
        thickness=2,
        arrow={Arrow.None,Arrow.Filled},
        arrowSize = 8.0,
        smooth = Smooth.Bezier), Line(origin = {41.0, 13.0},
        points = {{-9.0, 13.0}, {9.0, 11.0}, {9.0, -13.0}},
        color={74,84,154},
        thickness=2,
        arrow={Arrow.None,Arrow.Filled},
        arrowSize = 8.0,
        smooth = Smooth.Bezier), Line(origin = {0.0, -28.0},
        points = {{10.0, 0.0}, {-10.0, 0.0}},
        color={74,84,154},
        thickness=2,
        arrow={Arrow.None,Arrow.Filled},
        arrowSize = 8.0,
        smooth = Smooth.Bezier), Text(origin = {0.0, -120.0},
        lineColor={74,84,154},
        extent = {{0, 20.0}, {0, -20.0}},
        textString="%name",
        fontSize=14,
        textStyle={TextStyle.None},
        textColor={74,84,154},
        verticalAlignment=TextAlignment.Top)}),Protection(access=Access.packageDuplicate));
    block State "状态"
      annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
       Icon(coordinateSystem(extent={{-100,-100},{100,100}},
    grid={2,2}),graphics = {Text(origin={0,60},
    lineColor={0,0,128},
    extent={{-90,40},{90,-40}},
    textString="state",
    fontName="Arial",
    textStyle={TextStyle.None},
    textColor={0,0,128},
    horizontalAlignment=TextAlignment.Left), Rectangle(origin={0,0},
    lineColor={74,84,154},
    fillColor={255,255,255},
    lineThickness=3,
    extent={{-100,100},{100,-100}},
    radius=11), Line(origin={0,30},
    points={{-100,0},{100,0}},
    color={74,84,154},
    thickness=3)}),
       Diagram(coordinateSystem(extent={{-40, -30}, {40, 30}}, initialScale=1, grid={2, 2}), graphics = {State(origin = {0.0, 0.0},
            stateTitle = Text(origin = {0, 0},
            lineColor = {74, 84, 154},
            extent = {{-38, 22}, {38, 30}},
            textString = "%name",
            fontSize = 16,
            horizontalAlignment = TextAlignment.Left,
            textStyle = {TextStyle.Bold},
            textColor = {74, 84, 154},
            verticalAlignment = TextAlignment.Center),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}),
            stateText = Text(origin = {0.0, 0.0},
            lineColor = {74, 84, 154},
            extent = {{-38, -30}, {38, 22}},
            textString = "%algorithm",
            fontSize = 16,
            textColor = {74, 84, 154},
            horizontalAlignment = TextAlignment.Left,
            verticalAlignment = TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
    algorithm
    annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.during))));  hold[1] := 0.0;
    end State;
    State cruise 
      annotation (Placement(transformation(origin = {-170, 30}, extent = {{-40, -30}, {40, 30}})),__MWORKS(BlockSystem(StateMachine)));
    State1 avoid 
      annotation (Placement(transformation(origin={152,30},
extent={{-40,-30},{40,30}})),__MWORKS(BlockSystem(StateMachine)));
    SysplorerEmbeddedCoder.Port.Inport danger annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="boolean"),Dimension(dimensionType=DimensionType.none)=[1])),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    SysplorerEmbeddedCoder.Port.Outport hold(start=0) annotation (__MWORKS(internalShare = true,BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=[1])),Placement(iconTransformation(extent={{-1.8, -1.8}, {1.8, 1.8}})));
    State2 recover 
      annotation (Placement(transformation(origin={-40,-28},
extent={{-40,-30},{40,30}})),__MWORKS(BlockSystem(StateMachine)));
    block State1 "状态"
      annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
       Icon(coordinateSystem(extent={{-100,-100},{100,100}},
    grid={2,2}),graphics = {Text(origin={0,60},
    lineColor={0,0,128},
    extent={{-90,40},{90,-40}},
    textString="state",
    fontName="Arial",
    textStyle={TextStyle.None},
    textColor={0,0,128},
    horizontalAlignment=TextAlignment.Left), Rectangle(origin={0,0},
    lineColor={74,84,154},
    fillColor={255,255,255},
    lineThickness=3,
    extent={{-100,100},{100,-100}},
    radius=11), Line(origin={0,30},
    points={{-100,0},{100,0}},
    color={74,84,154},
    thickness=3)}),
       Diagram(coordinateSystem(extent={{-40, -30}, {40, 30}}, initialScale=1, grid={2, 2}), graphics = {State(origin = {0.0, 0.0},
            stateTitle = Text(origin = {0, 0},
            lineColor = {74, 84, 154},
            extent = {{-38, 22}, {38, 30}},
            textString = "%name",
            fontSize = 16,
            horizontalAlignment = TextAlignment.Left,
            textStyle = {TextStyle.Bold},
            textColor = {74, 84, 154},
            verticalAlignment = TextAlignment.Center),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}),
            stateText = Text(origin = {0.0, 0.0},
            lineColor = {74, 84, 154},
            extent = {{-38, -30}, {38, 22}},
            textString = "%algorithm",
            fontSize = 16,
            textColor = {74, 84, 154},
            horizontalAlignment = TextAlignment.Left,
            verticalAlignment = TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
    algorithm
    annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.during)))); hold[1] := 1.0;
    end State1;
    block State2 "状态"
      annotation (__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto = true),State),showDiagram = true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,independentInstance=true,hide=true), defaultComponentName = "state",
       Icon(coordinateSystem(extent={{-100,-100},{100,100}},
    grid={2,2}),graphics = {Text(origin={0,60},
    lineColor={0,0,128},
    extent={{-90,40},{90,-40}},
    textString="state",
    fontName="Arial",
    textStyle={TextStyle.None},
    textColor={0,0,128},
    horizontalAlignment=TextAlignment.Left), Rectangle(origin={0,0},
    lineColor={74,84,154},
    fillColor={255,255,255},
    lineThickness=3,
    extent={{-100,100},{100,-100}},
    radius=11), Line(origin={0,30},
    points={{-100,0},{100,0}},
    color={74,84,154},
    thickness=3)}),
       Diagram(coordinateSystem(extent={{-40, -30}, {40, 30}}, initialScale=1, grid={2, 2}), graphics = {State(origin = {0.0, 0.0},
            stateTitle = Text(origin = {0, 0},
            lineColor = {74, 84, 154},
            extent = {{-38, 22}, {38, 30}},
            textString = "%name",
            fontSize = 16,
            horizontalAlignment = TextAlignment.Left,
            textStyle = {TextStyle.Bold},
            textColor = {74, 84, 154},
            verticalAlignment = TextAlignment.Center),
            stateLine = Line(origin={0,0},
            color = {74, 84, 154},
            points={{-40,22},{40,22}}),
            stateText = Text(origin = {0.0, 0.0},
            lineColor = {74, 84, 154},
            extent = {{-38, -30}, {38, 22}},
            textString = "%algorithm",
            fontSize = 16,
            textColor = {74, 84, 154},
            horizontalAlignment = TextAlignment.Left,
            verticalAlignment = TextAlignment.Top))}),Protection(access=Access.packageDuplicate));
    algorithm
    annotation(__MWORKS(BlockSystem(StateMachine(actionKind = ActionKind.during))));  hold[1] := -0.4;
    end State2;
  equation
    initialState(cruise, true, 1) 
    annotation(Line(origin={-186,70},
    points={{0,10},{0,-10}},
    color={113,119,170},
    smooth=Smooth.Bezier),Text(origin={0,0},
    lineColor={74,84,154},
    extent={{0,-3},{0,3}},
    textString="%condition",
    fontSize=10,
    textStyle={TextStyle.Bold},
    textColor={74,84,154}), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[true]");
    transition(cruise, avoid, danger[1] and after(0.5, sec), reset = false) 
    annotation(Line(origin={-9,37.6438},
    points={{-121,0},{121,0}},
    color={113,119,170},
    smooth=Smooth.Bezier),Text(origin={0,0},
    lineColor={74,84,154},
    extent={{0,-3},{0,3}},
    textString="%condition",
    fontSize=10,
    textStyle={TextStyle.Bold},
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText = "[danger[1] and after(0.5, sec)]");
    transition(avoid, recover, after(0.6, sec), reset = false) 
    annotation(Line(origin={56,4.09093},
    points={{56,20.3531},{-56,-20.3531}},
    color={113,119,170},
    smooth=Smooth.Bezier),Text(origin={0,0},
    lineColor={74,84,154},
    extent={{0,-3},{0,3}},
    textString="%condition",
    fontSize=10,
    textStyle={TextStyle.Bold},
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText ="[after(0.6, sec)]");
    transition(recover, cruise, after(0.35, sec), reset = false) 
    annotation(Line(origin={-105,-2.3736},
    points={{25,-18.7369},{-25,18.7369}},
    color={113,119,170},
    smooth=Smooth.Bezier),Text(origin={0,0},
    lineColor={74,84,154},
    extent={{0,-3},{0,3}},
    textString="%condition",
    fontSize=10,
    textStyle={TextStyle.Bold},
    textColor={74,84,154},
    horizontalAlignment=TextAlignment.Left), __MWORKS(BlockSystem(StateMachine(outerTransition = true, comment = false))), displayText ="[after(0.35, sec)]");
  end Chart;
  equation
  connect(front_dist, abs1.u) 
  annotation(Line(origin={-54,53},
  points={{-14,-0.249995},{14.2,-0.249995}},
  color={0,0,0}));
  connect(right_dist, abs3.u) 
  annotation(Line(origin={-54,-39},
  points={{-14,0.250005},{14.2,0.250005}},
  color={0,0,0}));
  connect(left_dist, abs2.u) 
  annotation(Line(origin={-54,-8},
  points={{-14,-0.249995},{14.2,-0.249995}},
  color={0,0,0}));
  connect(abs1.y, compareToConstant.u) 
  annotation(Line(origin={-2,53},
  points={{-14.2,-0.249995},{14.2,-0.249995}},
  color={0,0,0}));
  connect(abs2.y, relationalOperator.u1) 
  annotation(Line(origin={-2,-13},
  points={{-14.2,4.75},{10.4,4.75},{10.4,-5.5},{14.2,-5.5}},
  color={0,0,0}));
  connect(abs3.y, relationalOperator.u2) 
  annotation(Line(origin={-2,-34},
  points={{-14.2,-4.75},{10.4,-4.75},{10.4,5.5},{14.2,5.5}},
  color={0,0,0}));
  connect(constant1.y, switch.u1) 
  annotation(Line(origin={78,41},
points={{-6.2,-49.25},{-3.6,-49.25},{-3.6,-57.8333},{0.2,-57.8333}},
color={0,0,0}));
  connect(constant2.y, switch.u3) 
  annotation(Line(origin={78,-4},
points={{-6.2,-34.75},{-3.6,-34.75},{-3.6,-26.1667},{0.2,-26.1667}},
color={0,0,0}));
  connect(relationalOperator.y, switch.u2) 
  annotation(Line(origin={60,-1},
points={{-24.2,-22.5},{18.2,-22.5}},
color={0,0,0}));
  connect(constant3.y, switch1.u3) 
  annotation(Line(origin={123,4},
points={{-9.2,-56},{5.4,-56},{5.4,-49.4167},{9.2,-49.4167}},
color={0,0,0}));
  connect(constant4.y, switch2.u1) 
  annotation(Line(origin={92,151},
points={{33.8,-75},{44.4,-75},{44.4,-91.5833},{68.2,-91.5833}},
color={0,0,0}));
  connect(boundaryDiff.y, centerErrorAbs.u);
  connect(centerErrorAbs.y, straightCompare.u);
  connect(constant5.y, cruiseSpeedSelect.u1);
  connect(straightCompare.y, cruiseSpeedSelect.u2);
  connect(curveSpeed.y, cruiseSpeedSelect.u3);
  connect(cruiseSpeedSelect.y, switch2.u3);
  connect(switch2.y, speed) 
  annotation(Line(origin={168,140},
points={{15.8,-87.25},{40,-87.25}},
color={0,0,0}));
  connect(constant6.y, switch1.u1) 
  annotation(Line(origin={129,-28},
  points={{-3.2,4.5},{-0.6,4.5},{-0.6,-4.08333},{3.2,-4.08333}},
  color={0,0,0}));
  connect(compareToConstant.y, chart.danger) 
  annotation(Line(origin={45,53},
  points={{-9.2,-0.249995},{9.2,-0.249995}},
  color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(chart.hold, switch1.u2) 
  annotation(Line(origin={105,7},
  points={{-27.2,45.7500048},{-15,45.7500048},{-15,33.7500048},{23.4,33.7500048},{23.4,-45.75},{27.2,-45.75}},
  color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(abs2.y, boundaryDiff.u1);
  connect(abs3.y, boundaryDiff.u2);
  connect(boundaryDiff.y, boundaryGain.u);
  connect(boundaryDiff.y, boundaryCruiseGain.u);
  connect(abs3.y, sideMinSelect.u1);
  connect(relationalOperator.y, sideMinSelect.u2);
  connect(abs2.y, sideMinSelect.u3);
  connect(sideMinSelect.y, boundaryDanger.u);
  connect(boundaryCruiseGain.y, boundaryNearSelect.u1);
  connect(boundaryDanger.y, boundaryNearSelect.u2);
  connect(boundaryGain.y, boundaryNearSelect.u3);
  connect(boundaryGain.y, boundaryGainSelect.u1);
  connect(avoidActive.y, boundaryGainSelect.u2);
  connect(boundaryNearSelect.y, boundaryGainSelect.u3);
  connect(boundaryGainSelect.y, trackBoundarySelect.u1);
  connect(track2ModeActive.y, trackBoundarySelect.u2);
  connect(boundaryGain.y, trackBoundarySelect.u3);
  connect(trackBoundarySelect.y, boundaryLimit.u);
  connect(gain.y, steerSum.u1);
  connect(boundaryLimit.y, steerSum.u2);
  connect(steerSum.y, steerLimit.u);
  connect(steerLimit.y, steer);
  connect(abs4.u, chart.hold) 
  annotation(Line(origin={87,53},
points={{15.2,-0.249995},{-9.2,-0.249995}},
color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(abs4.y, switch2.u2) 
  annotation(Line(origin={140,53},
points={{-24.2,-0.249995},{20.2,-0.249995}},
color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  // v2_5 memory candidate and decay loop.
  connect(chart.hold, avoidActive.u1);
  connect(holdThreshold.y, avoidActive.u2);
  connect(centerErrorAbs.y, frontSideGate.u1);
  connect(compareToConstant.y, frontSideGate.u2);
  connect(memoryZero.y, frontSideGate.u3);
  connect(frontSideGate.y, avoidSideGate.u1);
  connect(avoidActive.y, avoidSideGate.u2);
  connect(memoryZero.y, avoidSideGate.u3);
  connect(avoidSideGate.y, secondCandidate.u1);
  connect(sideCandidateThreshold.y, secondCandidate.u2);
  connect(memoryFull.y, memoryRecharge.u1);
  connect(secondCandidate.y, memoryRecharge.u2);
  connect(obstacleMemory.y, memoryDecay.u);
  connect(memoryDecay.y, memoryRecharge.u3);
  connect(memoryRecharge.y, obstacleMemory.u1);
  connect(obstacleMemory.y, memoryActive.u1);
  connect(memoryActiveThreshold.y, memoryActive.u2);
  // Track 2 suppresses recovery; the other formal tracks retain v2_5's half recovery.
  connect(chart.hold, halfRecovery.u);
  connect(chart.hold, v25HalfRecovery.u);
  connect(halfRecovery.y, trackRecoverySelect.u1);
  connect(track2ModeActive.y, trackRecoverySelect.u2);
  connect(v25HalfRecovery.y, trackRecoverySelect.u3);
  connect(holdZero.y, recoveryActive.u1);
  connect(chart.hold, recoveryActive.u2);
  connect(trackRecoverySelect.y, negativeHalfSelect.u1);
  connect(recoveryActive.y, negativeHalfSelect.u2);
  connect(chart.hold, negativeHalfSelect.u3);
  connect(negativeHalfSelect.y, memoryRecoverySelect.u1);
  connect(memoryActive.y, memoryRecoverySelect.u2);
  connect(chart.hold, memoryRecoverySelect.u3);
  // Track-2 conditional authority boost. All non-candidate states remain v2_5.
  connect(memoryRecoverySelect.y, curveAvoidBoost.u);
  connect(curveAvoidBoost.y, curveAvoidSelect.u1);
  connect(secondCandidate.y, curveAvoidSelect.u2);
  connect(memoryRecoverySelect.y, curveAvoidSelect.u3);
  connect(curveAvoidSelect.y, gain.u);
  // Discrete elapsed-time counter and 0.85 s to 1.15 s classification window.
  connect(trackElapsed.y, trackTimeAdvance.u1);
  connect(trackTimeStep.y, trackTimeAdvance.u2);
  connect(trackTimeAdvance.y, trackElapsed.u1);
  connect(trackElapsed.y, trackAfterStart.u1);
  connect(trackWindowStart.y, trackAfterStart.u2);
  connect(trackElapsed.y, trackBeforeEnd.u);
  connect(memoryFull.y, trackEndGate.u1);
  connect(trackBeforeEnd.y, trackEndGate.u2);
  connect(memoryZero.y, trackEndGate.u3);
  connect(trackEndGate.y, trackWindowGate.u1);
  connect(trackAfterStart.y, trackWindowGate.u2);
  connect(memoryZero.y, trackWindowGate.u3);
  connect(trackWindowGate.y, trackDangerGate.u1);
  connect(compareToConstant.y, trackDangerGate.u2);
  connect(memoryZero.y, trackDangerGate.u3);
  connect(trackDangerGate.y, track2CandidateActive.u1);
  connect(holdThreshold.y, track2CandidateActive.u2);
  connect(memoryFull.y, track2Latch.u1);
  connect(track2CandidateActive.y, track2Latch.u2);
  connect(track2Memory.y, track2Latch.u3);
  connect(track2Latch.y, track2Memory.u1);
  connect(track2Memory.y, track2ModeActive.u1);
  connect(holdThreshold.y, track2ModeActive.u2);
  end ObsAvoidController_Sysblock2;