within FinalRace2026;
model SensorDiagnostic
  "四传感器固定几何诊断：障碍位于车头正前方0.5 m"
  FourRayDistanceSensor sensor(
    road = {{-5,0,1},{5,0,1}},
    width = 1.6,
    obs = {{0.5,0,0}},
    obstacleRadius = 0.075,
    is_closed = false,
    L = 0.11,
    W = 0.165,
    frontYaw = 20*Modelica.Constants.pi/180,
    beamHalfYaw = 10*Modelica.Constants.pi/180,
    sensorPeriod = 0.05,
    maxRange = 3.0);
  FourRayDistanceSensor obliqueSensor(
    road = {{12,20,1},{12,28,1}},
    width = 1.6,
    obs = {{11.98683451590753,24,0},{100,100,0},{101,100,0},
      {102,100,0},{103,100,0},{104,100,0},{105,100,0},{106,100,0}},
    obstacleRadius = 0.075,
    is_closed = false,
    L = 0.11,
    W = 0.165,
    frontYaw = 20*Modelica.Constants.pi/180,
    beamHalfYaw = 10*Modelica.Constants.pi/180,
    sensorPeriod = 0.05,
    maxRange = 3.0)
    "复现整车约76秒时的姿态和障碍位置";
  FourRayDistanceSensor movingSensor(
    road = {{12,18,1},{12,28,1}},
    width = 1.6,
    obs = {{12,24,0}},
    obstacleRadius = 0.075,
    is_closed = false,
    sensorPeriod = 0.05)
    "以0.4 m/s沿直线驶向障碍，检查离散采样的动态输入";
equation
  sensor.vehicle_position = {0,0};
  sensor.yaw = 0;
  obliqueSensor.vehicle_position = {12.10195596427861,23.567310155105154};
  obliqueSensor.yaw = 1.585303634748476;
  movingSensor.vehicle_position = {12,20 + 0.4*time};
  movingSensor.yaw = Modelica.Constants.pi/2;
end SensorDiagnostic;
