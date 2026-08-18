@echo OFF
cd /d "%~dp0"
SET BUILD_LOG=Compiler.log
SET BUILD_PRO=../OBJ/NewProject.hex
"%1/UV4/UV4.exe" -b ../PWM.uvprojx -j0 -o %BUILD_LOG% -q

CD ..
TYPE %BUILD_LOG%
IF NOT EXIST %BUILD_PRO% (
    EXIT /B 1
)

"../isp_tool.exe" COM4 %BUILD_PRO%
IF %ERRORLEVEL% NEQ 0 (
    EXIT /B 1
)
EXIT /B 0