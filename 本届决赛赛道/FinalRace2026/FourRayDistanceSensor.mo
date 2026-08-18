within FinalRace2026;
block FourRayDistanceSensor
  "正前、左前、右前、正后四个超声波的二维几何模型"

  import Modelica.Constants.pi;

  parameter Real[:,3] road = {{0,0,0},{1,0,0}}
    "道路中心线：x、y、建议速度";
  parameter Real width = 1.6 "道路宽度 / m";
  parameter Real[:,3] obs = {{1000,1000,0}} "障碍物：x、y、z";
  parameter Real obstacleRadius = 0.075 "障碍物等效半径 / m";
  parameter Boolean is_closed = true "道路是否闭合";
  parameter Real L = 0.11 "轴距，用作前后安装点间距 / m";
  parameter Real W = 0.165 "轮距，用作左右安装点间距 / m";
  parameter Real frontYaw = 20*pi/180 "左右前传感器向外偏转角 / rad";
  parameter Real beamHalfYaw = 10*pi/180
    "用五条射线近似超声波声锥的半角 / rad";
  parameter Real sensorPeriod = 0.05 "四路测距更新周期 / s";
  parameter Real maxRange = 3.0 "HC-SR04 仿真最大量程 / m";

  Modelica.Blocks.Interfaces.RealInput vehicle_position[2] "车体中心世界坐标";
  Modelica.Blocks.Interfaces.RealInput yaw "车体偏航角 / rad";
  Modelica.Blocks.Interfaces.RealOutput front_dist "正前距离 / m";
  Modelica.Blocks.Interfaces.RealOutput front_left_dist "左前距离 / m";
  Modelica.Blocks.Interfaces.RealOutput front_right_dist "右前距离 / m";
  Modelica.Blocks.Interfaces.RealOutput rear_dist "正后距离 / m";
  Modelica.Blocks.Interfaces.RealOutput front_obstacle_dist
    "诊断：正前声锥仅障碍距离 / m";
  Modelica.Blocks.Interfaces.RealOutput front_left_obstacle_dist
    "诊断：左前声锥仅障碍距离 / m";
  Modelica.Blocks.Interfaces.RealOutput front_right_obstacle_dist
    "诊断：右前声锥仅障碍距离 / m";
  Modelica.Blocks.Interfaces.RealOutput sampled_x "诊断：采样事件内的车体x";
  Modelica.Blocks.Interfaces.RealOutput sampled_y "诊断：采样事件内的车体y";
  Modelica.Blocks.Interfaces.RealOutput sampled_forward_x "诊断：采样事件内前向x分量";
  Modelica.Blocks.Interfaces.RealOutput first_obstacle_projection
    "诊断：第一个障碍在正前轴上的投影";

