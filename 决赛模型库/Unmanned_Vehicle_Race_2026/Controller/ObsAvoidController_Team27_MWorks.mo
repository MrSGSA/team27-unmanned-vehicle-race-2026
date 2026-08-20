model ObsAvoidController_Team27_MWorks
  "Team27纯MWORKS五固定超声波阿克曼连续避障控制器V3"
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
    zeroCross=true,upLimit=0.55,lowLimit=-0.55);

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
    // 0.12 rad/50 ms reaches full steering in about 0.25 s without a step jump.
    SysplorerEmbeddedCoder.Discontinuities.Saturation stepLimit(
      zeroCross=true,upLimit=0.12,lowLimit=-0.12);
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
    SysplorerEmbeddedCoder.Types.Auto frontWarn(start=20) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontStrong(start=12) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontEmergency(start=5.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontRelease(start=25) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto frontSectorEmergency(start=6) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto sideEmergency(start=4.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto sideCorrection(start=8) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto scoreCap(start=40) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto directionHysteresis(start=2.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto normalDeadband(start=3) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto clockwiseBias(start=0.5) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto directionLock(start=0) annotation(__MWORKS(internalShare=true));
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
    SysplorerEmbeddedCoder.Types.Auto steeringMagnitude(start=0) annotation(__MWORKS(internalShare=true));
    SysplorerEmbeddedCoder.Types.Auto normalSteer(start=0) annotation(__MWORKS(internalShare=true));

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

      // Invalid peripheral channels are ignored rather than interpreted as a
      // zero-distance wall.  A failed front-centre channel remains fail-safe.
      if fl >= 2 then flEff := fl; else flEff := scoreCap; end if;
      if fr >= 2 then frEff := fr; else frEff := scoreCap; end if;
      if sl >= 2 then slEff := sl; else slEff := scoreCap; end if;
      if sr >= 2 then srEff := sr; else srEff := scoreCap; end if;

      if flEff < scoreCap then flCap := flEff; else flCap := scoreCap; end if;
      if frEff < scoreCap then frCap := frEff; else frCap := scoreCap; end if;
      if slEff < scoreCap then slCap := slEff; else slCap := scoreCap; end if;
      if srEff < scoreCap then srCap := srEff; else srCap := scoreCap; end if;

      // Forward diagonal space dominates; 90-degree side clearance is a veto
      // and a small score term, not a wall-following target.
      leftScore := 0.82*flCap + 0.18*slCap;
      rightScore := 0.82*frCap + 0.18*srCap + clockwiseBias;

      // Direction is held only while the fixed centre sensor still sees the
      // obstacle.  There is no time-based turn and therefore no forced U-turn.
      if fc > frontRelease then
        directionLock := 0;
      elseif fc > 0 and fc <= frontWarn then
        if directionLock > 0.5 then
          if (flEff < frontSectorEmergency or slEff < sideEmergency) and 
             rightScore > leftScore + directionHysteresis then
            directionLock := -1;
          end if;
        elseif directionLock < -0.5 then
          if (frEff < frontSectorEmergency or srEff < sideEmergency) and 
             leftScore > rightScore + directionHysteresis then
            directionLock := 1;
          end if;
        elseif leftScore > rightScore + directionHysteresis and 
               flEff > frontSectorEmergency and slEff > sideEmergency then
          directionLock := 1;
        elseif rightScore > leftScore + directionHysteresis and 
               frEff > frontSectorEmergency and srEff > sideEmergency then
          directionLock := -1;
        elseif flEff > frontSectorEmergency and slEff > sideEmergency and 
               not (frEff > frontSectorEmergency and srEff > sideEmergency) then
          directionLock := 1;
        else
          // Clockwise race direction is only the final near-tie fallback.
          directionLock := -1;
        end if;
      end if;

      if fc <= frontEmergency or 
         (fcRaw >= 2 and fcRaw <= frontEmergency) or 
         (fc < 7 and flEff < frontSectorEmergency and frEff < frontSectorEmergency) then
        speed := 0;
      elseif directionLock > 0.5 or directionLock < -0.5 then
        if fc <= 8 then speed := 55;
        elseif fc <= frontStrong then speed := 65;
        else speed := 85;
        end if;
      elseif flEff < 8 or frEff < 8 or slEff < sideEmergency or srEff < sideEmergency then
        speed := 70;
      elseif fc <= 30 or flEff < 15 or frEff < 15 then
        speed := 110;
      else
        speed := 160;
      end if;

      // A very close 90-degree wall is an immediate swept-body veto.
      if slEff < sideEmergency and not (srEff < sideEmergency) then
        steer := -0.55;
        directionLock := -1;
      elseif srEff < sideEmergency and not (slEff < sideEmergency) then
        steer := 0.55;
        directionLock := 1;
      elseif directionLock > 0.5 or directionLock < -0.5 then
        if fc <= 8 then steeringMagnitude := 0.55;
        elseif fc <= frontStrong then steeringMagnitude := 0.48;
        elseif fc <= 16 then steeringMagnitude := 0.40;
        else steeringMagnitude := 0.30;
        end if;
        steer := directionLock*steeringMagnitude;
      else
        // Continuous free-space steering.  It intentionally permits a small
        // smooth weave, but deadband and +/-0.24 normal cap prevent chatter.
        if flCap - frCap > normalDeadband or frCap - flCap > normalDeadband then
          normalSteer := 0.012*(flCap - frCap);
        else
          normalSteer := 0;
        end if;
        if slEff < sideCorrection then
          normalSteer := normalSteer - 0.045*(sideCorrection - slEff);
        end if;
        if srEff < sideCorrection then
          normalSteer := normalSteer + 0.045*(sideCorrection - srEff);
        end if;
        if normalSteer > 0.24 then steer := 0.24;
        elseif normalSteer < -0.24 then steer := -0.24;
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