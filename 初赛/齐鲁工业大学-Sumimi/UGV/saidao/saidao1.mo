model saidao1 "无人系统大赛模型-LOGO"
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
  Vehicle.VehicleBody.Body4DOF4S_TD body3DOF1_1(v_start = 1)
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
      roadMap = {{0, 0, 1}, {0.2354, 0.0092, 1}, {0.4693, 0.0369, 1}, {0.7003, 0.0829, 1}, {0.9271, 0.1468, 1}, {1.1481, 0.2284, 1}, {1.362, 0.327, 1}, {1.5687, 0.4416, 1}, {1.9811, 0.6797, 1}, {3.2183, 1.394, 1}, {4.4555, 2.1083, 1}, {5.6927, 2.8226, 1}, {6.9298, 3.5368, 1}, {8.167, 4.2511, 1}, {9.4042, 4.9654, 1}, {10.6588, 5.6318, 1}, {10.8838, 5.7016, 1}, {11.1135, 5.7536, 1}, {11.3467, 5.7874, 1}, {11.5817, 5.8028, 1}, {11.8173, 5.7997, 1}, {12.0518, 5.7782, 1}, {12.284, 5.7383, 1}, {12.5123, 5.6803, 1}, {12.7354, 5.6046, 1}, {12.9518, 5.5116, 1}, {13.1603, 5.4019, 1}, {13.3665, 5.2829, 1}, {14.0538, 4.8861, 1}, {14.7411, 4.4892, 1}, {15.9783, 3.7749, 1}, {17.2155, 3.0607, 1}, {17.9028, 2.6638, 1}, {19.14, 1.9495, 1}, {20.3771, 1.2353, 1}, {21.6143, 0.521, 1}, {22.9289, 0.0257, 1}, {23.1635, 0.0041, 1}, {23.399, 0.001, 1}, {23.6341, 0.0164, 1}, {23.8672, 0.0502, 1}, {24.097, 0.1022, 1}, {24.3219, 0.1721, 1}, {24.5407, 0.2594, 1}, {24.752, 0.3635, 1}, {24.958, 0.4813, 1}, {26.1952, 1.1956, 1}, {27.4323, 1.9099, 1}, {28.1197, 2.3067, 1}, {29.3499, 3.0276, 1}, {29.5386, 3.1686, 1}, {29.7157, 3.3239, 1}, {29.8801, 3.4926, 1}, {30.0307, 3.6737, 1}, {30.1666, 3.8661, 1}, {30.2871, 4.0685, 1}, {30.3913, 4.2798, 1}, {30.4786, 4.4986, 1}, {30.5484, 4.7235, 1}, {30.6004, 4.9533, 1}, {30.6342, 5.1864, 1}, {30.6496, 5.4215, 1}, {30.6506, 5.6587, 1}, {30.6506, 7.0873, 1}, {30.6506, 8.5159, 1}, {30.6506, 9.9444, 1}, {30.6506, 11.373, 1}, {30.6506, 12.8016, 1}, {30.6506, 14.2302, 1}, {30.6465, 15.657, 1}, {30.625, 15.8916, 1}, {30.5851, 16.1237, 1}, {30.5271, 16.352, 1}, {30.4514, 16.5751, 1}, {30.3584, 16.7915, 1}, {30.2487, 17, 1}, {30.123, 17.1992, 1}, {29.9821, 17.388, 1}, {29.8268, 17.5651, 1}, {29.658, 17.7294, 1}, {29.4769, 17.8801, 1}, {29.2846, 18.016, 1}, {29.0819, 18.1378, 1}, {28.8757, 18.2568, 1}, {27.6385, 18.9711, 1}, {26.4013, 19.6854, 1}, {25.1642, 20.3997, 1}, {24.4686, 20.7716, 1}, {24.2476, 20.8532, 1}, {24.0208, 20.9171, 1}, {23.7898, 20.9631, 1}, {23.5559
, 20.9908, 1},
{23.3205, 21, 1}, {23.0851, 20.9908, 1}, {22.8512, 20.9631, 1}, {22.6202, 20.9171, 1}, {22.3935, 20.8532, 1}, {22.1725, 20.7716, 1}, {21.9585, 20.673, 1}, {21.7518, 20.5584, 1}, {21.3394, 20.3203, 1}, {20.1022, 19.606, 1}, {18.865, 18.8917, 1}, {17.6278, 18.1774, 1}, {16.3907, 17.4632, 1}, {15.1535, 16.7489, 1}, {13.9163, 16.0346, 1}, {12.6617, 15.3682, 1}, {12.4367, 15.2984, 1}, {12.207, 15.2464, 1}, {11.9738, 15.2126, 1}, {11.7388, 15.1972, 1}, {11.5032, 15.2003, 1}, {11.2687, 15.2218, 1}, {11.0365, 15.2617, 1}, {10.8082, 15.3197, 1}, {10.5852, 15.3954, 1}, {10.3687, 15.4884, 1}, {10.1603, 15.5981, 1}, {9.9541, 15.7171, 1}, {8.7169, 16.4314, 1}, {7.4797, 17.1457, 1}, {6.2425, 17.86, 1}, {5.0053, 18.5743, 1}, {3.7682, 19.2886, 1}, {3.0808, 19.6854, 1}, {1.8437, 20.3997, 1}, {1.1481, 20.7716, 1}, {0.9271, 20.8532, 1}, {0.7003, 20.9171, 1}, {0.4693, 20.9631, 1}, {0.2354, 20.9908, 1}, {0, 21, 1}, {-0.2354, 20.9908, 1}, {-0.4693, 20.9631, 1}, {-0.7003, 20.9171, 1}, {-0.9271, 20.8532, 1}, {-1.1481, 20.7716, 1}, {-1.362, 20.673, 1}, {-1.5687, 20.5584, 1}, {-1.9811, 20.3203, 1}, {-3.2183, 19.606, 1}, {-4.4555, 18.8917, 1}, {-5.6927, 18.1774, 1}, {-6.7572, 17.2634, 1}, {-6.888, 17.0675, 1}, {-7.0031, 16.862, 1}, {-7.1018, 16.6481, 1}, {-7.1833, 16.4271, 1}, {-7.2472, 16.2003, 1}, {-7.2932, 15.9693, 1}, {-7.3209, 15.7354, 1}, {-7.3301, 15.5, 1}, {-7.3301, 15.2619, 1}, {-7.3301, 13.8333, 1}, {-7.3301, 12.4048, 1}, {-7.3301, 10.9762, 1}, {-7.3301, 9.5476, 1}, {-7.3301, 8.119, 1}, {-7.3301, 6.6905, 1}, {-7.3209, 5.2646, 1}, {-7.2932, 5.0307, 1}, {-7.2472, 4.7997, 1}, {-7.1833, 4.5729, 1}, {-7.1018, 4.3519, 1}, {-7.0031, 4.138, 1}, {-6.888, 3.9325, 1}, {-6.7572, 3.7366, 1}, {-6.6113, 3.5517, 1}, {-6.4514, 3.3787, 1}, {-6.2785, 3.2188, 1}, {-6.0935, 3.0729, 1}, {-5.8976, 2.9421, 1}, {-5.6927, 2.8226, 1}, {-4.4555, 2.1083, 1}, {-3.2183, 1.394, 1}, {-1.9811, 0.6797, 1}, {-0.7003, 0.0829, 1}, {-0.4693, 0.0369, 1}, {-0.2354, 0.0092, 1}, {0, 0, 1}, {0.2354, 0.0092, 1}},


    surface(r_0 = {0, 0, 0.252}),
    obstacleHeight = 0.1,
    obstacleSize = 0.1,obstaclePoint={{6.5116, 3.2327, -0.1105}, {11.9152, 5.643, -0.1105}, {13.1962, 5.4328, -0.1105}, {21.3, 1.05, -0.1105}, {21.8, 0.9, -0.1105}, {22.38, 0.69, -0.1105}, {22.97, 0.55, -0.1105}, {27.2208, 2.0762, -0.1105}, {28.5908, 2.5438, -0.1105}, {30.6747, 8.4365, -0.1105}, {30.6506, 12.246, -0.1105}, {14.8763, 16.7116, -0.1105}, {12.7826, 15.4753, -0.1105}, {7.8341, 17.0421, -0.1105}, {4.6404, 18.6183, -0.1105}, {0.2647, 20.863, -0.1105}, {-3.5242, 19.4597, -0.1105}, {-4.8798, 18.5569, -0.1105}, {-7.347, 12.8016, -0.1105}, {-7.3443, 9.3095, -0.1105}, {-6.9787, 8.2778, -0.1105}, {-6.0767, 3.2328, -0.1105}, {-3.8725, 1.5308, -0.1105}, {-2.8014, 1.4398, -0.1105}})
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
extent={{-30.5,-32.125},{30.5,32.125}})),__MWORKS(SECInstance=true));
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
  annotation(Line(origin={-75,29},
points={{-98.3,-48.9062},{-111.593,-48.9062},{-111.593,-31.4072},{107.6,-31.4072},{107.6,45.5},{112.3,45.5}},
color={0,0,0}));
  connect(obsAvoidController_Sysblock2_1.rear_dist, distanceSensor1.rear_dist) 
  annotation(Line(origin={-74,15},
points={{-99.3,-50.9687},{-110.6,-50.9687},{-110.6,-18.75},{106.6,-18.75},{106.6,50.5},{111.3,50.5}},
color={0,0,0}));
  connect(distanceSensor1.left_dist, obsAvoidController_Sysblock2_1.left_dist) 
  annotation(Line(origin={-74,1},
points={{111.3,55.5},{57.4,55.5},{57.4,22},{-110.6,22},{-110.6,-53.0312},{-99.3,-53.0312}},
color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.right_dist, distanceSensor1.right_dist) 
  annotation(Line(origin={-74,-13},
points={{-99.3,-55.09375},{-110.6,-55.09375},{-110.6,9.25},{106.6,9.25},{106.6,60.5},{111.3,60.5}},
color={0,0,0}));
  connect(obsAvoidController_Sysblock2_1.speed, ctrlAlloc.speed_oa) 
  annotation(Line(origin={-92,17},
points={{-16.7,-44.9375},{6.6,-44.9375},{6.6,41.75},{11.3,41.75}},
color={0,0,0}));
  connect(ctrlAlloc.steer_oa, obsAvoidController_Sysblock2_1.steer) 
  annotation(Line(origin={-92,-16},
points={{11.3,47.75},{-3.40721,47.75},{-3.40721,-44.0625},{-16.7,-44.0625}},
color={0,0,127}));
  end saidao1;