protected
  function rayDistance
    input Real origin[2];
    input Real direction[2];
    input Real[:,3] centerLine;
    input Real roadWidth;
    input Real[:,3] obstacles;
    input Real radius;
    input Boolean closedRoad;
    input Real rangeMax;
    output Real distance;
  protected
    Integer n;
    Integer previousIndex;
    Integer nextIndex;
    Integer segmentCount;
    Boolean duplicateEnd;
    Real leftBoundary[size(centerLine,1),2];
    Real rightBoundary[size(centerLine,1),2];
    Real tangent[2];
    Real tangentLength;
    Real segmentVector[2];
    Real relativeVector[2];
    Real denominator;
    Real rayParameter;
    Real segmentParameter;
    Real obstacleVector[2];
    Real projection;
    Real circleTerm;
    Real discriminant;
    Real circleParameter;
  algorithm
    n := size(centerLine, 1);
    distance := rangeMax;
    duplicateEnd := n > 2 and
      (centerLine[1,1] - centerLine[n,1])^2 +
      (centerLine[1,2] - centerLine[n,2])^2 < 1e-10;

    // 用中心线局部切向量生成左右两条道路边界折线。
    for i in 1:n loop
      previousIndex := if i > 1 then i - 1 else
        if closedRoad then (if duplicateEnd then n - 1 else n) else 1;
      nextIndex := if i < n then i + 1 else
        if closedRoad then (if duplicateEnd then 2 else 1) else n;
      tangent := {centerLine[nextIndex,1] - centerLine[previousIndex,1],
                  centerLine[nextIndex,2] - centerLine[previousIndex,2]};
      tangentLength := max(sqrt(tangent[1]^2 + tangent[2]^2), 1e-9);
      leftBoundary[i,1] := centerLine[i,1] - roadWidth/2*tangent[2]/tangentLength;
      leftBoundary[i,2] := centerLine[i,2] + roadWidth/2*tangent[1]/tangentLength;
      rightBoundary[i,1] := centerLine[i,1] + roadWidth/2*tangent[2]/tangentLength;
      rightBoundary[i,2] := centerLine[i,2] - roadWidth/2*tangent[1]/tangentLength;
    end for;

    segmentCount := if closedRoad and not duplicateEnd then n else n - 1;
    for i in 1:segmentCount loop
      nextIndex := if i < n then i + 1 else 1;

      segmentVector := {leftBoundary[nextIndex,1] - leftBoundary[i,1],
                        leftBoundary[nextIndex,2] - leftBoundary[i,2]};
      relativeVector := {leftBoundary[i,1] - origin[1],
                         leftBoundary[i,2] - origin[2]};
      denominator := direction[1]*segmentVector[2] - direction[2]*segmentVector[1];
      if abs(denominator) > 1e-9 then
        rayParameter := (relativeVector[1]*segmentVector[2] -
                         relativeVector[2]*segmentVector[1])/denominator;
        segmentParameter := (relativeVector[1]*direction[2] -
                             relativeVector[2]*direction[1])/denominator;
        if rayParameter >= 0 and segmentParameter >= 0 and segmentParameter <= 1 then
          distance := min(distance, rayParameter);
        end if;
      end if;

      segmentVector := {rightBoundary[nextIndex,1] - rightBoundary[i,1],
                        rightBoundary[nextIndex,2] - rightBoundary[i,2]};
      relativeVector := {rightBoundary[i,1] - origin[1],
                         rightBoundary[i,2] - origin[2]};
      denominator := direction[1]*segmentVector[2] - direction[2]*segmentVector[1];
      if abs(denominator) > 1e-9 then
        rayParameter := (relativeVector[1]*segmentVector[2] -
                         relativeVector[2]*segmentVector[1])/denominator;
        segmentParameter := (relativeVector[1]*direction[2] -
                             relativeVector[2]*direction[1])/denominator;
        if rayParameter >= 0 and segmentParameter >= 0 and segmentParameter <= 1 then
          distance := min(distance, rayParameter);
        end if;
      end if;
    end for;

    // 障碍物按规则给出的半径处理为圆，与射线求最近交点。
    for i in 1:size(obstacles,1) loop
      obstacleVector := {origin[1] - obstacles[i,1], origin[2] - obstacles[i,2]};
      projection := obstacleVector[1]*direction[1] + obstacleVector[2]*direction[2];
      circleTerm := obstacleVector[1]^2 + obstacleVector[2]^2 - radius^2;
      discriminant := projection^2 - circleTerm;
      if discriminant >= 0 then
        circleParameter := -projection - sqrt(discriminant);
        if circleParameter >= 0 then
          distance := min(distance, circleParameter);
        end if;
      end if;
    end for;
  end rayDistance;

  function coneOneObstacleDistance
    "连续扇形声锥与圆形障碍的保守相交距离"
    input Real origin[2];
    input Real direction[2] "传感器中心轴单位向量";
    input Real halfYaw;
    input Real obstacle[3];
    input Real radius;
    input Real rangeMax;
    output Real distance;
  protected
    Real relative[2];
    Real centerDistance;
    Real forwardProjection;
    Real lateralDistance;
  algorithm
    distance := rangeMax;
    relative := {obstacle[1] - origin[1], obstacle[2] - origin[2]};
    centerDistance := sqrt(relative[1]^2 + relative[2]^2);
    forwardProjection := relative[1]*direction[1] + relative[2]*direction[2];
    lateralDistance := abs(relative[1]*direction[2] -
      relative[2]*direction[1]);
    if centerDistance <= radius then
      distance := 0;
    elseif centerDistance - radius <= rangeMax and
           forwardProjection >= -radius and
           lateralDistance <= max(0.0, forwardProjection)*tan(halfYaw) + radius then
      distance := centerDistance - radius;
    end if;
  end coneOneObstacleDistance;

  Real forwardDirection[2];
  Real leftDirection[2];
  Real frontLeftDirection[2];
  Real frontRightDirection[2];
  Real frontOrigin[2];
  Real frontLeftOrigin[2];
  Real frontRightOrigin[2];
  Real rearOrigin[2];

equation
  forwardDirection = {cos(yaw), sin(yaw)};
  leftDirection = {-sin(yaw), cos(yaw)};
  frontLeftDirection = {cos(yaw + frontYaw), sin(yaw + frontYaw)};
  frontRightDirection = {cos(yaw - frontYaw), sin(yaw - frontYaw)};
  frontOrigin = vehicle_position + L/2*forwardDirection;
  frontLeftOrigin = vehicle_position + L/2*forwardDirection + W/2*leftDirection;
  frontRightOrigin = vehicle_position + L/2*forwardDirection - W/2*leftDirection;
  rearOrigin = vehicle_position - L/2*forwardDirection;

