@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\run_simulation.ps1"
if errorlevel 1 pause
