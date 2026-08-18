# 27号车交接入口（JGB520）

直接进入 `Team27_OneClick`：

- 双击 `一键运行仿真.bat`：自动加载 UGV、决赛模拟赛道，检查并运行到 90 s；结束时自动验证已触发避障且碰撞计数为零。
- 双击 `一键生成并上机.bat`：自动检查部署模型、生成 C 代码、核验四传感器映射并准备树莓派工程。默认安全锁只生成、不启动车轮。

详细接线、首次上机配置和安全要求见 `Team27_OneClick/README.md`。

核心文件：

- `Team27_Simulation/FinalRace2026`：完整仿真包。
- `Controller/ObsAvoidController_Team27_FFLFRR.mo`：已通过 Sysblock 检查和代码生成的实车控制器。
- `for_code_JGB520_Team27.mo`：已接入上述控制器的赛会 JGB520 部署模型。

当前结论：仿真入口已实际运行并在 77 s 进入 mode=2 避障，90 s 时道路/障碍碰撞计数均为 0；上机模型已通过检查和 C 代码生成。实车机械、电气和赛道测试仍必须现场完成。

