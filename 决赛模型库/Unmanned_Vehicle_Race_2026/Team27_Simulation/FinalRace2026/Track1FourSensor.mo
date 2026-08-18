within FinalRace2026;
model Track1FourSensor "2026决赛赛道：随机障碍四传感器控制基线"
  import Vehicle = UGV.Vehicle;
  import Control = UGV.Control;
  import Road = UGV.Road;
  import CountPoint = UGV.CountPoint;
  import pi = Modelica.Constants.pi;
  annotation(__MWORKS(version="26.3.0",ContinueSimConfig(SaveContinueFile="false",SaveBeforeStop="false",NumberBeforeStop=1,FixedContinueInterval="false",ContinueIntervalLength=25,ContinueTimeVector),AnimationCamParam(CamUp = {-5.4512e-14, 1, -7.63142e-13}, CamCenter = {1.72393, -0.164805, -0.06175}, CamEye = {1.72393, -0.164805, 0.04075}, CamScale = {6.6601})), Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
grid={2,2}),graphics = {Rectangle(origin={26,-26},
fillColor={230,230,230},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-218,174},{218,-174}}), Rectangle(origin={196,-3},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-44,89},{44,-89}}), Rectangle(origin={71,-3},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{69,89},{-69,-89}}), Rectangle(origin={-99,-3},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{89,89},{-89,-89}}), Line(origin={26,98},
points={{-218,0},{218,0}},
thickness=1), Text(origin={31,121},
lineColor={0,0,127},
extent={{-113,15},{113,-15}},
textString="无人系统大赛模型(初赛)",
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Text(origin={-28,-84},
lineColor={0,0,127},
extent={{-19,8},{19,-8}},
textString="控制",
fontSize=28,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Text(origin={121.5,-84},
lineColor={0,0,127},
extent={{-13.5,8},{13.5,-8}},
textString="车辆",
fontSize=28,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Text(origin={211,-84},
lineColor={0,0,127},
extent={{-27,10},{27,-10}},
textString="环境与计分",
fontSize=28,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Line(origin={26,-104},
points={{-218,0},{218,0}},
thickness=1), Line(origin={26,-130},
points={{-218,0},{218,0}},
thickness=1), Text(origin={27,-118},
lineColor={0,0,127},
extent={{-87,8},{87,-8}},
textString="车辆状态与得分情况",
fontSize=36,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Rectangle(origin={-156.5,-165},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-30.5,23},{30.5,-23}}), Rectangle(origin={-85.5,-165},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-30.5,23},{30.5,-23}}), Rectangle(origin={-13.5,-165},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-30.5,23},{30.5,-23}}), Rectangle(origin={60.5,-165},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-30.5,23},{30.5,-23}}), Rectangle(origin={136.5,-165},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-30.5,23},{30.5,-23}}), Text(origin={-157,-154},
lineColor={0,0,127},
extent={{-27,8},{27,-8}},
textString="小车速度(m/s)",
fontSize=18,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Text(origin={-85,-154},
lineColor={0,0,127},
extent={{-25,6},{25,-6}},
textString="小车转向(deg)",
fontSize=18,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Text(origin={-14,-154},
lineColor={0,0,127},
extent={{-27,6},{27,-6}},
textString="道路碰撞次数",
fontSize=24,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Text(origin={61,-154},
lineColor={0,0,127},
extent={{-27,6},{27,-6}},
textString="障碍碰撞次数",
fontSize=24,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,127}), Rectangle(origin={209.5,-165},
fillColor={255,255,255},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-30.5,23},{30.5,-23}}), Text(origin={138,-154},
lineColor={255,0,0},
extent={{-19,6},{19,-6}},
textString="避障得分",
fontSize=24,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={255,0,0}), Text(origin={-157,-174},
lineColor={0,0,0},
extent={{-25,8},{25,-8}},
textString="%v",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-86,-174},
lineColor={0,0,0},
extent={{-25,8},{25,-8}},
textString="%yaw",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={-13,-174},
lineColor={0,0,0},
extent={{-28,8},{28,-8}},
textString="%cR",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={61,-174},
lineColor={0,0,0},
extent={{-28,8},{28,-8}},
textString="%cO",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={138,-174},
lineColor={0,0,0},
extent={{-25,8},{25,-8}},
textString="%P",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Rectangle(origin={-142,-41},
lineColor={255,0,0},
fillColor={255,255,255},
pattern=LinePattern.DashDot,
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-42,39},{42,-39}}), Text(origin={32,-212},
lineColor={0,0,0},
extent={{-166,6},{166,-6}},
textString="©苏州同元软控技术股份有限公司版权所有，仅用于无人系统大赛，未经许可不得复制、传播或以其他方式使用",
fontName="微软雅黑",
textStyle={TextStyle.None},
textColor={0,0,0}), Text(origin={-141,-10},
lineColor={255,0,0},
extent={{-40,3},{40,-3}},
textString="避障算法（选手建模）",
fontSize=22,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={255,0,0}), Rectangle(origin={-303,-17},
fillColor={230,230,230},
fillPattern=FillPattern.Solid,
lineThickness=1,
extent={{-93,113},{93,-113}}), Text(origin={-300,-17},
lineColor={0,0,128},
extent={{-87,103},{87,-103}},
textString="车辆参数：
轴距：0.11m
轮距：0.165m
传感器位于前后左右四个位置

注意事项：
1. 选手只需要对红框中避障算法模块
使用Sysblock进行建模，其余模型
无需改动；
2. 仿真前点击仿真设置-仿真调速-勾选
“启用调速以减慢仿真”，即可在仿真
时查看图形界面车辆状态与得分情况的
动态显示；
3. 仿真前点击仿真设置-模型翻译-勾选
“参数估值以便优化模型”；
4. 小车每碰撞一次扣0.4分，综合考虑
小车跑完一圈用时完成总分评判，具体
细则请参看赛题说明。",
fontSize=26,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={0,0,128},
horizontalAlignment=TextAlignment.Left), Text(origin={211,-174},
lineColor={0,0,0},
extent={{-25,-8},{25,8}},
textString="%T",
textStyle={TextStyle.None},
textColor={0,0,0},
horizontalAlignment=LinePattern.None), Text(origin={211,-154},
lineColor={255,0,0},
extent={{-25,6},{25,-6}},
textString="行驶时间(s)",
fontSize=24,
fontName="微软雅黑",
textStyle={TextStyle.Bold},
textColor={255,0,0})}), experiment(Algorithm=Dassl,InlineIntegrator=false,InlineStepSize=false,Interval=0.05,StartTime=0,StopTime=240,Tolerance=0.0001),Protection(access=Access.packageDuplicate));
  parameter Integer obstacleSeed = 27
    "障碍物随机种子；更改后重新翻译模型即可生成新场景";
  parameter Integer obstacleCount = 8
    "障碍物数量，当前生成器支持 1..16";
  parameter Real roadWidth = 1.60
    "基准赛道宽度；按赛会给出的 1..2 m 范围设置";
  parameter Real obstacleSize = 0.15 "障碍物直径 / m";
  final parameter Real obstaclePoint[obstacleCount,3] =
    ScenarioGenerator.generateObstacles(obstacleSeed, obstacleCount)
    "本次仿真的可复现随机障碍物坐标";

  Vehicle.VehicleBody.Body4DOF4S_TD body3DOF1_1(v_start = 0.45)
    "四自由度无人车多体模型，x，y，z及绕z轴偏转" annotation(Placement(transformation(origin = {67, -44},
    extent = {{-27, -27}, {27, 27}})));
  //   inner TADynamics.Roads.RoadModel.flatRoad road(L0=1000,B0=10,x_start=-10) if false 
  //     annotation (Placement(transformation(origin={130,-58}, 
  // extent={{-10,-10},{10,10}})));
  Control.Ackermann_control.PID_Ackermann pID_Ackermann(L = body3DOF1_1.wheelbase, W = body3DOF1_1.track_front, r = 0.03, Kp_v = 100, Kp_psi = 40, Kd_v = 0.5, Ki_psi = 0.15, Kd_psi = 0.1)
    "基于阿克曼构型的PID模型，用于控制小车期望速度与期望转角与实际速度与转角趋近" annotation(Placement(transformation(origin = {-51, -44},
    extent = {{-27, -27}, {27, 27}})));
  Control.PathPlanning.PathPlanner pathPlanner(path = road.roadMap, lookahead_gain = 0.1, wheelbase = body3DOF1_1.wheelbase, lookahead_base = 2)
    "路径规划模型，用于控制小车循迹运动" annotation(Placement(transformation(origin = {-141, 52.000009},
    extent = {{-27, -27}, {27, 27}})));
  inner Modelica.Mechanics.MultiBody.World world(n = {0, 0, -1}, animateWorld = false, animateGravity = false, animateGround = false, enableAnimation = true)
    "世界模型" annotation(Placement(transformation(origin={198,-56},
extent={{-15,-15},{15,15}})));
  Vehicle.Sensors.distanceSensor1 distanceSensor1(road = road.roadMap, width = road.roadWidth, L = body3DOF1_1.wheelbase, W = body3DOF1_1.track_front, obs = road.obstaclePoint, is_closed = true)
    "传感器模型，用于模拟无人车到各向的距离" annotation(Placement(transformation(origin = {67, 52},
    extent = {{27, -27}, {-27, 27}})));
  inner Road.TabularRoadObstacle road(
    roadMap = {{0,0,0.8},{1.5,0,0.9},{3,0,0.9},{4.1747,0.077,0.9},{5.3294,0.3067,0.9},{6.4442,0.6851,0.9},{7.5,1.2058,0.9},{8.4789,1.8598,0.9},{9.364,2.636,0.9},{10.1402,3.5211,0.9},{10.7942,4.5,0.9},{11.3149,5.5558,0.9},{11.6933,6.6706,0.9},{11.923,7.8253,0.9},{12,9,0.9},{12,12,1.5},{12,15,1.5},{12,18,1.5},{12,21,1.5},{12,24,1.5},{12,27,1.5},{12,30,1.5},{12,33,1.5},{12,36,1.5},{12,39,1.5},{12,42,1.5},{12,45,1.5},{11.8633,46.5628,0.9},{11.4572,48.0782,0.9},{10.7942,49.5,0.9},{9.8944,50.7851,0.9},{8.7851,51.8944,0.9},{7.5,52.7942,0.9},{6.0782,53.4572,0.9},{4.5628,53.8633,0.9},{3,54,0.9},{1.4372,53.8633,0.9},{-0.0782,53.4572,0.9},{-1.5,52.7942,0.9},{-2.7851,51.8944,0.9},{-3.8944,50.7851,0.9},{-4.7942,49.5,0.9},{-5.4572,48.0782,0.9},{-5.8633,46.5628,0.9},{-6,45,0.9},{-6,42,1.3},{-6,39,1.3},{-6,36,1.3},{-6,33,1.3},{-6,30,1.3},{-6,27,1.3},{-6,24,1.3},{-6.1367,22.4372,0.85},{-6.5428,20.9218,0.85},{-7.2058,19.5,0.85},{-8.1056,18.2149,0.85},{-9.2149,17.1056,0.85},{-10.5,16.2058,0.85},{-11.9218,15.5428,0.85},{-13.4372,15.1367,0.85},{-15,15,0.85},{-16.5628,15.1367,0.85},{-18.0782,15.5428,0.85},{-19.5,16.2058,0.85},{-20.7851,17.1056,0.85},{-21.8944,18.2149,0.85},{-22.7942,19.5,0.85},{-23.4572,20.9218,0.85},{-23.8633,22.4372,0.85},{-24,24,0.85},{-24,27,1.2},{-24,30,0.6},{-24,30.55,0.6},{-24,31.45,0.6},{-24,33,0.6},{-24,36,1.2},{-24,39,1.2},{-24,42,1.2},{-24,45,1.2},{-24.1367,46.5628,0.9},{-24.5428,48.0782,0.9},{-25.2058,49.5,0.9},{-26.1056,50.7851,0.9},{-27.2149,51.8944,0.9},{-28.5,52.7942,0.9},{-29.9218,53.4572,0.9},{-31.4372,53.8633,0.9},{-33,54,0.9},{-34.5628,53.8633,0.9},{-36.0782,53.4572,0.9},{-37.5,52.7942,0.9},{-38.7851,51.8944,0.9},{-39.8944,50.7851,0.9},{-40.7942,49.5,0.9},{-41.4572,48.0782,0.9},{-41.8633,46.5628,0.9},{-42,45,0.9},{-42,42,1.5},{-42,39,1.5},{-42,36,1.5},{-42,33,1.5},{-42,30,1.5},{-42,27,1.5},{-42,24,1.5},{-42,21,1.5},{-42,18,1.5},{-42,15,1.5},{-42,12,1.5},{-42,9,1.5},{-41.923,7.8253,0.9},{-41.6933,6.6706,0.9},{-41.3149,5.5558,0.9},{-40.7942,4.5,0.9},{-40.1402,3.5211,0.9},{-39.364,2.636,0.9},{-38.4789,1.8598,0.9},{-37.5,1.2058,0.9},{-36.4442,0.6851,0.9},{-35.3294,0.3067,0.9},{-34.1747,0.077,0.9},{-33,0,0.9},{-31.5,0,1.0},{-30,0,0.75},{-29.5985,-0.0137,0.75},{-29.1955,-0.0412,0.75},{-28.7933,-0.0618,0.75},{-28.394,-0.0549,0.75},{-28,0,0.75},{-27.6192,0.1153,0.75},{-27.2538,0.2763,0.75},{-26.8972,0.4636,0.75},{-26.5429,0.6574,0.75},{-26.1841,0.8381,0.75},{-24.6736,1.5352,0.75},{-23.1632,2.2324,0.75},{-21.6527,2.9295,0.75},{-20.1423,3.6266,0.75},{-18.6318,4.3238,0.75},{-17.9173,4.7127,0.75},{-17.2144,5.1552,0.75},{-16.5058,5.5709,0.75},{-15.7735,5.8793,0.75},{-15,6,0.75},{-14.2265,5.8793,0.75},{-13.4942,5.5709,0.75},{-12.7856,5.1552,0.75},{-12.0827,4.7127,0.75},{-11.3682,4.3238,0.75},{-9.7669,3.5847,0.75},{-8.1657,2.8457,0.75},{-6.5644,2.1067,0.75},{-4.9632,1.3676,0.75},{-3.3619,0.6286,0.75},{-3.0929,0.4931,0.75},{-2.8271,0.3477,0.75},{-2.5596,0.2073,0.75},{-2.2856,0.0864,0.75},{-2,0,0.75},{-1.7636,-0.033,0.75},{-1.524,-0.0371,0.75},{-1.2827,-0.0247,0.75},{-1.0409,-0.0082,0.75},{-0.8,0,0.75},{0,0,0.8}},
    obstaclePoint = obstaclePoint,
    roadWidth = roadWidth,
    surface(r_0 = {0,0,0.252}),
    obstacleHeight = 0.15,
    obstacleSize = obstacleSize)
    "2026决赛官方S形闭环道路（模型坐标顺时针旋转90度）：中心线R9、内缘R6、外缘R12；坡道中心约为{-24,31}" annotation(Placement(transformation(origin={198,64},
    extent={{-15,-15},{15,15}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape rampVisual(
    shapeType = "box",
    r_shape = {-24,31,-0.1105},
    lengthDirection = {0,cos(16.5*pi/180),sin(16.5*pi/180)},
    widthDirection = {1,0,0},
    length = 0.9,
    width = 0.3,
    height = 0.03,
    color = {25,25,25})
    "30x90cm、约16.5度坡道的视景标记；不参与平面车辆动力学" annotation(Placement(transformation(origin={198,28},
    extent={{-15,-15},{15,15}})));
  Control.ControlAllocate.CtrlAlloc ctrlAlloc(factor_pp = 0, factor_oa = 1)
    "控制分配模型，用于平衡路径规划与避障算法的作用比例" annotation(Placement(transformation(origin = {-51, 52},
    extent = {{-27, -27}, {27, 27}})));
  CountPoint.CountPoint countPoint
    "避障计分模块" annotation(Placement(transformation(origin={198,1},
extent={{-15,-15},{15,15}})));
  Real v annotation(Placement(transformation(extent={{-15,-72},{15,-32}})));
  Real yaw annotation(Placement(transformation(extent={{-15,-124},{15,-84}})));
  Real cR annotation(Placement(transformation(extent={{-15,32},{15,72}})));
  Real cO annotation(Placement(transformation(extent={{-15,84},{15,124}})));
  Real P;
  Real T;
  FourSensorController obsAvoidController_Sysblock2_1
    annotation (Placement(transformation(origin={-141,-44},
extent={{-30.5,-32},{30.5,32}})));
  FourRayDistanceSensor fourRaySensor(
    road = road.roadMap,
    width = road.roadWidth,
    obs = road.obstaclePoint,
    is_closed = true,
    L = body3DOF1_1.wheelbase,
    W = body3DOF1_1.track_front,
    obstacleRadius = obstacleSize/2)
    "正前、左前、右前、正后四超声波仿真" annotation(Placement(transformation(extent={{-15,-46},{15,-6}})));
equation
  connect(world.frame_b, rampVisual.frame_a);
  distanceSensor1.fdist = pathPlanner.lookahead_dist;
  //参数面板
  // v = floor(body3DOF1_1.v[1] * 100)/100;
  // yaw = floor((body3DOF1_1.angles[3] * 180 / pi)*100)/100;
  // cR = floor(countPoint.counterR*100)/100;
  // cO = floor(countPoint.counterO*100)/100;
  // P = floor(countPoint.finalPoints*100)/100;
  // T = floor(time*100)/100;
  v = body3DOF1_1.v[1];
  yaw = body3DOF1_1.angles[3];
  cR = countPoint.counterR;
  cO = countPoint.counterO;
  P = countPoint.finalPoints;
  T = time;
  connect(pID_Ackermann.rear_speed_l, body3DOF1_1.rl_speed) 
    annotation(Line(origin={80,19},
points={{-101.3,-42.75},{-64,-42.75},{-64,-77.58},{-42.7,-77.58}},
color={0,0,127},
thickness=1));
  connect(pID_Ackermann.rear_speed_r, body3DOF1_1.rr_speed) 
    annotation(Line(origin={140,-1},
points={{-161.3,-36.25},{-124,-36.25},{-124,-45.7},{-102.7,-45.7}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.angles[3], pID_Ackermann.current_psi) 
    annotation(Line(origin={84,4.99935},
points={{12.7,-28.4793},{38,-28.4793},{38,-5},{-188,-5},{-188,-69.2493},{-165.375,-69.2493}},
color={0,0,127},
thickness=1));
  connect(pID_Ackermann.delta_left, body3DOF1_1.fl_steer) 
    annotation(Line(origin={86,6},
points={{-107.3,-56.75},{-70,-56.75},{-70,-40.82},{-48.7,-40.82}},
color={0,0,127},
thickness=1));
  connect(pID_Ackermann.delta_right, body3DOF1_1.fr_steer) 
    annotation(Line(origin={85,5},
points={{-106.3,-69.25},{-69,-69.25},{-69,-28.48},{-47.7,-28.48}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.v[1], pID_Ackermann.current_v) 
    annotation(Line(origin={85,5.99935},
points={{11.7,-40.81935},{37,-40.81935},{37,-6},{-189,-6},{-189,-56.74935},{-166.375,-56.74935}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.v[1], pathPlanner.v) 
    annotation(Line(origin={-17,32.9994},
points={{113.7,-67.8194},{139,-67.8194},{139,-32.9994},{-163,-32.9994},{-163,1.0006},{-153.7,1.0006}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.r[1], pathPlanner.x) 
    annotation(Line(origin={-17,25.9994},
points={{113.7,-73.2394},{139,-73.2394},{139,-25.9994},{-163,-25.9994},{-163,44.0006},{-153.7,44.0006}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.r[2], pathPlanner.y) 
    annotation(Line(origin={-17,25.9994},
points={{113.7,-73.2394},{139,-73.2394},{139,-25.9994},{-163,-25.9994},{-163,26.0006},{-153.7,26.0006}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.Rsensor, distanceSensor1.right_sensor) 
    annotation(Line(origin={122,-79.58},
points={{-40.96,5.88},{-40.96,1.58},{0,1.58},{0,127.079991},{-25.3,127.079991}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.Lsensor, distanceSensor1.left_sensor) 
    annotation(Line(origin={114,-75.58},
points={{-42.68,1.88},{-42.68,-2.42},{8,-2.42},{8,132.080009},{-17.3,132.080009}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.Bsensor, distanceSensor1.rear_sensor) 
    annotation(Line(origin={106,-71.58},
points={{-44.4,-2.12},{-44.4,-6.42},{16,-6.42},{16,137.08},{-9.3,137.08}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.Fsensor, distanceSensor1.front_sensor) 
    annotation(Line(origin={98,-67.58},
points={{-46.12,-6.12},{-46.12,-10.42},{24,-10.42},{24,142.079991},{-1.3,142.079991}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.r[1:2], distanceSensor1.vehicle_position) 
    annotation(Line(origin={154,-72.58},
points={{-57.3,25.34},{-32,25.34},{-32,111.08},{-57.3,111.08}},
color={0,0,127},
thickness=1));
  connect(body3DOF1_1.angles[3], distanceSensor1.yaw) 
    annotation(Line(origin={157,-66.58},
points={{-60.3,43.1},{-35,43.1},{-35,96.08},{-60.3,96.08}},
color={0,0,127},
thickness=1));
  connect(ctrlAlloc.speed, pID_Ackermann.v_desired) 
    annotation(Line(origin={-45,109},
points={{23.7,-43.5},{61,-43.5},{61,-109},{-59,-109},{-59,-132.75},{-36.375,-132.75}},
color={0,0,127},
thickness=1));
  connect(ctrlAlloc.steer, pID_Ackermann.psi_desired);
  connect(pathPlanner.target_v, ctrlAlloc.speed_pp) 
    annotation(Line(origin={-150.3,109.75},
points={{39,-44.25},{46.3,-44.25},{46.3,-37.5},{69.6,-37.5}},
color={0,0,127},
thickness=1));
  connect(pathPlanner.steering_angle, ctrlAlloc.steer_pp) 
    annotation(Line(origin={-150,90},
points={{38.7,-51.499991},{46,-51.499991},{46,-44.75},{69.3,-44.75}},
color={0,0,127},
thickness=1));
  connect(distanceSensor1.DisRoad, countPoint.DisRoad) 
  annotation(Line(origin={102,19},
points={{-64.7,19.5},{-86,19.5},{-86,-19},{74,-19},{74,-10.5},{79.5,-10.5}},
color={0,0,127},
thickness=1));
  connect(distanceSensor1.DisObstacle, countPoint.DisObstacle) 
  annotation(Line(origin={102,12},
points={{-64.7,17.500009},{-86,17.500009},{-86,-12},{74,-12},{74,-18.5},{79.5,-18.5}},
color={0,0,127},
thickness=1));
  // 使用显式标量赋值，便于分别核验传感器获得的车体 x/y 坐标。
  fourRaySensor.vehicle_position[1] = body3DOF1_1.r[1];
  fourRaySensor.vehicle_position[2] = body3DOF1_1.r[2];
  connect(body3DOF1_1.angles[3], fourRaySensor.yaw);
  connect(obsAvoidController_Sysblock2_1.front_dist, fourRaySensor.front_dist)
  annotation(Line(origin={-70,27},
  points={{-103.3,-47},{-107.1,-47},{-107.1,-37},{102.6,-37},{102.6,47.5},{107.3,47.5}},
  color={0,0,0}));
  connect(fourRaySensor.front_left_dist, obsAvoidController_Sysblock2_1.front_left_dist)
  annotation(Line(origin={-75,15},
  points={{112.3,50.5},{58.4,50.5},{58.4,-16.4072},{-111.593,-16.4072},{-111.593,-51},{-98.3,-51}},
  color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.front_right_dist, fourRaySensor.front_right_dist)
  annotation(Line(origin={-70,2},
  points={{-103.3,-54},{-107.1,-54},{-107.1,-12},{102.6,-12},{102.6,54.500009},{107.3,54.500009}},
  color={0,0,0}));
  connect(fourRaySensor.rear_dist, obsAvoidController_Sysblock2_1.rear_dist)
  annotation(Line(origin={-75,-10},
  points={{112.3,57.499991},{58.4,57.499991},{58.4,8.59279},{-111.593,8.59279},{-111.593,-58},{-98.3,-58}},
  color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.speed, ctrlAlloc.speed_oa) 
  annotation(Line(origin={-95,15},
  points={{-13.7,-43},{9.6,-43},{9.6,43.75},{14.3,43.75}},
  color={0,0,0}));
  // 在原一阶滤波器之前完成相对修正到绝对航向的仿真接口换算。
  ctrlAlloc.steer_oa = body3DOF1_1.angles[3] +
    obsAvoidController_Sysblock2_1.steer;
end Track1FourSensor;
