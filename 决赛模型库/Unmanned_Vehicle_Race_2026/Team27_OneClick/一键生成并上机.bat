@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\deploy_realcar.ps1"
if errorlevel 1 pause
