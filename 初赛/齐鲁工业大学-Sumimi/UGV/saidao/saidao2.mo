model saidao2 "无人系统大赛模型-综合环形"
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
      roadMap = {{0, 0, 1}, {2.8754, 0, 1}, {7.1885, 0, 1}, {10.0639, 0, 1}, {14.377, 0, 1}, {18.6901, 0, 1}, {21.5655, 0, 1}, {25.8679, 0.0953, 1}, {26.3265, 0.2263, 1}, {26.5491, 0.3121, 1}, {26.7662, 0.411, 1}, {26.977, 0.5227, 1}, {27.3768, 0.7827, 1}, {27.5644, 0.9301, 1}, {27.9115, 1.2572, 1}, {28.0699, 1.4356, 1}, {28.2173, 1.6232, 1}, {28.3532, 1.8192, 1}, {28.4773, 2.023, 1}, {28.589, 2.2338, 1}, {28.6879, 2.4509, 1}, {28.7737, 2.6735, 1}, {28.846, 2.9008, 1}, {28.9047, 3.1321, 1}, {28.9802, 3.603, 1}, {29, 4.08, 1}, {29, 7.44, 1}, {29, 11.76, 1}, {28.9495, 14.6336, 1}, {28.9047, 14.8679, 1}, {28.7737, 15.3265, 1}, {28.6879, 15.5491, 1}, {28.589, 15.7662, 1}, {28.4773, 15.977, 1}, {28.2173, 16.3768, 1}, {28.0699, 16.5644, 1}, {27.7428, 16.9115, 1}, {27.5644, 17.0699, 1}, {27.3768, 17.2173, 1}, {26.977, 17.4773, 1}, {26.7662, 17.589, 1}, {26.5491, 17.6879, 1}, {26.3265, 17.7737, 1}, {26.0992, 17.846, 1}, {25.8679, 17.9047, 1}, {25.6336, 17.9495, 1}, {24.9205, 17.9992, 1}, {24.6822, 17.9874, 1}, {24.4451, 17.9613, 1}, {24.2099, 17.9212, 1}, {23.7488, 17.7993, 1}, {23.3055, 17.6234, 1}, {23.0925, 17.5159, 1}, {22.6876, 17.2639, 1}, {22.1436, 16.8002, 1}, {21.9817, 16.6249, 1}, {21.6908, 16.247, 1}, {21.4469, 15.8372, 1}, {21.1766, 15.1754, 1}, {21.1133, 14.9454, 1}, {21.0284, 14.4761, 1}, {21.0071, 14.2385, 1}, {21, 14, 1}, {21, 10.9048, 1}, {20.8867, 8.0546, 1}, {20.6563, 7.3779, 1}, {20.3092, 6.753, 1}, {20.0183, 6.3751, 1}, {19.8564, 6.1998, 1}, {19.5028, 5.8798, 1}, {19.3124, 5.7361, 1}, {19.1137, 5.6041, 1}, {18.6945, 5.3766, 1}, {18.4755, 5.2821, 1}, {18.2512, 5.2007, 1}, {17.7901, 5.0788, 1}, {17.5549, 5.0387, 1}, {17.3178, 5.0126, 1}, {16.603, 5.0198, 1}, {16.1321, 5.0953, 1}, {15.9008, 5.154, 1}, {15.6735, 5.2263, 1}, {15.4509, 5.3121, 1}, {15.2338, 5.411, 1}, {15.023, 5.5227, 1}, {14.8192, 5.6468, 1}, {14.6232, 5.7827, 1}, {14.4356, 5.9301, 1}, {13.9301, 6.4356, 1}, {13.7827, 6.6232, 1}, {13.5227, 7.023, 1}, {13.411, 7.2338, 1}, {13.3121, 7.4509, 1}
, {13.2263, 7.6735
, 1}, {13.0953, 8.1321, 1}, {13.0032, 8.841, 1}, {13, 9.5556, 1}, {13, 13.8413, 1}, {12.7993, 15.2512, 1}, {12.7179, 15.4755, 1}, {12.6234, 15.6945, 1}, {12.3959, 16.1137, 1}, {12.2639, 16.3124, 1}, {11.9655, 16.6844, 1}, {11.8002, 16.8564, 1}, {11.6249, 17.0183, 1}, {11.0457, 17.4373, 1}, {10.4012, 17.7465, 1}, {9.9454, 17.8867, 1}, {9.4761, 17.9716, 1}, {9.2385, 17.9929, 1}, {8.7619, 18, 1}, {4.4762, 18, 1}, {0.1905, 18, 1}, {-1.2394, 17.9904, 1}, {-1.4772, 17.9618, 1}, {-1.712, 17.9143, 1}, {-1.9422, 17.8482, 1}, {-2.1665, 17.7639, 1}, {-2.3833, 17.6621, 1}, {-2.5913, 17.5432, 1}, {-2.7891, 17.4081, 1}, {-2.9755, 17.2577, 1}, {-3.1494, 17.0929, 1}, {-3.3095, 16.9147, 1}, {-3.4549, 16.7244, 1}, {-3.5847, 16.523, 1}, {-3.6979, 16.3119, 1}, {-3.794, 16.0925, 1}, {-3.8723, 15.8661, 1}, {-3.9322, 15.6341, 1}, {-3.9735, 15.3982, 1}, {-3.9957, 15.1597, 1}, {-3.9989, 14.9201, 1}, {-3.983, 14.6811, 1}, {-3.9481, 14.4441, 1}, {-3.8943, 14.2107, 1}, {-3.8221, 13.9823, 1}, {-3.7319, 13.7604, 1}, {-3.6243, 13.5463, 1}, {-3.4999, 13.3416, 1}, {-3.3597, 13.1474, 1}, {-3.2043, 12.9651, 1}, {-3.0349, 12.7957, 1}, {-2.8526, 12.6403, 1}, {-2.6584, 12.5001, 1}, {-2.4537, 12.3757, 1}, {-2.2396, 12.2681, 1}, {-2.0177, 12.1779, 1}, {-1.7893, 12.1057, 1}, {-1.5559, 12.0519, 1}, {-1.3189, 12.017, 1}, {-1.0799, 12.0011, 1}, {2.0159, 12, 1}, {4.8661, 11.8723, 1}, {5.0925, 11.794, 1}, {5.3119, 11.6979, 1}, {5.523, 11.5847, 1}, {5.7244, 11.4549, 1}, {5.9147, 11.3095, 1}, {6.0929, 11.1494, 1}, {6.2577, 10.9755, 1}, {6.4081, 10.7891, 1}, {6.5432, 10.5913, 1}, {6.6621, 10.3833, 1}, {6.7639, 10.1665, 1}, {6.8482, 9.9422, 1}, {6.9143, 9.712, 1}, {6.9618, 9.4772, 1}, {6.9904, 9.2394, 1}, {7, 9, 1}, {6.9904, 8.7606, 1}, {6.9618, 8.5228, 1}, {6.9143, 8.288, 1}, {6.8482, 8.0578, 1}, {6.7639, 7.8335, 1}, {6.6621, 7.6167, 1}, {6.5432, 7.4087, 1}, {6.4081, 7.2109, 1}, {6.2577, 7.0245, 1}, {6.0929, 6.8506, 1}, {5.9147, 6.6905, 1}, {5.7244, 6.5451, 1}, {5.523, 6.4153, 1}, {5.3119, 6.3021, 1}, {5.0925, 6.206
, 1}, {4.8661, 6.1277, 1}, {4.6341, 6.0678, 1}, {4.3982, 6.0265, 1}, {4.1597, 6.0043, 1}, {3.4444, 6, 1}, {-0.8413, 6, 1}, {-3.6341, 5.9322, 1}, {-3.8661, 5.8723, 1}, {-4.0925, 5.794, 1}, {-4.3119, 5.6979, 1}, {-4.523, 5.5847, 1}, {-4.7244, 5.4549, 1}, {-4.9147, 5.3095, 1}, {-5.0929, 5.1494, 1}, {-5.2577, 4.9755, 1}, {-5.4081, 4.7891, 1}, {-5.5432, 4.5913, 1}, {-5.6621, 4.3833, 1}, {-5.7639, 4.1665, 1}, {-5.8482, 3.9422, 1}, {-5.9143, 3.712, 1}, {-5.9618, 3.4772, 1}, {-5.9904, 3.2394, 1}, {-6, 3, 1}, {-5.9904, 2.7606, 1}, {-5.9618, 2.5228, 1}, {-5.9143, 2.288, 1}, {-5.8482, 2.0578, 1}, {-5.7639, 1.8335, 1}, {-5.6621, 1.6167, 1}, {-5.5432, 1.4087, 1}, {-5.4081, 1.2109, 1}, {-5.2577, 1.0245, 1}, {-5.0929, 0.8506, 1}, {-4.9147, 0.6905, 1}, {-4.7244, 0.5451, 1}, {-4.523, 0.4153, 1}, {-4.3119, 0.3021, 1}, {-4.0925, 0.206, 1}, {-3.8661, 0.1277, 1}, {-3.6341, 0.0678, 1}, {-3.3982, 0.0265, 1}, {-3.1597, 0.0043, 1}, {-2.9211, 0, 1}, {0, 0, 1}},


    surface(r_0 = {0, 0, 0.252}),
    obstacleHeight = 0.1,
    obstacleSize = 0.1,obstaclePoint={{1.9377, 0, -0.1105}, {6.7891, -0.2144, -0.1105}, {7.8275, 0.2657, -0.1105}, {15.4153, 0, -0.1105}, {22.6038, 0, -0.1105}, {27.5501, 1.293, -0.1105}, {28.416, 1.4764, -0.1105}, {25.8562, 18.0491, -0.1105}, {23.2834, 17.0867, -0.1105}, {20.8716, 9.3175, -0.1105}, {17.5125, 5.3413, -0.1105}, {12.7899, 11.0635, -0.1105}, {13.0135, 12.7302, -0.1105}, {9.5224, 17.7293, -0.1105}, {-3.0957, 12.8424, -0.1105}, {-0.127, 11.8444, -0.1105}, {1.8571, 12.0618, -0.1105}, {-0.0476, 5.8567, -0.1105}, {-3.5158, 5.5015, -0.1105}, {-4.1831, 5.5256, -0.1105}})
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
    annotation (Placement(transformation(origin={-141,-44},
extent={{-30.5,-31},{30.5,31}})),__MWORKS(SECInstance=true));
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
  annotation(Line(origin={-73,25},
points={{-100.3,-45.75},{-104.1,-45.75},{-104.1,-36},{105.6,-36},{105.6,49.5},{110.3,49.5}},
color={0,0,0}));
  connect(distanceSensor1.rear_dist, obsAvoidController_Sysblock2_1.rear_dist) 
  annotation(Line(origin={-75,11},
points={{112.3,54.5},{58.4,54.5},{58.4,-13.4072},{-111.593,-13.4072},{-111.593,-47.25},{-98.3,-47.25}},
color={0,0,127}));
  connect(distanceSensor1.left_dist, obsAvoidController_Sysblock2_1.left_dist) 
  annotation(Line(origin={-75,-3},
points={{112.3,59.5},{58.4,59.5},{58.4,0.592788},{-111.593,0.592788},{-111.593,-48.75},{-98.3,-48.75}},
color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.right_dist, distanceSensor1.right_dist) 
  annotation(Line(origin={-73,-17},
points={{-100.3,-50.25},{-104.1,-50.25},{-104.1,6},{105.6,6},{105.6,64.499991},{110.3,64.499991}},
color={0,0,0}));
  connect(obsAvoidController_Sysblock2_1.speed, ctrlAlloc.speed_oa) 
  annotation(Line(origin={-91,13},
points={{-17.7,-41.5},{5.6,-41.5},{5.6,45.75},{10.3,45.75}},
color={0,0,0}));
  connect(obsAvoidController_Sysblock2_1.steer, ctrlAlloc.steer_oa) 
  annotation(Line(origin={-91,-20},
points={{-17.7,-39.5},{5.6,-39.5},{5.6,51.75},{10.3,51.75}},
color={0,0,0}));
  end saidao2;