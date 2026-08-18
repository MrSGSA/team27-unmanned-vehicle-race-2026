import argparse
import glob
import os
import sys
import time

import mworks.sysplorer as M


def ensure_session():
    ports = M.FindSysplorer()
    if ports:
        M.ConnectSysplorer(port=ports[-1])
        return
    M.StartSysplorer()
    for _ in range(40):
        ports = M.FindSysplorer()
        if ports:
            M.ConnectSysplorer(port=ports[-1])
            return
        time.sleep(0.25)
    raise RuntimeError("Sysplorer startup timed out")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--competition-root", required=True)
    parser.add_argument("--package", required=True)
    parser.add_argument("--model", required=True)
    parser.add_argument("--stop-time", type=float, default=120.0)
    args = parser.parse_args()

    ugv_matches = glob.glob(
        os.path.join(args.competition_root, "初赛", "**", "UGV", "package.mo"),
        recursive=True,
    )
    if len(ugv_matches) != 1:
        raise RuntimeError(f"expected one UGV/package.mo; found {len(ugv_matches)}")

    print("[1/4] connecting to Sysplorer", flush=True)
    ensure_session()
    print("[2/4] loading UGV and FinalRace2026", flush=True)
    for path in (ugv_matches[0], args.package):
        if not M.OpenModelFile(path, autoReload=True):
            raise RuntimeError(f"failed to load model file: {path}")
    print(f"[3/4] checking {args.model}", flush=True)
    if not M.CheckModel(args.model):
        raise RuntimeError(f"model check failed: {args.model}")
    M.OpenModel(args.model)
    print(f"[4/4] simulating 0..{args.stop_time:.1f} s", flush=True)
    if not M.SimulateModel(
        args.model, startTime=0.0, stopTime=args.stop_time,
        interval=0.05, simMode=1
    ):
        raise RuntimeError(f"simulation failed: {args.model}")
    if args.stop_time >= 77.0:
        mode = M.GetVarValueAt("obsAvoidController_Sysblock2_1.mode", 77.0)
        left_obstacle = M.GetVarValueAt("fourRaySensor.front_left_obstacle_dist", 77.0)
        road_collision = M.GetVarValueAt("cR", args.stop_time)
        obstacle_collision = M.GetVarValueAt("cO", args.stop_time)
        if mode not in (1.0, 2.0, 3.0, 4.0):
            raise RuntimeError(f"active avoidance was not entered at 77 s; mode={mode}")
        if road_collision != 0.0 or obstacle_collision != 0.0:
            raise RuntimeError(f"collision counters: road={road_collision}, obstacle={obstacle_collision}")
        print(
            f"VERIFY: t=77 s mode={mode:.0f}, left obstacle={left_obstacle:.3f} m; "
            f"collision counters=0/0",
            flush=True,
        )
    print(f"OK: {args.model} simulated through {args.stop_time:.1f} s")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        sys.exit(1)