algorithm
  // HC-SR04 本身是离散测量设备。采样保持避免连续求解器在每个内部
  // 积分步重复执行道路全边界求交，也与后续树莓派轮询接口更接近。
  when {initial(), sample(sensorPeriod, sensorPeriod)} then
    sampled_x := vehicle_position[1];
    sampled_y := vehicle_position[2];
    sampled_forward_x := forwardDirection[1];
    first_obstacle_projection :=
      (obs[1,1] - frontOrigin[1])*forwardDirection[1] +
      (obs[1,2] - frontOrigin[2])*forwardDirection[2];
    front_obstacle_dist := maxRange;
    front_left_obstacle_dist := maxRange;
    front_right_obstacle_dist := maxRange;
    front_dist := min(
      rayDistance(frontOrigin, forwardDirection, road, width, obs,
        obstacleRadius, is_closed, maxRange),
      min(min(
        rayDistance(frontOrigin,
          {cos(yaw - beamHalfYaw), sin(yaw - beamHalfYaw)}, road, width,
          obs, obstacleRadius, is_closed, maxRange),
        rayDistance(frontOrigin,
          {cos(yaw - beamHalfYaw/2), sin(yaw - beamHalfYaw/2)}, road, width,
          obs, obstacleRadius, is_closed, maxRange)), min(
        rayDistance(frontOrigin,
          {cos(yaw + beamHalfYaw/2), sin(yaw + beamHalfYaw/2)}, road, width,
          obs, obstacleRadius, is_closed, maxRange),
        rayDistance(frontOrigin,
          {cos(yaw + beamHalfYaw), sin(yaw + beamHalfYaw)}, road, width,
          obs, obstacleRadius, is_closed, maxRange))));
    front_left_dist := min(
      rayDistance(frontLeftOrigin, frontLeftDirection, road, width, obs,
        obstacleRadius, is_closed, maxRange),
      min(min(
        rayDistance(frontLeftOrigin,
          {cos(yaw + frontYaw - beamHalfYaw), sin(yaw + frontYaw - beamHalfYaw)},
          road, width, obs, obstacleRadius, is_closed, maxRange),
        rayDistance(frontLeftOrigin,
          {cos(yaw + frontYaw - beamHalfYaw/2), sin(yaw + frontYaw - beamHalfYaw/2)},
          road, width, obs, obstacleRadius, is_closed, maxRange)), min(
        rayDistance(frontLeftOrigin,
          {cos(yaw + frontYaw + beamHalfYaw/2), sin(yaw + frontYaw + beamHalfYaw/2)},
          road, width, obs, obstacleRadius, is_closed, maxRange),
        rayDistance(frontLeftOrigin,
          {cos(yaw + frontYaw + beamHalfYaw), sin(yaw + frontYaw + beamHalfYaw)},
          road, width, obs, obstacleRadius, is_closed, maxRange))));
    front_right_dist := min(
      rayDistance(frontRightOrigin, frontRightDirection, road, width, obs,
        obstacleRadius, is_closed, maxRange),
      min(min(
        rayDistance(frontRightOrigin,
          {cos(yaw - frontYaw + beamHalfYaw), sin(yaw - frontYaw + beamHalfYaw)},
          road, width, obs, obstacleRadius, is_closed, maxRange),
        rayDistance(frontRightOrigin,
          {cos(yaw - frontYaw + beamHalfYaw/2), sin(yaw - frontYaw + beamHalfYaw/2)},
          road, width, obs, obstacleRadius, is_closed, maxRange)), min(
        rayDistance(frontRightOrigin,
          {cos(yaw - frontYaw - beamHalfYaw/2), sin(yaw - frontYaw - beamHalfYaw/2)},
          road, width, obs, obstacleRadius, is_closed, maxRange),
        rayDistance(frontRightOrigin,
          {cos(yaw - frontYaw - beamHalfYaw), sin(yaw - frontYaw - beamHalfYaw)},
          road, width, obs, obstacleRadius, is_closed, maxRange))));
    rear_dist := rayDistance(rearOrigin, -forwardDirection, road, width, obs,
      obstacleRadius, is_closed, maxRange);
    for i in 1:size(obs,1) loop
      front_obstacle_dist := min(front_obstacle_dist,
        coneOneObstacleDistance(frontOrigin, forwardDirection, beamHalfYaw, obs[i,:],
        obstacleRadius, maxRange));
      front_left_obstacle_dist := min(front_left_obstacle_dist,
        coneOneObstacleDistance(
        frontLeftOrigin, frontLeftDirection, beamHalfYaw, obs[i,:],
        obstacleRadius, maxRange));
      front_right_obstacle_dist := min(front_right_obstacle_dist,
        coneOneObstacleDistance(
        frontRightOrigin, frontRightDirection, beamHalfYaw, obs[i,:],
        obstacleRadius, maxRange));
      rear_dist := min(rear_dist, coneOneObstacleDistance(rearOrigin,
        -forwardDirection, beamHalfYaw, obs[i,:], obstacleRadius, maxRange));
    end for;
    front_dist := min(front_dist, front_obstacle_dist);
    front_left_dist := min(front_left_dist, front_left_obstacle_dist);
    front_right_dist := min(front_right_dist, front_right_obstacle_dist);
  end when;
end FourRayDistanceSensor;
