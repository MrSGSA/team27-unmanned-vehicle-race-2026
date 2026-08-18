$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..\config.ps1')

if (-not (Test-Path -LiteralPath $SysplorerPython)) {
    throw "Sysplorer Python was not found: $SysplorerPython"
}

Write-Host 'Loading libraries and running Team 27 simulation...' -ForegroundColor Cyan
& $SysplorerPython (Join-Path $PSScriptRoot 'sysplorer_sim.py') `
    --competition-root $CompetitionRoot `
    --package $SimulationPackage `
    --model $SimulationModel `
    --stop-time $SimulationStopTime
if ($LASTEXITCODE -ne 0) { throw "Simulation failed with exit code $LASTEXITCODE" }
Write-Host 'Simulation completed. The model and results remain open in Sysplorer.' -ForegroundColor Green

