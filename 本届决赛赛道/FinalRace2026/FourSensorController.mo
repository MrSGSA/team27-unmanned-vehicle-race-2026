within FinalRace2026;
block FourSensorController
  "正前、左前、右前、正后四超声波纯前进避障控制器"

  parameter Real samplePeriod = 0.05 "控制器采样周期 / s";
  parameter Real speedCruise = 0.55 "空旷直道速度 / (m/s)";
  parameter Real speedCaution = 0.32 "接近障碍或弯道时速度 / (m/s)";
  parameter Real speedAvoid = 0.20 "主动绕障速度 / (m/s)";
  parameter Real speedCrawl = 0.10 "极近距离时仍可转向的爬行速度 / (m/s)";
  parameter Real frontWarn = 1.05 "正前开始选边绕行距离 / m";
  parameter Real frontEmergency = 0.28 "正前进入极低速强转距离 / m";
  parameter Real frontStop = 0.10 "正前安全停车距离 / m";
  parameter Real frontClear = 1.35 "正前退出主动绕障净空 / m";
  parameter Real diagonalWarn = 0.48 "斜前传感器靠近边界或障碍的阈值 / m";
  parameter Real diagonalStop = 0.14 "两侧斜前同时受限时的停车阈值 / m";
  parameter Real diagonalClear = 0.62 "退出绕障所需左右斜前净空 / m";
  parameter Real diagonalDeadband = 0.06 "左右斜前距离差死区 / m";
  parameter Real diagonalGain = 0.34 "左右斜前差动转向增益 / (rad/m)";
  parameter Real nearGain = 0.26 "斜前过近附加避让增益 / rad";
  parameter Real switchMargin = 0.28
    "原绕行侧净空比另一侧少该值时允许换边 / m";
  parameter Real avoidSteer = 0.30 "主动绕障基础转角 / rad";
  parameter Real emergencySteer = 0.48 "极近距离强制转角 / rad";
  parameter Real maxSteer = 0.52 "转向输出限幅 / rad";
  parameter Integer confirmSamples = 2 "危险连续确认采样数";
  parameter Integer minAvoidSamples = 14 "绕障方向最短保持采样数";
  parameter Integer clearSamples = 5 "退出绕障所需连续安全采样数";

  Modelica.Blocks.Interfaces.RealInput front_dist "正前距离 / m";
  Modelica.Blocks.Interfaces.RealInput front_left_dist "左前距离 / m";
  Modelica.Blocks.Interfaces.RealInput front_right_dist "右前距离 / m";
  Modelica.Blocks.Interfaces.RealInput rear_dist "正后距离 / m（仅监测）";
  Modelica.Blocks.Interfaces.RealOutput speed "目标车速 / (m/s)";
  Modelica.Blocks.Interfaces.RealOutput steer "相对当前航向的目标修正 / rad";
  Modelica.Blocks.Interfaces.IntegerOutput mode
    "0巡航，1向左绕行，2向右绕行，3紧急爬行，4停车";

protected
  Real frontCenter;
  Real frontLeft;
  Real frontRight;
  Real rearCenter;
  Real diagonalMin;
  Real diagonalError;
  Real diagonalCorrection;
  Real nearCorrection;
  Real steerRaw;
  discrete Integer state(start = 0, fixed = true);
  discrete Integer avoidDirection(start = 1, fixed = true) "1左，2右";
  discrete Integer dangerCount(start = 0, fixed = true);
  discrete Integer holdCount(start = 0, fixed = true);
  discrete Integer clearCount(start = 0, fixed = true);

equation
  // 对几何仿真和实车接口统一做有效范围保护。
  frontCenter = min(3.0, max(abs(front_dist), 0.01));
  frontLeft = min(3.0, max(abs(front_left_dist), 0.01));
  frontRight = min(3.0, max(abs(front_right_dist), 0.01));
  rearCenter = min(3.0, max(abs(rear_dist), 0.01));
  diagonalMin = min(frontLeft, frontRight);

  // 左前空间大于右前时误差为正，车辆应向左修正；反之向右。
  diagonalError = frontLeft - frontRight;
  diagonalCorrection = if abs(diagonalError) <= diagonalDeadband then 0 else
    diagonalGain*(diagonalError - sign(diagonalError)*diagonalDeadband);
  nearCorrection =
    (if frontLeft < diagonalWarn then
       -nearGain*(diagonalWarn - frontLeft)/diagonalWarn else 0) +
    (if frontRight < diagonalWarn then
       nearGain*(diagonalWarn - frontRight)/diagonalWarn else 0);

  steerRaw =
    if state == 4 then 0 else
    if state == 3 then
      (if avoidDirection == 1 then emergencySteer else -emergencySteer) +
      0.20*diagonalCorrection + nearCorrection else
    if state == 1 then avoidSteer + 0.25*diagonalCorrection + nearCorrection else
    if state == 2 then -avoidSteer + 0.25*diagonalCorrection + nearCorrection else
      diagonalCorrection + nearCorrection;
  steer = max(-maxSteer, min(maxSteer, steerRaw));

  speed =
    if state == 4 then 0 else
    if state == 3 then speedCrawl else
    if state == 1 or state == 2 then speedAvoid else
    if frontCenter < frontClear or diagonalMin < diagonalClear or
       abs(steer) > 0.16 then speedCaution else speedCruise;
  mode = state;

