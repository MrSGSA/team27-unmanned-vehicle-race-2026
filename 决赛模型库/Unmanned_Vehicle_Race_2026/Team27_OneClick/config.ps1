$SysplorerPython = 'E:\MWorks\Sysplorer 2026a\External\python64\python.exe'
$LibraryRoot = Split-Path -Parent $PSScriptRoot
$CompetitionRoot = Split-Path -Parent (Split-Path -Parent $LibraryRoot)
$SimulationPackage = Join-Path $LibraryRoot 'Team27_Simulation\FinalRace2026\package.mo'
$SimulationModel = 'FinalRace2026.Track1FourSensor'
$SimulationStopTime = 90.0

$PiHost = 'CHANGE_ME'
$PiPort = 22
$PiUser = 'pi'
$RemoteDir = '/home/pi/team27_car'
$EnableRemoteRun = $false
