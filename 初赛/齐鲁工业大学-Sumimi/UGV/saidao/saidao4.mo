model saidao4 "无人系统大赛模型-云型"
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
textColor={255,0,0})}), experiment(Algorithm=Dassl,InlineIntegrator=false,InlineStepSize=false,Interval=0.05,StartTime=0,StopTime=inf,Tolerance=0.0001,StoreEventValue=0),Protection(access=Access.packageDuplicate));
  Vehicle.VehicleBody.Body4DOF4S_TD body3DOF1_1(v_start = 2)
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
      roadMap = {{0, 0, 1}, {1.4286, 0, 1}, {2.8571, 0, 1}, {4.2857, 0, 1}, {5.7143, 0, 1}, {7.1429, 0, 1}, {8.5714, 0, 1}, {10, 0, 1}, {11.4286, 0, 1}, {12.8571, 0, 1}, {14.2857, 0, 1}, {15.712, 0.0639, 1}, {15.9454, 0.1133, 1}, {16.1754, 0.1766, 1}, {16.4012, 0.2535, 1}, {16.6221, 0.3437, 1}, {16.8372, 0.4469, 1}, {17.0457, 0.5627, 1}, {17.247, 0.6908, 1}, {17.4403, 0.8306, 1}, {17.6249, 0.9817, 1}, {17.8002, 1.1436, 1}, {17.9655, 1.3156, 1}, {18.1202, 1.4972, 1}, {18.2639, 1.6876, 1}, {18.3959, 1.8863, 1}, {18.5159, 2.0925, 1}, {18.6234, 2.3055, 1}, {18.7179, 2.5245, 1}, {18.7993, 2.7488, 1}, {18.8671, 2.9775, 1}, {18.9212, 3.2099, 1}, {18.9613, 3.4451, 1}, {18.9874, 3.6822, 1}, {18.9992, 3.9205, 1}, {18.9968, 4.159, 1}, {18.9802, 4.397, 1}, {18.9495, 4.6336, 1}, {18.9047, 4.8679, 1}, {18.846, 5.0992, 1}, {18.7737, 5.3265, 1}, {18.6879, 5.5491, 1}, {18.589, 5.7662, 1}, {18.4773, 5.977, 1}, {18.3532, 6.1808, 1}, {18.2173, 6.3768, 1}, {18.0699, 6.5644, 1}, {17.9115, 6.7428, 1}, {17.7428, 6.9115, 1}, {17.5644, 7.0699, 1}, {17.3768, 7.2173, 1}, {17.1808, 7.3532, 1}, {16.977, 7.4773, 1}, {16.7662, 7.589, 1}, {16.5491, 7.6879, 1}, {16.3265, 7.7737, 1}, {16.0992, 7.846, 1}, {15.8679, 7.9047, 1}, {15.6336, 7.9495, 1}, {15.397, 7.9802, 1}, {15.159, 7.9968, 1}, {14.9205, 8.0008, 1}, {14.6822, 8.0126, 1}, {14.4451, 8.0387, 1}, {14.2099, 8.0788, 1}, {13.9775, 8.1329, 1}, {13.7488, 8.2007, 1}, {13.5245, 8.2821, 1}, {13.3055, 8.3766, 1}, {13.0925, 8.4841, 1}, {12.8863, 8.6041, 1}, {12.6876, 8.7361, 1}, {12.4972, 8.8798, 1}, {12.3156, 9.0345, 1}, {12.1436, 9.1998, 1}, {11.9817, 9.3751, 1}, {11.8306, 9.5597, 1}, {11.6908, 9.753, 1}, {11.5627, 9.9543, 1}, {11.4469, 10.1628, 1}, {11.3437, 10.3779, 1}, {11.2535, 10.5988, 1}, {11.1766, 10.8246, 1}, {11.1133, 11.0546, 1}, {11.0639, 11.288, 1}, {11.0284, 11.5239, 1}, {11.0071, 11.7615, 1}, {11, 12, 1}, {10.7465, 13.4012, 1}, {10.6563, 13.6221, 1}, {10.5531, 13.8372, 1}, {10.4373, 14.0457, 1}, {10.3092, 14.247, 1}, {10.1694, 14.4403,
1}, {10.0183, 14.6249
, 1}, {9.8564, 14.8002, 1}, {9.6844, 14.9655, 1}, {9.5028, 15.1202, 1}, {9.3124, 15.2639, 1}, {9.1137, 15.3959, 1}, {8.9075, 15.5159, 1}, {8.6945, 15.6234, 1}, {8.4755, 15.7179, 1}, {8.2512, 15.7993, 1}, {8.0225, 15.8671, 1}, {7.7901, 15.9212, 1}, {7.5549, 15.9613, 1}, {7.3178, 15.9874, 1}, {7.0795, 15.9992, 1}, {6.841, 15.9968, 1}, {6.603, 15.9802, 1}, {6.3664, 15.9495, 1}, {6.1321, 15.9047, 1}, {5.9008, 15.846, 1}, {5.6735, 15.7737, 1}, {5.4509, 15.6879, 1}, {5.2338, 15.589, 1}, {5.023, 15.4773, 1}, {4.8192, 15.3532, 1}, {4.6232, 15.2173, 1}, {4.4356, 15.0699, 1}, {4.2572, 14.9115, 1}, {4.0885, 14.7428, 1}, {3.9301, 14.5644, 1}, {3.7827, 14.3768, 1}, {3.6468, 14.1808, 1}, {3.5227, 13.977, 1}, {3.411, 13.7662, 1}, {3.3121, 13.5491, 1}, {3.2263, 13.3265, 1}, {3.154, 13.0992, 1}, {3.0953, 12.8679, 1}, {3.0505, 12.6336, 1}, {3.0198, 12.397, 1}, {3.0032, 12.159, 1}, {2.9992, 11.9205, 1}, {2.9874, 11.6822, 1}, {2.9613, 11.4451, 1}, {2.9212, 11.2099, 1}, {2.8671, 10.9775, 1}, {2.7993, 10.7488, 1}, {2.7179, 10.5245, 1}, {2.6234, 10.3055, 1}, {2.5159, 10.0925, 1}, {2.3959, 9.8863, 1}, {2.2639, 9.6876, 1}, {2.1202, 9.4972, 1}, {1.9655, 9.3156, 1}, {1.8002, 9.1436, 1}, {1.6249, 8.9817, 1}, {1.4403, 8.8306, 1}, {1.247, 8.6908, 1}, {1.0457, 8.5627, 1}, {0.8372, 8.4469, 1}, {0.6221, 8.3437, 1}, {0.4012, 8.2535, 1}, {0.1754, 8.1766, 1}, {-0.0546, 8.1133, 1}, {-0.288, 8.0639, 1}, {-0.5239, 8.0284, 1}, {-0.7615, 8.0071, 1}, {-1, 8, 1}, {-2.4012, 7.7465, 1}, {-2.6221, 7.6563, 1}, {-2.8372, 7.5531, 1}, {-3.0457, 7.4373, 1}, {-3.247, 7.3092, 1}, {-3.4403, 7.1694, 1}, {-3.6249, 7.0183, 1}, {-3.8002, 6.8564, 1}, {-3.9655, 6.6844, 1}, {-4.1202, 6.5028, 1}, {-4.2639, 6.3124, 1}, {-4.3959, 6.1137, 1}, {-4.5159, 5.9075, 1}, {-4.6234, 5.6945, 1}, {-4.7179, 5.4755, 1}, {-4.7993, 5.2512, 1}, {-4.8671, 5.0225, 1}, {-4.9212, 4.7901, 1}, {-4.9613, 4.5549, 1}, {-4.9874, 4.3178, 1}, {-4.9992, 4.0795, 1}, {-4.9968, 3.841, 1}, {-4.9802, 3.603, 1}, {-4.9495, 3.3664, 1}, {-4.9047, 3.1321, 1}, {-4.846
, 2.9008, 1}, {-4.7737, 2.6735, 1}, {-4.6879, 2.4509, 1}, {-4.589, 2.2338, 1}, {-4.4773, 2.023, 1}, {-4.3532, 1.8192, 1}, {-4.2173, 1.6232, 1}, {-4.0699, 1.4356, 1}, {-3.9115, 1.2572, 1}, {-3.7428, 1.0885, 1}, {-3.5644, 0.9301, 1}, {-3.3768, 0.7827, 1}, {-3.1808, 0.6468, 1}, {-2.977, 0.5227, 1}, {-2.7662, 0.411, 1}, {-2.5491, 0.3121, 1}, {-2.3265, 0.2263, 1}, {-2.0992, 0.154, 1}, {-1.8679, 0.0953, 1}, {-1.6336, 0.0505, 1}, {-1.397, 0.0198, 1}, {-1.159, 0.0032, 1}, {-0.9231, 0, 1}, {-0.6923, 0, 1}, {0, 0, 1}},


    surface(r_0 = {0, 0, 0.252}),
    obstacleHeight = 0.1,
    obstacleSize = 0.1,obstaclePoint={{1.1905, -0.2, -0.1105}, {3.0952, 0, -0.1105}, {5.3175, 0.2, -0.1105}, {9.127, 0, -0.1105}, {14.9206, -0.0415, -0.1105}, {15.8466, -0.0015, -0.1105}, {19.0773, 4.6701, -0.1105}, {18.0187, 6.7093, -0.1105}, {12.4917, 8.8596, -0.1105}, {10.9553, 10.4873, -0.1105}, {11.6586, 10.7503, -0.1105}, {11.0468, 13.1229, -0.1105}, {10.3902, 13.8393, -0.1105}, {8.8372, 15.5286, -0.1105}, {7.922, 16.0481, -0.1105}, {5.798, 15.75, -0.1105}, {2.8444, 11.1899, -0.1105}, {-1.3435, 8.0095, -0.1105}, {-4.8869, 3.6663, -0.1105}, {-3.2457, 1.0003, -0.1105}})
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
extent={{-27,-30.5},{27,30.5}})),__MWORKS(SECInstance=true));
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
  annotation(Line(origin={-68,27},
  points={{-101.8,-48.125},{-105.6,-48.125},{-105.6,-38.5},{100.6,-38.5},{100.6,47.5},{105.3,47.5}},
  color={0,0,0}));
  connect(distanceSensor1.rear_dist, obsAvoidController_Sysblock2_1.rear_dist) 
  annotation(Line(origin={-75,15},
  points={{112.3,50.5},{58.4,50.5},{58.4,-17.4072},{-111.593,-17.4072},{-111.593,-51.375},{-94.8,-51.375}},
  color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.left_dist, distanceSensor1.left_dist) 
  annotation(Line(origin={-68,2},
  points={{-101.8,-53.625},{-105.6,-53.625},{-105.6,-13.5},{100.6,-13.5},{100.6,54.500009},{105.3,54.500009}},
  color={0,0,0}));
  connect(distanceSensor1.right_dist, obsAvoidController_Sysblock2_1.right_dist) 
  annotation(Line(origin={-75,-10},
  points={{112.3,57.499991},{58.4,57.499991},{58.4,7.59279},{-111.593,7.59279},{-111.593,-56.875},{-94.8,-56.875}},
  color={0,0,127}));
  connect(obsAvoidController_Sysblock2_1.speed, ctrlAlloc.speed_oa) 
  annotation(Line(origin={-96,15},
  points={{-16.2,-43.75},{10.6,-43.75},{10.6,43.75},{15.3,43.75}},
  color={0,0,0}));
  connect(obsAvoidController_Sysblock2_1.steer, ctrlAlloc.steer_oa) 
  annotation(Line(origin={-96,-14},
  points={{-16.2,-45.25},{10.6,-45.25},{10.6,45.75},{15.3,45.75}},
  color={0,0,0}));
  end saidao4;