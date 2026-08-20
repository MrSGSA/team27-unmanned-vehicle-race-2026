model ObsAvoidController_Team27_MWorks
  "Team27纯MWORKS五固定超声波阿克曼连续避障控制器V3.8"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(version="26.3.0",modelType=Control,PortArrangement(
Left(front_dist, rear_dist, right_dist, left_dist, fu_dist),
Right(speed, steer, gap, fu_sensor_cmd)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.05,OutputInterval=0.05),SysblockVersion="1.0",ContinueSimConfig(SaveContinueFile="false",SaveBeforeStop="false",
NumberBeforeStop=1,FixedContinueInterval="false",
ContinueIntervalLength=100,ContinueTimeVector)),
    Icon(coordinateSystem(preserveAspectRatio=false)),
    experiment(Algorithm=Rkfix4,Interval=0.05,StartTime=0,StopTime=2,
      IntegratorStep=0.05,StoreEventValue=0),
    Diagram(coordinateSystem(extent={{-180,-140},{180,140}},grid={2,2}),
      graphics={
        Text(origin={-145,92},extent={{-28,8},{28,-8}},textString="dis1 前中0度"),
        Text(origin={-145,46},extent={{-28,8},{28,-8}},textString="dis5 左前约30度"),
        Text(origin={-145,0},extent={{-28,8},{28,-8}},textString="dis3 正右90度"),
        Text(origin={-145,-46},extent={{-28,8},{28,-8}},textString="dis4 正左90度"),
        Text(origin={-145,-92},extent={{-28,8},{28,-8}},textString="dis2 右前约30度"),
        Text(origin={142,92},extent={{-28,8},{28,-8}},textString="正向速度RPM"),
        Text(origin={142,30},extent={{-28,8},{28,-8}},textString="阿克曼转角rad"),
        Text(origin={142,-30},extent={{-28,8},{28,-8}},textString="差速保持0"),
        Text(origin={142,-92},extent={{-28,8},{28,-8}},textString="扫描舵机保持0") }));

  // Keep the historic port names so the official top-level model and
  // GetCarMsg/SetMsg interface remain untouched.  V3 physical mapping:
  // front_dist = dis1 Front-Centre
  // rear_dist  = dis5 Front-Left (the former rear sensor)
  // right_dist = dis3 Side-Right 90 degrees
  // left_dist  = dis4 Side-Left  90 degrees
  // fu_dist    = dis2 Front-Right (former servo sensor, now fixed)
  SysplorerEmbeddedCoder.Port.Inport front_dist 
    annotation(Placement(transformation(origin={-160,92},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport rear_dist 
    annotation(Placement(transformation(origin={-160,46},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport right_dist 
    annotation(Placement(transformation(origin={-160,0},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport left_dist 
    annotation(Placement(transformation(origin={-160,-46},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport fu_dist 
    annotation(Placement(transformation(origin={-160,-92},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));

  SysplorerEmbeddedCoder.Port.Outport speed 
    annotation(Placement(transformation(origin={160,92},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Outport steer 
    annotation(Placement(transformation(origin={160,30},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Outport gap 
    annotation(Placement(transformation(origin={160,-30},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Outport fu_sensor_cmd 
    annotation(Placement(transformation(origin={160,-92},extent={{-8,-8},{8,8}})),
      __MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));

  SysplorerEmbeddedCoder.MathOperation.Abs absFC;
  SysplorerEmbeddedCoder.MathOperation.Abs absFL;
  SysplorerEmbeddedCoder.MathOperation.Abs absFR;
  SysplorerEmbeddedCoder.MathOperation.Abs absSL;
  SysplorerEmbeddedCoder.MathOperation.Abs absSR;
  DistanceConditioner filterFC;
  DistanceConditioner filterFL;
  DistanceConditioner filterFR;
  DistanceConditioner filterSL;
  DistanceConditioner filterSR;
  Chart chart annotation(Placement(transformation(origin={0,0},extent={{-45,-45},{45,45}})));
  SteeringRateLimiter steeringRateLimiter;
  SysplorerEmbeddedCoder.Discontinuities.Saturation steeringLimit(
    zeroCross=true,upLimit=0.58,lowLimit=-0.58);

  block DistanceConditioner "Fast ultrasonic validity/dropout conditioner"
    annotation(__MWORKS(
      PortArrangement(Left(raw),Right(y)),
      BlockSystem(blockKind=BlockKind.subSystem,SampleTime(auto=true,group="D1")=0.05,
        SubSystem(virtual=false,functionPack=FunctionPack.auto,functionName="",sourceFile="")),
      independentInstance=true,hide=true,
      sourceModel=SysplorerEmbeddedCoder.SubSystems.SubSystem));

    SysplorerEmbeddedCoder.Port.Inport raw 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.Port.Outport y 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));

    SysplorerEmbeddedCoder.Sources.Constant minValid(k=2);
    SysplorerEmbeddedCoder.Sources.Constant maxValid(k=250);
    SysplorerEmbeddedCoder.Sources.Constant one(k=1);
    SysplorerEmbeddedCoder.Sources.Constant zero(k=0);
    SysplorerEmbeddedCoder.Sources.Constant validThreshold(k=0.5);
    SysplorerEmbeddedCoder.Sources.Constant timeStep(k=0.05);
    // Three consecutive invalid samples fail safe.  Valid readings favour the
    // newest sample so a 20 cm warning is not delayed by the old long-range EMA.
    SysplorerEmbeddedCoder.Sources.Constant timeoutLimit(k=0.15);

    SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator aboveMin(
      op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
      zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
    SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator belowMax(
      op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
      zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
    SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator validActive(
      op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
      zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));
    SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator timeoutOk(
      op=SysplorerEmbeddedCoder.LogicAndBitOperation.RelationalOperator.Operators.Great,
      zeroCross=true) annotation(__MWORKS(BlockSystem(zeroCross=true)));

    SysplorerEmbeddedCoder.SignalRouting.Switch lowerGate;
    SysplorerEmbeddedCoder.SignalRouting.Switch rangeGate;
    SysplorerEmbeddedCoder.SignalRouting.Switch lowerValidNumber;
    SysplorerEmbeddedCoder.SignalRouting.Switch validNumber;
    SysplorerEmbeddedCoder.SignalRouting.Switch invalidAgeSelect;
    SysplorerEmbeddedCoder.SignalRouting.Switch failSafeGate;
    SysplorerEmbeddedCoder.MathOperation.Gain newWeight(k=0.90);
    SysplorerEmbeddedCoder.MathOperation.Gain oldWeight(k=0.10);
    SysplorerEmbeddedCoder.MathOperation.Sum smoothSum(isSaturate=false,inputs="++") 
      annotation(__MWORKS(BlockSystem(
        Instance(u(u1(Type(ref="double"),Dimension=1),u2(Type(ref="double"),Dimension=1)),
          y(Type(ref="double"),Dimension=1)),
        Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap),
        SampleTime(group="D1")=0.05),
        PortLabels(labelType="CustomType",labels(
          label(text="+",instance="u1"),label(text="+",instance="u2")))));
    SysplorerEmbeddedCoder.MathOperation.Sum invalidAgeAdvance(isSaturate=false,inputs="++") 
      annotation(__MWORKS(BlockSystem(
        Instance(u(u1(Type(ref="double"),Dimension=1),u2(Type(ref="double"),Dimension=1)),
          y(Type(ref="double"),Dimension=1)),
        Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap),
        SampleTime(group="D1")=0.05),
        PortLabels(labelType="CustomType",labels(
          label(text="+",instance="u1"),label(text="+",instance="u2")))));
    SysplorerEmbeddedCoder.Discrete.UnitDelay previousDistance(initCond=100);
    SysplorerEmbeddedCoder.Discrete.UnitDelay invalidAge(initCond=0);
  equation
    connect(raw,aboveMin.u1);
    connect(minValid.y,aboveMin.u2);
    connect(maxValid.y,belowMax.u1);
    connect(raw,belowMax.u2);
    connect(raw,lowerGate.u1);
    connect(aboveMin.y,lowerGate.u2);
    connect(previousDistance.y,lowerGate.u3);
    connect(lowerGate.y,rangeGate.u1);
    connect(belowMax.y,rangeGate.u2);
    connect(previousDistance.y,rangeGate.u3);
    connect(one.y,lowerValidNumber.u1);
    connect(aboveMin.y,lowerValidNumber.u2);
    connect(zero.y,lowerValidNumber.u3);
    connect(lowerValidNumber.y,validNumber.u1);
    connect(belowMax.y,validNumber.u2);
    connect(zero.y,validNumber.u3);
    connect(validNumber.y,validActive.u1);
    connect(validThreshold.y,validActive.u2);
    connect(rangeGate.y,newWeight.u);
    connect(previousDistance.y,oldWeight.u);
    connect(newWeight.y,smoothSum.u1);
    connect(oldWeight.y,smoothSum.u2);
    connect(smoothSum.y,previousDistance.u1);
    connect(invalidAge.y,invalidAgeAdvance.u1);
    connect(timeStep.y,invalidAgeAdvance.u2);
    connect(zero.y,invalidAgeSelect.u1);
    connect(validActive.y,invalidAgeSelect.u2);
    connect(invalidAgeAdvance.y,invalidAgeSelect.u3);
    connect(invalidAgeSelect.y,invalidAge.u1);
    connect(timeoutLimit.y,timeoutOk.u1);
    connect(invalidAge.y,timeoutOk.u2);
    connect(smoothSum.y,failSafeGate.u1);
    connect(timeoutOk.y,failSafeGate.u2);
    connect(zero.y,failSafeGate.u3);
    connect(failSafeGate.y,y);
  end DistanceConditioner;

  block SteeringRateLimiter "Ackermann steering slew limiter"
    annotation(__MWORKS(
      PortArrangement(Left(target),Right(y)),
      BlockSystem(blockKind=BlockKind.subSystem,SampleTime(auto=true,group="D1")=0.05,
        SubSystem(virtual=false,functionPack=FunctionPack.auto,functionName="",sourceFile="")),
      independentInstance=true,hide=true,
      sourceModel=SysplorerEmbeddedCoder.SubSystems.SubSystem));
    SysplorerEmbeddedCoder.Port.Inport target 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.Port.Outport y 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),
        Dimension(dimensionType=DimensionType.none)=1,SampleTime(group="D1")=0.05)));
    SysplorerEmbeddedCoder.MathOperation.Sum error(isSaturate=false,inputs="+-") 
      annotation(__MWORKS(BlockSystem(
        Instance(u(u1(Type(ref="double"),Dimension=1),u2(Type(ref="double"),Dimension=1)),
          y(Type(ref="double"),Dimension=1)),
        Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap),
        SampleTime(group="D1")=0.05),
        PortLabels(labelType="CustomType",labels(
          label(text="+",instance="u1"),label(text="-",instance="u2")))));
    // 0.16 rad/50 ms reaches 0.58 rad in about 0.20 s without a step jump.
    SysplorerEmbeddedCoder.Discontinuities.Saturation stepLimit(
      zeroCross=true,upLimit=0.16,lowLimit=-0.16);
    SysplorerEmbeddedCoder.MathOperation.Sum advance(isSaturate=false,inputs="++") 
      annotation(__MWORKS(BlockSystem(
        Instance(u(u1(Type(ref="double"),Dimension=1),u2(Type(ref="double"),Dimension=1)),
          y(Type(ref="double"),Dimension=1)),
        Type(overflowKind=SysplorerEmbeddedCoder.Types.OverflowKind.wrap),
        SampleTime(group="D1")=0.05),
        PortLabels(labelType="CustomType",labels(
          label(text="+",instance="u1"),label(text="+",instance="u2")))));
    SysplorerEmbeddedCoder.Discrete.UnitDelay previous(initCond=0);
  equation
    connect(target,error.u1);
    connect(previous.y,error.u2);
    connect(error.y,stepLimit.u);
    connect(stepLimit.y,advance.u1);
    connect(previous.y,advance.u2);
    connect(advance.y,previous.u1);
    connect(advance.y,y);
  end SteeringRateLimiter;

  block Chart "Five fixed ultrasonic continuous controller"
    annotation(__MWORKS(
      BlockSystem(blockKind=BlockKind.stateMachine,SampleTime(auto=true),independent=true,
        StateMachine(virtual=false,functionPack=FunctionPack.auto,functionName="",
          sourceFile="",parallel=false)),
      PortArrangement(Left(fc,fcRaw,fl,fr,sl,sr),Right(speed,steer,gapS,servo)),
      sourceModel=SysplorerEmbeddedCoder.StateMachine.Chart,
      independentInstance=true,hide=true),
      defaultComponentName="chart",
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}),graphics={
        Rectangle(extent={{-100,100},{100,-100}},radius=11),
        Text(origin={0,0},extent={{-90,20},{90,-20}},textString="5-US Continuous")}),
      Protection(access=Access.packageDuplicate));

    SysplorerEmbeddedCoder.Port.Inport fc annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport fcRaw annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport fl annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport fr annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport sl annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Inport sr annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Outport speed(start=0) annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Outport steer(start=0) annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Outport gapS(start=0) annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));
    SysplorerEmbeddedCoder.Port.Outport servo(start=0) annotation(__MWORKS(internalShare=true,
      BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension(dimensionType=DimensionType.none)=1)));

    // Distances are centimetres.  Positive steering is vehicle-left and
    // negative steering is vehicle-right, confirmed on the real car.
    SysplorerEmbeddedCoder.Types.Auto frontWarn(start=26) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontStrong(start=12) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontEmergency(start=5.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontRelease(start=30) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontSectorEmergency(start=4.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontDiagonalWarn(start=22) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontDiagonalRelease(start=26) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto sideEmergency(start=6) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto sideCorrection(start=10) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto scoreCap(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto unknownForward(start=10) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto unknownSide(start=8) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto pathFrontMinimum(start=9) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto pathSideMinimum(start=8) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontCornerRelease(start=10) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto trappedDistance(start=10) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto directionHysteresis(start=2.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto directionSwitchMargin(start=5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto directionConfirmTime(start=0.10) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto normalDeadband(start=3) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto clockwiseBias(start=0.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto directionLock(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto desiredDirection(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto candidateDirection(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto candidateTimer(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto avoidRequest(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto leftPathAllowed(start=1) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto rightPathAllowed(start=1) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto flEff(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frEff(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto slEff(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto srEff(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto flCap(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frCap(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto slCap(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto srCap(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto leftScore(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto rightScore(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto leftSideReach(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto rightSideReach(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto steeringMagnitude(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto closestFront(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto normalSteer(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto pocketDistance(start=11) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto turnEscapeSpeed(start=45) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto corridorCenterMinimum(start=18) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto corridorCornerMinimum(start=12) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto corridorPassAllowed(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto tightStopDistance(start=18) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto tightStopRequest(start=0) annotation(__MWORKS(internalShare=true));
    // No rear-facing sensor remains in the V3 layout.  Backup is therefore a
    // one-shot clearance manoeuvre guarded by a valid raw centre reading, a
    // confirmation delay, a straight disengagement phase and a hard time cap.
    SysplorerEmbeddedCoder.Types.Auto backupState(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupTimer(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto closeConfirmTimer(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto escapeFailureTimer(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto escapeFailureTime(start=0.45) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupEscapeDirection(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupArmed(start=1) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto controlStep(start=0.05) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupConfirmTime(start=0.10) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupMinTime(start=0.80) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupMaxTime(start=1.20) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupPreStopTime(start=0.20) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupStraightTime(start=0.20) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupSteerMagnitude(start=0.38) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupSettleTime(start=0.15) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupRelease(start=12) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto backupSpeedCmd(start=-55) annotation(__MWORKS(internalShare=true));

    block State "Continuous control state"
      annotation(__MWORKS(BlockSystem(blockKind=BlockKind.state,SampleTime(auto=true),State),
        showDiagram=true,sourceModel=SysplorerEmbeddedCoder.StateMachine.State,
        independentInstance=true,hide=true),defaultComponentName="state",
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}),graphics={
          Rectangle(extent={{-100,100},{100,-100}},radius=11),
          Text(origin={0,80},extent={{-95,10},{95,-10}},textString="%name"),
          Text(origin={0,-10},extent={{-95,80},{95,-80}},textString="%algorithm",
            horizontalAlignment=TextAlignment.Left,verticalAlignment=TextAlignment.Top)}),
        Protection(access=Access.packageDuplicate));
    algorithm
      annotation(__MWORKS(BlockSystem(StateMachine(actionKind=ActionKind.entry or ActionKind.during))));

      // A persistent missing echo must never look like the widest passage.
      // The conditioner already holds the last valid sample for 0.15 s; after
      // that timeout use a finite conservative unknown value.  A failed fixed
      // front-centre channel remains fail-safe and stops forward motion.
      if fl >= 2 then flEff := fl; else flEff := unknownForward; end if;
      if fr >= 2 then frEff := fr; else frEff := unknownForward; end if;
      if sl >= 2 then slEff := sl; else slEff := unknownSide; end if;
      if sr >= 2 then srEff := sr; else srEff := unknownSide; end if;

      if flEff < scoreCap then flCap := flEff; else flCap := scoreCap; end if;
      if frEff < scoreCap then frCap := frEff; else frCap := scoreCap; end if;
      if slEff < scoreCap then slCap := slEff; else slCap := scoreCap; end if;
      if srEff < scoreCap then srCap := srEff; else srCap := scoreCap; end if;

      // Passage score is limited by its narrowest supporting measurement.
      // This prevents one long/specular front-diagonal echo from overruling a
      // genuinely narrow same-side body clearance.
      leftSideReach := 1.6*slCap;
      if leftSideReach > scoreCap then leftSideReach := scoreCap; end if;
      rightSideReach := 1.6*srCap;
      if rightSideReach > scoreCap then rightSideReach := scoreCap; end if;
      if flCap < leftSideReach then leftScore := flCap;
      else leftScore := leftSideReach;
      end if;
      if frCap < rightSideReach then rightScore := frCap + clockwiseBias;
      else rightScore := rightSideReach + clockwiseBias;
      end if;

      if flEff >= pathFrontMinimum and slEff >= pathSideMinimum then
        leftPathAllowed := 1;
      else
        leftPathAllowed := 0;
      end if;
      if frEff >= pathFrontMinimum and srEff >= pathSideMinimum then
        rightPathAllowed := 1;
      else
        rightPathAllowed := 0;
      end if;

      // Both 90-degree sensors may be close after a successful avoidance while
      // the car is already parallel to the boundary.  That is a valid narrow
      // corridor, not a forward slit.  Release the body-side veto only when all
      // three forward rays independently prove that straight motion is clear.
      if fc >= corridorCenterMinimum and 
         flEff >= corridorCornerMinimum and 
         frEff >= corridorCornerMinimum then
        corridorPassAllowed := 1;
      else
        corridorPassAllowed := 0;
      end if;

      // Steering and speed tiers must react to the closest forward-sector ray,
      // not only the centre ray.  The video showed an open centre ray passing
      // through a gap while a front corner was already at the obstacle.
      closestFront := fc;
      if flEff < closestFront then closestFront := flEff; end if;
      if frEff < closestFront then closestFront := frEff; end if;

      if (fc > 0 and fc <= frontWarn) or flEff <= frontDiagonalWarn or 
         frEff <= frontDiagonalWarn then
        avoidRequest := 1;
      else
        avoidRequest := 0;
      end if;

      // If avoidance is requested but neither Ackermann swept path is usable,
      // normal control would command a stationary stop.  Convert a genuinely
      // tight, validly observed stop into a bounded reverse reset.  The clear
      // parallel-corridor exception remains strictly higher priority.
      if avoidRequest > 0.5 and leftPathAllowed < 0.5 and 
         rightPathAllowed < 0.5 and corridorPassAllowed < 0.5 and 
         closestFront <= tightStopDistance and 
         fcRaw >= 2 and fcRaw <= 250 then
        tightStopRequest := 1;
      else
        tightStopRequest := 0;
      end if;

      // backupState: 0=normal, 1=stop/centre, 2=staged reverse,
      // 3=stationary settle.  The pre-stop interval lets the external steering
      // rate limiter reach centre before any blind rearward motion begins.
      // A missing/invalid centre channel can only stop the car; it can never
      // trigger blind reverse.  Re-arm only after all three forward rays clear.
      if fc > frontRelease and flEff > frontDiagonalRelease and 
         frEff > frontDiagonalRelease then
        backupArmed := 1;
        closeConfirmTimer := 0;
        escapeFailureTimer := 0;
      end if;

      // A single front ray may be the only ray that sees an obstacle corner.
      // First give maximum turn-away a real chance; only a continuously
      // extreme reading proves that this manoeuvre failed.  This delayed path
      // converts a tight-contact stall into one bounded reverse pulse without
      // making an ordinary 6--20 cm bend reverse merely for being a bend.
      if backupState < 0.5 and backupArmed > 0.5 and 
         ((fcRaw >= 2 and fcRaw <= frontEmergency) or 
          (flEff <= frontSectorEmergency and frEff > frontSectorEmergency) or 
          (frEff <= frontSectorEmergency and flEff > frontSectorEmergency)) then
        escapeFailureTimer := escapeFailureTimer + controlStep;
      else
        escapeFailureTimer := 0;
      end if;

      if backupState > 2.5 then
        backupTimer := backupTimer + controlStep;
        if backupTimer >= backupSettleTime then
          backupState := 0;
          backupTimer := 0;
          // Geometry changed while reversing: never reuse the old choice.
          directionLock := 0;
          desiredDirection := 0;
          candidateDirection := 0;
          candidateTimer := 0;
          backupEscapeDirection := 0;
        end if;
      elseif backupState > 1.5 then
        backupTimer := backupTimer + controlStep;
        if not (fcRaw >= 2 and fcRaw <= 250) or backupTimer >= backupMaxTime or 
           (backupTimer >= backupMinTime and fc >= backupRelease and 
            flEff >= frontCornerRelease and frEff >= frontCornerRelease) then
          backupState := 3;
          backupTimer := 0;
        end if;
      elseif backupState > 0.5 then
        backupTimer := backupTimer + controlStep;
        if not (fcRaw >= 2 and fcRaw <= 250) then
          backupState := 3;
          backupTimer := 0;
        elseif backupTimer >= backupPreStopTime then
          backupState := 2;
          backupTimer := 0;
        end if;
      else
        // Emergency stop and permission to reverse are deliberately separate.
        // A single extreme ray first receives a timed maximum-turn escape.  A
        // state which would otherwise remain stopped may enter the same bounded
        // reverse reset immediately after confirmation.
        if backupArmed > 0.5 and 
           (tightStopRequest > 0.5 or 
            escapeFailureTimer >= escapeFailureTime or 
            (flEff <= pocketDistance and frEff <= pocketDistance) or 
            (fc > 0 and fc <= frontStrong and 
             leftPathAllowed < 0.5 and rightPathAllowed < 0.5)) then
          closeConfirmTimer := closeConfirmTimer + controlStep;
        else
          closeConfirmTimer := 0;
        end if;

        if closeConfirmTimer >= backupConfirmTime then
          // Store the forward escape side before clearing the old lock.  During
          // reverse the front wheels steer oppositely, rotating the nose toward
          // this larger forward passage.  A near tie keeps the clockwise right
          // preference already encoded in rightScore.
          if leftPathAllowed > 0.5 and rightPathAllowed < 0.5 then
            backupEscapeDirection := 1;
          elseif rightPathAllowed > 0.5 and leftPathAllowed < 0.5 then
            backupEscapeDirection := -1;
          elseif leftScore > rightScore then
            backupEscapeDirection := 1;
          else
            backupEscapeDirection := -1;
          end if;
          backupState := 1;
          backupTimer := 0;
          closeConfirmTimer := 0;
          escapeFailureTimer := 0;
          backupArmed := 0;
          desiredDirection := 0;
          candidateDirection := 0;
          candidateTimer := 0;
        end if;
      end if;

      // A direction is confirmed for two control periods before locking.  A
      // locked turn may switch only for a hard path veto or a large, persistent
      // bottleneck advantage.  Release is based on centre plus the selected
      // forward ray, so a single wall echo cannot hold a full-lock U-turn.
      if backupState < 0.5 then
        if directionLock > 0.5 then
          if (fc > frontRelease and frEff > frontDiagonalRelease) then
            directionLock := 0;
            candidateDirection := 0;
            candidateTimer := 0;
          elseif rightPathAllowed > 0.5 and 
                 (leftPathAllowed < 0.5 or 
                  rightScore > leftScore + directionSwitchMargin) then
            directionLock := -1;
            candidateDirection := 0;
            candidateTimer := 0;
          elseif leftPathAllowed < 0.5 and rightPathAllowed < 0.5 then
            directionLock := 0;
          end if;
        elseif directionLock < -0.5 then
          if (fc > frontRelease and flEff > frontDiagonalRelease) then
            directionLock := 0;
            candidateDirection := 0;
            candidateTimer := 0;
          elseif leftPathAllowed > 0.5 and 
                 (rightPathAllowed < 0.5 or 
                  leftScore > rightScore + directionSwitchMargin) then
            directionLock := 1;
            candidateDirection := 0;
            candidateTimer := 0;
          elseif leftPathAllowed < 0.5 and rightPathAllowed < 0.5 then
            directionLock := 0;
          end if;
        else
          desiredDirection := 0;
          if avoidRequest > 0.5 then
            if leftPathAllowed > 0.5 and rightPathAllowed < 0.5 then
              desiredDirection := 1;
            elseif rightPathAllowed > 0.5 and leftPathAllowed < 0.5 then
              desiredDirection := -1;
            elseif leftPathAllowed > 0.5 and rightPathAllowed > 0.5 then
              if leftScore > rightScore + directionHysteresis then
                desiredDirection := 1;
              else
                // Right is only the near-tie fallback for the clockwise race.
                desiredDirection := -1;
              end if;
            end if;
          end if;

          if desiredDirection > 0.5 or desiredDirection < -0.5 then
            if (candidateDirection > 0.5 and desiredDirection > 0.5) or 
               (candidateDirection < -0.5 and desiredDirection < -0.5) then
              candidateTimer := candidateTimer + controlStep;
            else
              candidateDirection := desiredDirection;
              candidateTimer := controlStep;
            end if;
            if candidateTimer >= directionConfirmTime then
              directionLock := candidateDirection;
              candidateDirection := 0;
              candidateTimer := 0;
            end if;
          else
            candidateDirection := 0;
            candidateTimer := 0;
          end if;
        end if;
      end if;

      if backupState > 2.5 then
        speed := 0;
      elseif backupState > 1.5 then
        speed := backupSpeedCmd;
      elseif backupState > 0.5 then
        speed := 0;
      elseif fc <= frontEmergency or 
         (fcRaw >= 2 and fcRaw <= frontEmergency) then
        // Stop for two samples while the open-side direction locks, then use a
        // very low forward turn only when that selected swept path is valid.
        if (directionLock > 0.5 and leftPathAllowed > 0.5) or 
           (directionLock < -0.5 and rightPathAllowed > 0.5) then
          speed := turnEscapeSpeed;
        else
          speed := 0;
        end if;
      elseif flEff <= frontSectorEmergency and 
             frEff > frontSectorEmergency and rightPathAllowed > 0.5 then
        speed := turnEscapeSpeed;
      elseif frEff <= frontSectorEmergency and 
             flEff > frontSectorEmergency and leftPathAllowed > 0.5 then
        speed := turnEscapeSpeed;
      elseif flEff <= frontSectorEmergency or frEff <= frontSectorEmergency then
        speed := 0;
      elseif avoidRequest > 0.5 and leftPathAllowed < 0.5 and 
             rightPathAllowed < 0.5 and corridorPassAllowed < 0.5 then
        // Never drive deeper into a slit which neither swept path can accept.
        speed := 0;
      elseif corridorPassAllowed > 0.5 and leftPathAllowed < 0.5 and 
             rightPathAllowed < 0.5 then
        // Keep enough momentum to leave a parallel boundary/corridor.
        speed := 90;
      elseif directionLock > 0.5 or directionLock < -0.5 then
        if closestFront <= 8 then speed := turnEscapeSpeed;
        elseif closestFront <= 11 then speed := 70;
        elseif closestFront <= 16 then speed := 100;
        else speed := 130;
        end if;
      elseif avoidRequest > 0.5 then
        // Direction confirmation lasts only two samples; keep useful momentum.
        speed := 110;
      elseif flEff < 8 or frEff < 8 or slEff < sideEmergency or srEff < sideEmergency then
        speed := 90;
      elseif fc <= 32 or flEff < 26 or frEff < 26 then
        speed := 140;
      else
        speed := 160;
      end if;

      // A very close 90-degree wall is an immediate swept-body veto.  Reverse
      // begins straight to break contact, then applies moderate counter-steer;
      // full steering is deliberately reserved for the observed forward move.
      if backupState > 2.5 then
        steer := 0;
      elseif backupState > 1.5 then
        if backupTimer < backupStraightTime then
          steer := 0;
        elseif backupEscapeDirection > 0.5 then
          steer := -backupSteerMagnitude;
        elseif backupEscapeDirection < -0.5 then
          steer := backupSteerMagnitude;
        else
          steer := 0;
        end if;
      elseif backupState > 0.5 then
        steer := 0;
      elseif flEff <= frontSectorEmergency and 
             frEff > frontSectorEmergency and rightPathAllowed > 0.5 then
        steer := -0.58;
        directionLock := -1;
      elseif frEff <= frontSectorEmergency and 
             flEff > frontSectorEmergency and leftPathAllowed > 0.5 then
        steer := 0.58;
        directionLock := 1;
      elseif slEff < sideEmergency and not (srEff < sideEmergency) then
        steer := -0.58;
        directionLock := -1;
      elseif srEff < sideEmergency and not (slEff < sideEmergency) then
        steer := 0.58;
        directionLock := 1;
      elseif avoidRequest > 0.5 and leftPathAllowed < 0.5 and 
             rightPathAllowed < 0.5 and corridorPassAllowed < 0.5 then
        steer := 0;
      elseif directionLock > 0.5 or directionLock < -0.5 then
        if closestFront <= 12 then steeringMagnitude := 0.58;
        elseif closestFront <= 18 then steeringMagnitude := 0.56;
        else steeringMagnitude := 0.48;
        end if;
        steer := directionLock*steeringMagnitude;
      else
        // Continuous free-space steering.  It intentionally permits a small
        // smooth weave, but deadband and +/-0.30 normal cap prevent chatter.
        if leftScore - rightScore > normalDeadband or 
           rightScore - leftScore > normalDeadband then
          normalSteer := 0.020*(leftScore - rightScore);
        else
          normalSteer := 0;
        end if;
        if slEff < sideCorrection then
          normalSteer := normalSteer - 0.055*(sideCorrection - slEff);
        end if;
        if srEff < sideCorrection then
          normalSteer := normalSteer + 0.055*(sideCorrection - srEff);
        end if;
        if normalSteer > 0.40 then steer := 0.40;
        elseif normalSteer < -0.40 then steer := -0.40;
        else steer := normalSteer;
        end if;
      end if;

      gapS := 0;
      servo := 0;
    end State;

    State run annotation(Placement(transformation(origin={0,0},extent={{-90,-80},{90,80}})),
      __MWORKS(BlockSystem(StateMachine)));
  equation
    initialState(run,true,1) annotation(__MWORKS(BlockSystem(StateMachine(outerTransition=false))));
  end Chart;

  model ModelWorkspace
    annotation(__MWORKS(hide=true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;

equation
  connect(front_dist,absFC.u);
  connect(rear_dist,absFL.u);
  connect(fu_dist,absFR.u);
  connect(left_dist,absSL.u);
  connect(right_dist,absSR.u);
  connect(absFC.y,filterFC.raw);
  connect(absFL.y,filterFL.raw);
  connect(absFR.y,filterFR.raw);
  connect(absSL.y,filterSL.raw);
  connect(absSR.y,filterSR.raw);
  connect(filterFC.y,chart.fc);
  connect(absFC.y,chart.fcRaw);
  connect(filterFL.y,chart.fl);
  connect(filterFR.y,chart.fr);
  connect(filterSL.y,chart.sl);
  connect(filterSR.y,chart.sr);
  connect(chart.speed,speed);
  connect(chart.steer,steeringRateLimiter.target);
  connect(steeringRateLimiter.y,steeringLimit.u);
  connect(steeringLimit.y,steer);
  connect(chart.gapS,gap);
  connect(chart.servo,fu_sensor_cmd);
end ObsAvoidController_Team27_MWorks;