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


def ensure_session(port=None):
    if port is not None:
        M.ConnectSysplorer(port=port)
        return
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
    parser.add_argument("--port", type=int)
    args = parser.parse_args()

    ensure_session(args.port)
    package_path = os.path.join(os.path.dirname(os.path.abspath(args.vehicle)), "package.mo")
    if not os.path.isfile(package_path):
        raise RuntimeError(f"library package file was not found: {package_path}")
    # Load the complete library so Controller is resolved as a real subpackage.
    # Opening the controller file alone makes it a temporary global class and
    # causes the graphical top model to show a red missing-component cross.
    if not M.OpenModelFile(package_path, autoReload=True):
        raise RuntimeError(f"failed to load complete model library: {package_path}")

    model = next((name for name in MODEL_CANDIDATES if M.ClassExist(name)), None)
    if model is None:
        raise RuntimeError("Team27 JGB520 deployment model was not found")
    if not M.CheckModel(model):
        raise RuntimeError(f"model check failed: {model}")

    output = os.path.abspath(args.output).replace("\\", "/")
    os.makedirs(output, exist_ok=True)
    with contextlib.redirect_stdout(io.StringIO()):
        options = M.GetModelCodeGenerationOptions(model)
    configured_output = os.path.abspath(
        options["CodePlatform.OutPath"]["output"]
    ).replace("\\", "/")
    if configured_output.casefold() != output.casefold():
        raise RuntimeError(
            "requested output does not match the fixed model output; "
            f"requested={output}, configured={configured_output}"
        )
    # Do not call SetModelCodeGenerationOptions here. Sysplorer 2026a omits
    # ExternalMode/CAPI fields from GetModelCodeGenerationOptions, so writing
    # that partial dictionary back silently deletes the CAPI configuration.
    if not M.GenerateModelCode(model):
        raise RuntimeError("Sysplorer code generation failed")
    print(f"OK: {model} -> {output}")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        sys.exit(1)
