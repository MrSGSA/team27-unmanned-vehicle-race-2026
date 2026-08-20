$SysplorerPython = 'D:\MWorks\Sysplorer 2026a\External\python64\python.exe'
$LibraryRoot = Split-Path -Parent $PSScriptRoot
$CompetitionRoot = Split-Path -Parent (Split-Path -Parent $LibraryRoot)
$SimulationPackage = Join-Path $LibraryRoot 'Team27_Simulation\FinalRace2026\package.mo'
$SimulationModel = 'FinalRace2026.Track1FourSensor'
$SimulationStopTime = 90.0
