import argparse
import pathlib
import re
import sys


SAFE_TERMINATE = """void steer_cmd(double steer);

void Terminate()
{
  motor_send_cmd(2, 0, 0);
  motor_send_cmd(1, 0, 0);
  steer_cmd(0.0);
  if (fd >= 0) serialClose(fd);
}

void Step"""


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    directory = pathlib.Path(args.directory)
    model_c = directory / "for_code_JGB520_Team27.c"
    sensor_c = directory / "extern_inc" / "momodel_extern_ince2.c"
    controller_c = directory / "extern_inc" / "momodel_extern_ince1.c"

    for path in (model_c, sensor_c, controller_c):
        if not path.is_file():
            raise RuntimeError(f"missing generated file: {path}")
    sensor_source = sensor_c.read_text(encoding="utf-8")
    if "*sensor2_distence=300.0;" not in sensor_source:
        raise RuntimeError("generated code does not contain the four-sensor Echo2 bypass")
    if "Team27_ControllerStep" not in controller_c.read_text(encoding="utf-8"):
        raise RuntimeError("generated code does not contain the Team27 controller")

    source = model_c.read_text(encoding="utf-8")
    updated, count = re.subn(
        r"(?:void steer_cmd\(double steer\);\s*)?void Terminate\(\)\s*\{.*?\}\s*\n\s*void Step",
        SAFE_TERMINATE,
        source,
        count=1,
        flags=re.DOTALL,
    )
    if count != 1:
        raise RuntimeError("could not install the safe Terminate routine")
    model_c.write_text(updated, encoding="utf-8", newline="\n")
    sensor_c.write_text(
        sensor_source.replace('printf("speed = %d\\n ",speed);',
                              'printf("speed = %f\\n ",speed);'),
        encoding="utf-8",
        newline="\n",
    )
    print("OK: generated controller and sensor mapping verified; safe stop installed")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        sys.exit(1)
