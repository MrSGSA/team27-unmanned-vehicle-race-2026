model saidao3 "无人系统大赛模型-三角形"
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
textColor={0,0,0}), Text(origin={-141,-11},
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
textColor={255,0,0})}), experiment(Algorithm=Dassl,InlineIntegrator=false,InlineStepSize=false,Interval=0.05,StartTime=0,StopTime=inf,Tolerance=0.0001),Protection(access=Access.packageDuplicate));
  Vehicle.VehicleBody.Body4DOF4S_TD body3DOF1_1(v_start = 2)
    "四自由度无人车多体模型，x，y，z及绕z轴偏转" annotation(Placement(transformation(origin = {67, -44},
    extent = {{-27, -27}, {27, 27}})));
  //   inner TADynamics.Roads.RoadModel.flatRoad road(L0=1000,B0=10,x_start=-10) if false 
  //     annotation (Placement(transformation(origin={130,-58}, 
  // extent={{-10,-10},{10,10}})));
  Control.Ackermann_control.PID_Ackermann pID_Ackermann(L = body3DOF1_1.wheelbase, W = body3DOF1_1.track_front, r = 0.03, Kp_v = 100, Kp_psi = 100, Kd_v = 0.5, Ki_psi = 0.15, Kd_psi = 0.1)
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
      roadMap = {{0, 0, 1}, {1.4286, 0, 1}, {2.8571, 0, 1}, {4.2857, 0, 1}, {5.7143, 0, 1}, {7.1429, 0, 1}, {8.5714, 0, 1}, {10, 0, 1}, {11.4286, 0, 1}, {12.8571, 0, 1}, {14.2857, 0, 1}, {15.709, 0.085, 1}, {15.9384, 0.1505, 1}, {16.1618, 0.2341, 1}, {16.3779, 0.3352, 1}, {16.5853, 0.453, 1}, {16.7826, 0.5871, 1}, {16.9687, 0.7363, 1}, {17.1423, 0.8999, 1}, {17.3024, 1.0767, 1}, {17.4479, 1.2657, 1}, {17.578, 1.4657, 1}, {17.6917, 1.6754, 1}, {17.7885, 1.8934, 1}, {17.8676, 2.1184, 1}, {17.9285, 2.3491, 1}, {17.971, 2.5838, 1}, {17.9947, 2.8212, 1}, {17.9994, 3.0596, 1}, {17.9852, 3.2978, 1}, {17.9521, 3.534, 1}, {17.9003, 3.7668, 1}, {17.8302, 3.9949, 1}, {17.7423, 4.2166, 1}, {17.6369, 4.4306, 1}, {17.5187, 4.6375, 1}, {16.8044, 5.8746, 1}, {16.0901, 7.1118, 1}, {15.3759, 8.349, 1}, {14.6616, 9.5862, 1}, {13.9473, 10.8234, 1}, {13.233, 12.0605, 1}, {12.5191, 13.297, 1}, {11.8086, 14.5277, 1}, {11.0981, 15.7583, 1}, {10.3875, 16.989, 1}, {9.6143, 18.1187, 1}, {9.4385, 18.28, 1}, {9.2505, 18.4267, 1}, {9.0514, 18.5581, 1}, {8.8424, 18.6733, 1}, {8.625, 18.7714, 1}, {8.4005, 18.852, 1}, {8.1703, 18.9145, 1}, {7.9359, 18.9585, 1}, {7.6987, 18.9838, 1}, {7.4602, 18.9901, 1}, {7.222, 18.9775, 1}, {6.9856, 18.9459, 1}, {6.7524, 18.8957, 1}, {6.5239, 18.8272, 1}, {6.3016, 18.7406, 1}, {6.0869, 18.6367, 1}, {5.8811, 18.5161, 1}, {5.6856, 18.3795, 1}, {5.5015, 18.2278, 1}, {5.33, 18.0619, 1}, {5.1723, 17.883, 1}, {5.0293, 17.6921, 1}, {4.9019, 17.4904, 1}, {4.7829, 17.2842, 1}, {4.0686, 16.047, 1}, {3.3543, 14.8098, 1}, {2.64, 13.5726, 1}, {1.9257, 12.3355, 1}, {1.2114, 11.0983, 1}, {0.4972, 9.8611, 1}, {-0.2171, 8.6239, 1}, {-0.9314, 7.3868, 1}, {-1.6457, 6.1496, 1}, {-2.36, 4.9124, 1}, {-2.9369, 3.6121, 1}, {-2.9762, 3.3768, 1}, {-2.9968, 3.1391, 1}, {-2.9984, 2.9006, 1}, {-2.981, 2.6627, 1}, {-2.9448, 2.4269, 1}, {-2.8899, 2.1948, 1}, {-2.8168, 1.9677, 1}, {-2.7259, 1.7472, 1}, {-2.6177, 1.5346, 1}, {-2.493, 1.3312, 1}, {-2.3526, 1.1384, 1}, {-2.1972, 0.9574, 1}, {-2.028
, 0.7893, 1}, {
-1.8459, 0.6352, 1}, {-1.6522, 0.496, 1}, {-1.448, 0.3726, 1}, {-1.2347, 0.2659, 1}, {-1.0136, 0.1764, 1}, {-0.7861, 0.1048, 1}, {-0.5535, 0.0515, 1}, {-0.3175, 0.0169, 1}, {-0.0795, 0.0011, 1}, {0, 0, 1}, {1.4286, 0, 1}},


    surface(r_0 = {0, 0, 0.252}),
    obstacleHeight = 0.1,
    obstacleSize = 0.1,obstaclePoint={{1.2698, 0, -0.1105}, {4.6825, 0, -0.1105}, {6.2698, -0.2, -0.1105}, {15.3331, 0, -0.1105}, {16.4418, 0.5404, -0.1105}, {18.275, 2.5412, -0.1105}, {17.8764, 4.2761, -0.1105}, {16.5674, 5.7378, -0.1105}, {14.2184, 10.57, -0.1105}, {13.7817, 11.0467, -0.1105}, {11.3349, 15.266, -0.1105}, {3.9357, 15.9881, -0.1105}, {2.501, 13.3001, -0.1105}, {1.2631, 11.0107, -0.1105}, {0.3972, 10.7218, -0.1105}, {0.1643, 9.2047, -0.1105}, {-0.5773, 8.282, -0.1105}, {-2.0836, 4.5696, -0.1105}, {-3.2918, 3.5954, -0.1105}, {-1.8133, 0.5233, -0.1105}})
    "Figure-eight pseudo-overpass road; roadMap third column remains target speed" annotation(Placement(transformation(origin={198,64},
extent={{-15,-15},{15,15}})));
  Control.ControlAllocate.CtrlAlloc ctrlAlloc(factor_pp = 1, factor_oa = 0.5)
    "控制分配模型，用于平衡路径规划与避障算法的作用比例" annotation(Placement(transformation(origin = {-51, 52},
    extent = {{-27, -27}, {27, 27}})));
  CountPoint.CountPoint countPoint
    "避障计分模块" annotation(Placement(transformation(origin={198,1},
extent={{-15,-15},{15,15}})));
  Real v;
  Real yaw;
  Real cR;
  Real cO;
  Real P;
  Real T;
  ObsAvoidController_Sysblock2 obsAvoidController_Sysblock2_1 
    annotation (Placement(transformation(origin={-141,-48.8617},
extent={{-30.5,-31.8617},{30.5,31.8617}})),__MWORKS(SECInstance=true));
equation
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
  connect(ctrlAlloc.steer, pID_Ackermann.psi_desired) 
    annotation(Line(origin={-45,96},
points={{23.7,-57.5},{61,-57.5},{61,-96},{-59,-96},{-59,-133.25},{-36.375,-133.25}},
color={0,0,127},
thickness=1));
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
  connect(obsAvoidController_Sysblock2_1.front_dist, distanceSensor1.front_dist) 
  annotation(Line(origin={-70,25},
  points={{-103.3,-49.9654},{-107.1,-49.9654},{-107.1,-40},{102.6,-40},{102.6,49.5},{107.3,49.5}},
  color={0,0,0}));
  connect(distanceSensor1.rear_dist, obsAvoidController_Sysblock2_1.rear_dist) 
  annotation(Line(origin={-75,12},
  points={{112.3,53.5},{58.4,53.5},{58.4,-14.4072},{-111.593,-14.4072},{-111.593,-52.8963},{-98.3,-52.8963}},
  color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.left_dist, distanceSensor1.left_dist) 
  annotation(Line(origin={-70,0},
  points={{-103.3,-56.8272},{-107.1,-56.8272},{-107.1,-15},{102.6,-15},{102.6,56.500009},{107.3,56.500009}},
  color={0,0,0}));
  connect(distanceSensor1.right_dist, obsAvoidController_Sysblock2_1.right_dist) 
  annotation(Line(origin={-75,-13},
  points={{112.3,60.499991},{58.4,60.499991},{58.4,10.5928},{-111.593,10.5928},{-111.593,-59.7581},{-98.3,-59.7581}},
  color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.speed, ctrlAlloc.speed_oa) 
  annotation(Line(origin={-95,13},
  points={{-13.7,-45.9309},{9.6,-45.9309},{9.6,45.75},{14.3,45.75}},
  color={0,0,0}));
  connect(obsAvoidController_Sysblock2_1.steer, ctrlAlloc.steer_oa) 
  annotation(Line(origin={-95,-17},
  points={{-13.7,-47.7926},{9.6,-47.7926},{9.6,48.75},{14.3,48.75}},
  color={0,0,0}));
  end saidao3;