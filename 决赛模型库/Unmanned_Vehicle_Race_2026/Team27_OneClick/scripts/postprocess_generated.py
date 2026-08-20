"""只读审计 MWORKS 生成物；禁止对生成后的 C 代码做二次修正。"""

import argparse
import json
import pathlib
import sys


def require(source: str, token: str, message: str) -> None:
    if token not in source:
        raise RuntimeError(message)


def reject(source: str, token: str, message: str) -> None:
    if token in source:
        raise RuntimeError(message)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    directory = pathlib.Path(args.directory)
    model_c = directory / "for_code_JGB520_Team27.c"
    capi_c = directory / "for_code_JGB520_Team27_capi.c"
    extern_include = directory / "for_code_JGB520_Team27_extern_include.h"
    external_resource = directory / "ExternalCResource.json"
    extern_dir = directory / "extern_inc"

    if not model_c.is_file():
        raise RuntimeError(f"missing generated file: {model_c}")
    if not capi_c.is_file():
        raise RuntimeError(f"missing generated CAPI file: {capi_c}")
    if not extern_include.is_file():
        raise RuntimeError(f"missing generated external include: {extern_include}")
    if not external_resource.is_file():
        raise RuntimeError(f"missing external-resource manifest: {external_resource}")
    if not extern_dir.is_dir():
        raise RuntimeError(f"missing generated external-interface directory: {extern_dir}")

    model_source = model_c.read_text(encoding="utf-8")
    capi_source = capi_c.read_text(encoding="utf-8")
    extern_include_source = extern_include.read_text(encoding="utf-8")
    resource = json.loads(external_resource.read_text(encoding="utf-8"))
    extern_source = "\n".join(
        path.read_text(encoding="utf-8")
        for path in sorted(extern_dir.glob("*.c"))
    )
    all_generated = model_source + "\n" + extern_source

    # V3.8五固定探头控制参数、平行走廊释放、带方向倒车和低速满舵约束必须全部来自
    # MWORKS主模型生成代码。这里仅审计，绝不修改生成后的C代码。
    for token in (
        "frontWarn = (MwbDouble)((26))",
        "frontStrong = (MwbDouble)((12))",
        "frontEmergency = 5.5",
        "frontRelease = (MwbDouble)((30))",
        "frontSectorEmergency = 4.5",
        "frontDiagonalWarn = (MwbDouble)((22))",
        "frontDiagonalRelease = (MwbDouble)((26))",
        "sideEmergency = (MwbDouble)((6))",
        "sideCorrection = (MwbDouble)((10))",
        "scoreCap = (MwbDouble)((40))",
        "unknownForward = (MwbDouble)((10))",
        "unknownSide = (MwbDouble)((8))",
        "pathFrontMinimum = (MwbDouble)((9))",
        "pathSideMinimum = (MwbDouble)((8))",
        "directionHysteresis = 2.5",
        "directionSwitchMargin = (MwbDouble)((5))",
        "directionConfirmTime = 0.1",
        "clockwiseBias = 0.5",
        "localDw->leftSideReach = 1.6 * localDw->slCap",
        "localDw->rightSideReach = 1.6 * localDw->srCap",
        "localDw->leftScore = localDw->flCap",
        "localDw->leftScore = localDw->leftSideReach",
        "localDw->rightScore = localDw->frCap + localDw->clockwiseBias",
        "localDw->rightScore = localDw->rightSideReach + localDw->clockwiseBias",
        "localDw->flEff = localDw->unknownForward",
        "localDw->frEff = localDw->unknownForward",
        "localDw->slEff = localDw->unknownSide",
        "localDw->srEff = localDw->unknownSide",
        "localDw->directionLock = (MwbDouble)((1))",
        "localDw->directionLock = (MwbDouble)(((-1)))",
        "localDw->directionLock = (MwbDouble)((0))",
        "localDw->candidateTimer >= localDw->directionConfirmTime",
        "*speed = (MwbDouble)((160))",
        "*speed = (MwbDouble)((140))",
        "*speed = (MwbDouble)((130))",
        "*speed = (MwbDouble)((100))",
        "*steer = 0.58",
        "*steer = (-0.58)",
        "*servo = (MwbDouble)((0))",
        "localDw->k = 0.16",
        "localDw->k_b = (-0.16)",
        "localDw->controlStep = 0.05",
        "localDw->backupConfirmTime = 0.1",
        "localDw->backupPreStopTime = 0.2",
        "localDw->backupMinTime = 0.8",
        "localDw->backupMaxTime = 1.2",
        "localDw->backupStraightTime = 0.2",
        "localDw->backupSteerMagnitude = 0.38",
        "localDw->backupSettleTime = 0.15",
        "localDw->backupRelease = (MwbDouble)((12))",
        "localDw->backupSpeedCmd = (MwbDouble)(((-55)))",
        "localDw->escapeFailureTime = 0.45",
        "localDw->escapeFailureTimer = localDw->escapeFailureTimer + localDw->controlStep",
        "localDw->escapeFailureTimer >= localDw->escapeFailureTime",
        "localDw->backupState = (MwbDouble)((1))",
        "localDw->backupState = (MwbDouble)((2))",
        "localDw->backupState = (MwbDouble)((3))",
        "*speed = localDw->backupSpeedCmd",
        "localDw->pocketDistance = (MwbDouble)((11))",
        "localDw->turnEscapeSpeed = (MwbDouble)((45))",
        "localDw->corridorCenterMinimum = (MwbDouble)((18))",
        "localDw->corridorCornerMinimum = (MwbDouble)((12))",
        "localDw->corridorPassAllowed = (MwbDouble)((1))",
        "localDw->corridorPassAllowed = (MwbDouble)((0))",
        "localDw->tightStopDistance = (MwbDouble)((18))",
        "localDw->tightStopRequest = (MwbDouble)((1))",
        "localDw->backupEscapeDirection = (MwbDouble)((1))",
        "localDw->backupEscapeDirection = (MwbDouble)(((-1)))",
        "*steer = -(localDw->backupSteerMagnitude)",
        "*steer = localDw->backupSteerMagnitude",
        "localDw->flEff <= localDw->pocketDistance",
        "localDw->frEff <= localDw->pocketDistance",
        "fc > 0 && fc <= localDw->frontStrong",
        "localDw->leftPathAllowed < 0.5",
        "localDw->rightPathAllowed",
        "localDw->closestFront = fc",
        "localDw->closestFront = localDw->flEff",
        "localDw->closestFront = localDw->frEff",
        "localDw->normalSteer = 0.02 * (localDw->leftScore - localDw->rightScore)",
        "localDw->steeringMagnitude = 0.48",
        "localDw->steeringMagnitude = 0.56",
        "localDw->steeringMagnitude = 0.58",
    ):
        require(model_source, token, f"pure-MWORKS control evidence missing: {token}")

    for token in (
        "backupNeeded",
        "scanReady",
        "fu_disl",
        "fu_disr",
        "*servo = 0.55",
        "*servo = (-0.55)",
        "localDw->wedgeSide",
        "localDw->wedgeTimer",
        "localDw->sceneRefFC",
    ):
        reject(model_source, token, f"obsolete scan/reverse behaviour detected: {token}")

    # 禁止重新引入手写 C 控制器；extern_inc 只允许官方硬件接口。
    for token in ("Team27_ControllerStep", "team27_state", "scannerOut"):
        reject(all_generated, token, f"handwritten C controller detected: {token}")

    # M.GenerateModelCode把SourceFile放进extern_inc；ExternalMode则把它复制
    # 到部署根目录。两种目录形态都只允许存在一份官方JGB520实现。
    if resource.get("SourceFile") != ["JGB520.c"]:
        raise RuntimeError("official JGB520.c must be the only SourceFile")
    if "JGB520.h" not in resource.get("IncludeFile", []):
        raise RuntimeError("official JGB520.h must remain an IncludeFile")
    require(extern_include_source, '#include "JGB520.h"',
            "official JGB520 header is not routed into generated code")
    reject(extern_include_source, "MWORKS_JGB520_LinkCompat.h",
           "obsolete motor-symbol compatibility header is still active")
    embedded_jgb_count = extern_source.count('#include "JGB520.c"')
    copied_jgb_count = int((directory / "JGB520.c").is_file())
    if embedded_jgb_count + copied_jgb_count != 1:
        raise RuntimeError(
            "exactly one official JGB520 implementation is required; "
            f"embedded={embedded_jgb_count}, copied={copied_jgb_count}"
        )
    reject(model_source, "team27_motor_send(",
           "model must call the official motor_send_cmd symbol")
    if model_source.count("motor_send_cmd(") < 4:
        raise RuntimeError("official motor_send_cmd calls are missing")

    # 只导出顶层根输出，避开2026a对已展平子系统生成无效CAPI地址的问题。
    reject(capi_source, ".ObsAvoidController_Team27_MWorks",
           "invalid nested-controller CAPI reference detected")
    for token in (
        "front_center_dist_out", "front_right_dist_out", "side_right_dist_out",
        "side_left_dist_out", "front_left_dist_out", "speed_cmd_out",
        "steer_cmd_out", "fixed_servo_cmd_out",
    ):
        require(capi_source, token, f"root CAPI monitor missing: {token}")

    require(extern_source, "*sensor2_distence=getDistance(Echo2)",
            "rotating ultrasonic sensor is not routed by the official interface")
    require(model_source, "front_sensor_cmd", "scanner servo output is not generated")
    # The two motor-stop commands are part of the official model's Terminate.
    # Do not inject extra steering/scanner/serial-close C code here.
    for token in ("motor_send_cmd(2, 0, 0)", "motor_send_cmd(1, 0, 0)"):
        require(model_source, token, f"official Terminate evidence missing: {token}")
    for token in ("steer_cmd(0.0)", "front_sensor_cmd(0.0)", "serialClose(fd)"):
        reject(model_source, token, f"non-official Terminate code detected: {token}")

    print("OK: V3.8 low-speed full-lock escape, tight-stop reverse and counter-steered backup verified; no handwritten C controller")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        sys.exit(1)