algorithm
  when sample(samplePeriod, samplePeriod) then
    // 正前传感器拥有最高停车优先级；后传感器不触发倒车动作。
    if frontCenter <= frontStop or
       (frontLeft <= diagonalStop and frontRight <= diagonalStop) then
      state := 4;
      avoidDirection := pre(avoidDirection);
      dangerCount := pre(dangerCount);
      holdCount := pre(holdCount);
      clearCount := 0;
    elseif frontCenter <= frontEmergency then
      state := 3;
      avoidDirection := if frontLeft >= frontRight then 1 else 2;
      dangerCount := pre(dangerCount);
      holdCount := pre(holdCount) + 1;
      clearCount := 0;
    elseif pre(state) == 4 then
      if frontCenter > frontEmergency and
         (frontLeft > diagonalStop or frontRight > diagonalStop) then
        state := pre(avoidDirection);
        avoidDirection := pre(avoidDirection);
        dangerCount := 0;
        holdCount := 0;
        clearCount := 0;
      else
        state := 4;
        avoidDirection := pre(avoidDirection);
        dangerCount := pre(dangerCount);
        holdCount := pre(holdCount);
        clearCount := 0;
      end if;
    elseif pre(state) == 1 or pre(state) == 2 or pre(state) == 3 then
      if pre(state) == 1 and frontRight > frontLeft + switchMargin then
        state := 2;
        avoidDirection := 2;
        dangerCount := 0;
        holdCount := 0;
        clearCount := 0;
      elseif pre(state) == 2 and frontLeft > frontRight + switchMargin then
        state := 1;
        avoidDirection := 1;
        dangerCount := 0;
        holdCount := 0;
        clearCount := 0;
      elseif frontCenter >= frontClear and frontLeft >= diagonalClear and
             frontRight >= diagonalClear then
        if pre(holdCount) >= minAvoidSamples and
           pre(clearCount) + 1 >= clearSamples then
          state := 0;
          avoidDirection := pre(avoidDirection);
          dangerCount := 0;
          holdCount := 0;
          clearCount := 0;
        else
          state := pre(avoidDirection);
          avoidDirection := pre(avoidDirection);
          dangerCount := 0;
          holdCount := pre(holdCount) + 1;
          clearCount := pre(clearCount) + 1;
        end if;
      else
        state := pre(avoidDirection);
        avoidDirection := pre(avoidDirection);
        dangerCount := 0;
        holdCount := pre(holdCount) + 1;
        clearCount := 0;
      end if;
    elseif frontCenter <= frontWarn or frontLeft <= diagonalWarn or
           frontRight <= diagonalWarn then
      if pre(dangerCount) + 1 >= confirmSamples then
        avoidDirection := if frontLeft <= diagonalWarn and
          frontRight > frontLeft then 2 elseif frontRight <= diagonalWarn and
          frontLeft > frontRight then 1 elseif frontLeft >= frontRight then 1 else 2;
        state := avoidDirection;
        dangerCount := 0;
        holdCount := 0;
        clearCount := 0;
      else
        state := 0;
        avoidDirection := pre(avoidDirection);
        dangerCount := pre(dangerCount) + 1;
        holdCount := 0;
        clearCount := 0;
      end if;
    else
      state := 0;
      avoidDirection := pre(avoidDirection);
      dangerCount := 0;
      holdCount := 0;
      clearCount := 0;
    end if;
  end when;

  annotation(Documentation(info = "<html>
<p>控制器使用正前、左前、右前和正后四路距离，不依赖理想位置或地图。</p>
<p>正前负责障碍确认和停车，左右斜前负责选边、绕障及赛道居中；正后仅监测，不产生倒车动作。</p>
</html>"));
end FourSensorController;
