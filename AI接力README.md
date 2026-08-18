# AI 接力 README

更新时间：2026-08-18（Asia/Shanghai）

这是一份给后续 AI 助手和队员的工作上下文。接手后先阅读本文件，再看 `决赛模型库/Unmanned_Vehicle_Race_2026/TEAM27_README.md` 与 `Team27_OneClick/README.md`。不要从旧版控制器重新开始。

## 1. 目标与硬件

- 队伍车辆编号：27。
- 电机型号：JGB520。
- 软件：MWorks Sysplorer 2026a；模型标注版本 26.3.0。
- 赛道：主办方尚未提供最终数字赛道；当前仿真依据示意照片、规则和 1–2 m 赛道宽度自行构建。
- 传感器布局：正前 1、左前约向外 20° 1、右前约向外 20° 1、正后 1。正后只监测，不设计倒车避障。

## 2. 当前权威文件

### 仿真

- 一键流程使用：`决赛模型库/Unmanned_Vehicle_Race_2026/Team27_Simulation/FinalRace2026/package.mo`
- 主模型：`FinalRace2026.Track1FourSensor`
- 控制器：`Team27_Simulation/FinalRace2026/FourSensorController.mo`
- 几何测距：`Team27_Simulation/FinalRace2026/FourRayDistanceSensor.mo`
- 开发副本：`本届决赛赛道/FinalRace2026`

若修改了开发副本，必须同步到一键流程使用的快照并重新跑 90 秒自动验证；不要让两份代码静默分叉。

### 实车

- 可代码生成控制器：`决赛模型库/Unmanned_Vehicle_Race_2026/Controller/ObsAvoidController_Team27_FFLFRR.mo`
- JGB520 整合模型：`决赛模型库/Unmanned_Vehicle_Race_2026/for_code_JGB520_Team27.mo`
- 一键入口：`决赛模型库/Unmanned_Vehicle_Race_2026/Team27_OneClick`
- 最近生成的树莓派工程：`Team27_OneClick/generated/Unmanned_Vehicle_Race_2026.for_code_JGB520_Team27`

实车控制器采用 Sysblock CCaller，核心函数为 `Team27_ControllerStep`。这是为绕开代码生成器不支持普通 Modelica `when/pre` 状态逻辑而采用的实现，已经通过 Sysplorer 检查和代码生成。

## 3. JGB520 信号映射

模型沿用赛会 wiringPi 编号，共用 `Trig1=4`：

| 控制器输入 | Echo | 机械位置 | 说明 |
|---|---:|---|---|
| sensor1 | 5 | 正前 | 主避障 |
| sensor4 | 14 | 左前约 20° | 左侧余量 |
| sensor3 | 13 | 右前约 20° | 右侧余量 |
| sensor5 | 6 | 正后 | 只监测 |
| sensor2 | 12 | 不安装 | 在软件中固定为 300 cm，不访问硬件 |

转向舵机为 `PWM_PIN1=26`。实车接口距离单位 cm、速度单位 cm/s、转角单位 rad。控制器转角限幅 ±0.45 rad，低于赛会注明的 ±0.6 rad 机械限制。

## 4. 当前控制策略

状态：

- 0：巡航。
- 1：向左绕行。
- 2：向右绕行。
- 3：紧急低速绕行。
- 4：停车。

实车默认值：巡航 30 cm/s、谨慎 20 cm/s、绕行 15 cm/s、紧急蠕行 8 cm/s；正前预警/紧急/停车为 100/40/25 cm；左右前预警/停车为 48/18 cm。无效、非有限或非正测距按近距离危险处理。

生成代码后，脚本会核验 `Team27_ControllerStep` 和 Echo2 旁路，并注入安全退出逻辑：SIGINT/SIGTERM/SIGHUP 时两电机归零、转向回中、关闭串口。不要改回 Sysplorer 默认只运行约 20 个周期的 `mwb_main.c`；部署使用 `team27_main.c`。

## 5. 已完成验证

2026-08-12 实际执行：

- `FinalRace2026.Track1FourSensor` 检查通过。
- 一键仿真运行 0–90 s 成功。
- t=77 s：`mode=2`，左前障碍距离约 0.566 m。
- t=90 s：道路碰撞 `cR=0`，障碍碰撞 `cO=0`，控制器恢复巡航。
- `ObsAvoidController_Team27_FFLFRR` 检查通过。
- `Unmanned_Vehicle_Race_2026.for_code_JGB520_Team27` 检查和代码生成通过。
- 生成的 C 文件通过本机 GCC 语法预检；仅有赛会模板原有的未使用参数/空 while 风格警告。

尚未验证：树莓派真实编译链接、串口权限、wiringPi 兼容性、引脚电平、转向正负方向、电机 ID/正反方向、超声波串扰、机械安装误差、真实赛道通过率。

## 6. 一键运行与部署

仿真：双击 `Team27_OneClick/一键运行仿真.bat`。

实车：先编辑 `Team27_OneClick/config.ps1`：

1. 填写 `PiHost`，必要时修改 `PiUser`、`PiPort`、`RemoteDir`。
2. 架空驱动轮并准备断电。
3. 将 `EnableRemoteRun` 从 `$false` 改为 `$true`。
4. 双击 `一键生成并上机.bat`。

默认安全锁只生成代码，不连接或启动真实车辆。不要为了“验证脚本”擅自解除安全锁。

## 7. 后续优先级

1. 在架空车轮条件下完成四传感器通道、电机 ID/方向和转向方向验收。
2. 实测四路 HC-SR04 刷新周期与串扰；赛会底层每路测距后等待约 15 ms，四路完整周期通常大于 60 ms。
3. 标定真实停车距离、转向零位和最大安全转角。
4. 用随机障碍批量运行多个种子，而非只验证当前 27 号固定场景。
5. 获得正式赛道后替换道路几何并重新回归，保留现有自动断言。
6. 再考虑提速；当前参数刻意保守。

## 8. Sysplorer 操作注意

- 不要调用 `ClearAll`，它会清空已加载库、翻译缓存和结果。
- 不要调用 `ChangeDirectory`；所有脚本使用绝对路径。
- 关键仿真结果逐变量读取，不要依赖曾出现错位的批量时刻读取。
- 外部模式插件只用于在线监视，不是当前生成、传输、编译或运行的必要条件。
- 修改控制器后必须同时完成：模型检查、代码生成、生成物关键字核验、C 语法检查和 90 秒仿真回归。

## 9. Git 协作建议

- `main` 保持可运行；算法实验使用短分支。
- 提交信息写明改了仿真、实车还是两者，以及验证到哪一步。
- 不提交密码、令牌、树莓派私钥或真实无线网络凭据。
- 仓库含赛会资料，保持私有；对外分享前单独确认主办方授权范围。

