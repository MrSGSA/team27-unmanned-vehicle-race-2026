import argparse
import contextlib
import io
import os
import sys
import time

import mworks.sysplorer as M


MODEL_CANDIDATES = (
    "Unmanned_Vehicle_Race_2026.for_code_JGB520_Team27",
    "for_code_JGB520_Team27",
)


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
    parser.add_argument("--controller", required=True)
    parser.add_argument("--vehicle", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()

    ensure_session()
    for path in (args.controller, args.vehicle):
        if not M.OpenModelFile(path, autoReload=True):
            raise RuntimeError(f"failed to load model file: {path}")

    model = next((name for name in MODEL_CANDIDATES if M.ClassExist(name)), None)
    if model is None:
        raise RuntimeError("Team27 JGB520 deployment model was not found")
    if not M.CheckModel(model):
        raise RuntimeError(f"model check failed: {model}")

    output = os.path.abspath(args.output).replace("\\", "/")
    os.makedirs(output, exist_ok=True)
    with contextlib.redirect_stdout(io.StringIO()):
        options = M.GetModelCodeGenerationOptions(model)
    options["CodePlatform.OutPath"]["output"] = output
    options["CodeCustom.InsertSectionGlobalVariableDefine"]["tail"] = (
        "void Terminate()\n{\n"
        "  motor_send_cmd(2, 0, 0);\n"
        "  motor_send_cmd(1, 0, 0);\n"
        "  steer_cmd(0.0);\n"
        "  if (fd >= 0) serialClose(fd);\n"
        "}\n"
    )
    if not M.SetModelCodeGenerationOptions(model, options):
        raise RuntimeError("failed to apply code-generation options")
    if not M.GenerateModelCode(model):
        raise RuntimeError("Sysplorer code generation failed")
    print(f"OK: {model} -> {output}")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        sys.exit(1)
