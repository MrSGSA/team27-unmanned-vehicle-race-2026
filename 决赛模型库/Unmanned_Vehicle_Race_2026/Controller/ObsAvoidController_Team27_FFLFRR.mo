model ObsAvoidController_Team27_FFLFRR
  "27号车四超声波避障控制器：JGB520代码生成版"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(version="26.3.0",modelType=Control,PortArrangement(Left(sensor1,sensor2,sensor3,sensor4,sensor5),Right(speed,steer)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.05,OutputInterval=0.05),SysblockVersion="1.0"),
    experiment(Algorithm=Euler,Interval=0.05,StartTime=0,StopTime=100));

  SysplorerEmbeddedCoder.Port.Inport sensor1 "正前，cm" 
    annotation(Placement(transformation(origin={-100,80},extent={{-6,-6},{6,6}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport sensor2 "保留，不使用" 
    annotation(Placement(transformation(origin={-100,40},extent={{-6,-6},{6,6}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport sensor3 "右前，cm" 
    annotation(Placement(transformation(origin={-100,0},extent={{-6,-6},{6,6}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport sensor4 "左前，cm" 
    annotation(Placement(transformation(origin={-100,-40},extent={{-6,-6},{6,6}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Inport sensor5 "正后，cm，仅监测" 
    annotation(Placement(transformation(origin={-100,-80},extent={{-6,-6},{6,6}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Outport speed "cm/s" 
    annotation(Placement(transformation(origin={100,30},extent={{-6,-6},{6,6}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));
  SysplorerEmbeddedCoder.Port.Outport steer "rad，正值左转" 
    annotation(Placement(transformation(origin={100,-30},extent={{-6,-6},{6,6}})),
      __MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1,SampleTime(group="D1")=0.05)));

  ControllerStep controllerStep 
    annotation(Placement(transformation(origin={0,0},extent={{-36,-28},{36,28}})),
      __MWORKS(BlockSystem(SampleTime(group="D1")=0.05)));

  block ControllerStep
    annotation(__MWORKS(
      PortArrangement(Left(front,unused,rightFront,leftFront,rear),Right(speed,steer)),
      BlockSystem(blockKind=BlockKind.atomic,bltBlockKind=BltBlockKind.ccaller,
        SampleTime(group="D1")=0.05),
      independentInstance=true,
      sourceModel=SysplorerEmbeddedCoder.Utilities.CCaller,
      ExternalFunctionBlock,hide=true));

    SysplorerEmbeddedCoder.Port.Inport front 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)),Placement(transformation(origin={-100,80},extent={{-6,-6},{6,6}})));
    SysplorerEmbeddedCoder.Port.Inport unused 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)),Placement(transformation(origin={-100,40},extent={{-6,-6},{6,6}})));
    SysplorerEmbeddedCoder.Port.Inport rightFront 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)),Placement(transformation(origin={-100,0},extent={{-6,-6},{6,6}})));
    SysplorerEmbeddedCoder.Port.Inport leftFront 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)),Placement(transformation(origin={-100,-40},extent={{-6,-6},{6,6}})));
    SysplorerEmbeddedCoder.Port.Inport rear 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)),Placement(transformation(origin={-100,-80},extent={{-6,-6},{6,6}})));
    SysplorerEmbeddedCoder.Port.Outport speed 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)),Placement(transformation(origin={100,30},extent={{-6,-6},{6,6}})));
    SysplorerEmbeddedCoder.Port.Outport steer 
      annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)),Placement(transformation(origin={100,-30},extent={{-6,-6},{6,6}})));

    function step
      input SysplorerEmbeddedCoder.Types.Auto front 
        annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)));
      input SysplorerEmbeddedCoder.Types.Auto unused 
        annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)));
      input SysplorerEmbeddedCoder.Types.Auto rightFront 
        annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)));
      input SysplorerEmbeddedCoder.Types.Auto leftFront 
        annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)));
      input SysplorerEmbeddedCoder.Types.Auto rear 
        annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)));
      output SysplorerEmbeddedCoder.Types.Auto speed 
        annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)));
      output SysplorerEmbeddedCoder.Types.Auto steer 
        annotation(__MWORKS(BlockSystem(Type(inherit=InheritType.none,ref="double"),Dimension=1)));
      external "C" Team27_ControllerStep(front,unused,rightFront,leftFront,rear,speed,steer) 
        annotation(Include = "#include <math.h>\n
static int team27_state = 0;\n
static int team27_direction = 1;\n
static int team27_danger_count = 0;\n
static int team27_hold_count = 0;\n
static int team27_clear_count = 0;\n
\n
static double team27_clip_distance(double d)\n
{\n
  d = fabs(d);\n
  if (!isfinite(d) || d <= 0.0) return 1.0;\n
  if (d > 300.0) return 300.0;\n
  return d;\n
}\n
\n
void Team27_ControllerStep(double frontRaw, double unusedRaw,\n
  double rightRaw, double leftRaw, double rearRaw,\n
  double* speedOut, double* steerOut)\n
{\n
  const double speedCruise = 30.0;\n
  const double speedCaution = 20.0;\n
  const double speedAvoid = 15.0;\n
  const double speedCrawl = 8.0;\n
  const double frontWarn = 100.0;\n
  const double frontEmergency = 40.0;\n
  const double frontStop = 25.0;\n
  const double frontClear = 130.0;\n
  const double diagonalWarn = 48.0;\n
  const double diagonalStop = 18.0;\n
  const double diagonalClear = 65.0;\n
  const double deadband = 6.0;\n
  const double diagonalGain = 0.0034;\n
  const double nearGain = 0.26;\n
  const double switchMargin = 28.0;\n
  const double avoidSteer = 0.28;\n
  const double emergencySteer = 0.42;\n
  const double maxSteer = 0.45;\n
  const int confirmSamples = 2;\n
  const int minAvoidSamples = 14;\n
  const int clearSamples = 5;\n
  double front = team27_clip_distance(frontRaw);\n
  double left = team27_clip_distance(leftRaw);\n
  double right = team27_clip_distance(rightRaw);\n
  double diagonalMin = left < right ? left : right;\n
  double error = left - right;\n
  double correction = fabs(error) <= deadband ? 0.0 :\n
    diagonalGain * (error - (error > 0.0 ? deadband : -deadband));\n
  double nearCorrection = 0.0;\n
  double steer;\n
  (void)unusedRaw;\n
  (void)rearRaw;\n
\n
  if (left < diagonalWarn)\n
    nearCorrection -= nearGain * (diagonalWarn-left)/diagonalWarn;\n
  if (right < diagonalWarn)\n
    nearCorrection += nearGain * (diagonalWarn-right)/diagonalWarn;\n
\n
  if (front <= frontStop ||\n
      (left <= diagonalStop && right <= diagonalStop)) {\n
    team27_state = 4;\n
    team27_clear_count = 0;\n
  } else if (front <= frontEmergency) {\n
    team27_direction = left >= right ? 1 : 2;\n
    team27_state = 3;\n
    team27_hold_count++;\n
    team27_clear_count = 0;\n
  } else if (team27_state == 4) {\n
    if (front > frontEmergency &&\n
        (left > diagonalStop || right > diagonalStop)) {\n
      team27_state = team27_direction;\n
      team27_danger_count = 0;\n
      team27_hold_count = 0;\n
    }\n
  } else if (team27_state == 1 || team27_state == 2 || team27_state == 3) {\n
    if (team27_state == 1 && right > left + switchMargin) {\n
      team27_state = team27_direction = 2;\n
      team27_hold_count = team27_clear_count = 0;\n
    } else if (team27_state == 2 && left > right + switchMargin) {\n
      team27_state = team27_direction = 1;\n
      team27_hold_count = team27_clear_count = 0;\n
    } else if (front >= frontClear && left >= diagonalClear &&\n
               right >= diagonalClear) {\n
      team27_clear_count++;\n
      if (team27_hold_count >= minAvoidSamples &&\n
          team27_clear_count >= clearSamples) {\n
        team27_state = 0;\n
        team27_hold_count = team27_clear_count = 0;\n
      } else {\n
        team27_state = team27_direction;\n
        team27_hold_count++;\n
      }\n
    } else {\n
      team27_state = team27_direction;\n
      team27_hold_count++;\n
      team27_clear_count = 0;\n
    }\n
  } else if (front <= frontWarn || left <= diagonalWarn ||\n
             right <= diagonalWarn) {\n
    team27_danger_count++;\n
    if (team27_danger_count >= confirmSamples) {\n
      if (left <= diagonalWarn && right > left) team27_direction = 2;\n
      else if (right <= diagonalWarn && left > right) team27_direction = 1;\n
      else team27_direction = left >= right ? 1 : 2;\n
      team27_state = team27_direction;\n
      team27_danger_count = team27_hold_count = team27_clear_count = 0;\n
    }\n
  } else {\n
    team27_state = 0;\n
    team27_danger_count = team27_hold_count = team27_clear_count = 0;\n
  }\n
\n
  if (team27_state == 4) steer = 0.0;\n
  else if (team27_state == 3)\n
    steer = (team27_direction == 1 ? emergencySteer : -emergencySteer) +\n
      0.20*correction + nearCorrection;\n
  else if (team27_state == 1)\n
    steer = avoidSteer + 0.25*correction + nearCorrection;\n
  else if (team27_state == 2)\n
    steer = -avoidSteer + 0.25*correction + nearCorrection;\n
  else steer = correction + nearCorrection;\n
\n
  if (steer > maxSteer) steer = maxSteer;\n
  if (steer < -maxSteer) steer = -maxSteer;\n
  *steerOut = steer;\n
  if (team27_state == 4) *speedOut = 0.0;\n
  else if (team27_state == 3) *speedOut = speedCrawl;\n
  else if (team27_state == 1 || team27_state == 2) *speedOut = speedAvoid;\n
  else if (front < frontClear || diagonalMin < diagonalClear ||\n
           fabs(steer) > 0.16) *speedOut = speedCaution;\n
  else *speedOut = speedCruise;\n
}\n");
    end step;

  equation
    (speed,steer) = step(front,unused,rightFront,leftFront,rear);
  end ControllerStep;

  model ModelWorkspace
    annotation(__MWORKS(hide=true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;

equation
  connect(sensor1,controllerStep.front);
  connect(sensor2,controllerStep.unused);
  connect(sensor3,controllerStep.rightFront);
  connect(sensor4,controllerStep.leftFront);
  connect(sensor5,controllerStep.rear);
  connect(controllerStep.speed,speed);
  connect(controllerStep.steer,steer);
end ObsAvoidController_Team27_FFLFRR;