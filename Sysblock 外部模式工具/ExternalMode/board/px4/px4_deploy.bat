@ECHO OFF

rem %1参数：px4目录、当前含有home、toolchain 目录 E:\Temp\Project\Px4
rem %2参数: 编译后是否上传

CD "%1"
PUSHD "%1"
CALL toolchain\scripts\setup-environment.bat x
POPD

IF NOT EXIST %~nx0 (
	SET PREVIOUS_PWD=%CD%
)

IF "%2" == "make_upload" (	
	CALL bash -l -i -c "cd ./Firmware && make px4_fmu-v5 upload
) ELSE (
	CALL bash -l -i -c "cd ./Firmware && make px4_fmu-v5
)

if %errorlevel% neq 0 (
	exit /B 1
) ELSE (
	exit /B 0
)

