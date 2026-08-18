$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot '..\config.ps1')

if (-not (Test-Path -LiteralPath $SysplorerPython)) {
    throw "Sysplorer Python was not found: $SysplorerPython"
}

$oneClickRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$generatedRoot = Join-Path $oneClickRoot 'generated'
$controller = Join-Path $LibraryRoot 'Controller\ObsAvoidController_Team27_FFLFRR.mo'
$vehicle = Join-Path $LibraryRoot 'for_code_JGB520_Team27.mo'

New-Item -ItemType Directory -Path $generatedRoot -Force | Out-Null
$generatedRootFull = [IO.Path]::GetFullPath($generatedRoot).TrimEnd('\')
Get-ChildItem -LiteralPath $generatedRootFull -Directory |
    Where-Object Name -Match '^Unmanned_Vehicle_Race_2026\.for_code_JGB520_Team27(-[0-9]+)?$' |
    ForEach-Object {
        $candidate = [IO.Path]::GetFullPath($_.FullName)
        if (-not $candidate.StartsWith($generatedRootFull + '\', [StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to remove unexpected path: $candidate"
        }
        Remove-Item -LiteralPath $candidate -Recurse -Force
    }

Write-Host '1/3 Checking model and generating JGB520 code...' -ForegroundColor Cyan
& $SysplorerPython (Join-Path $PSScriptRoot 'sysplorer_codegen.py') `
    --controller $controller --vehicle $vehicle --output $generatedRoot
if ($LASTEXITCODE -ne 0) { throw "Code generation failed with exit code $LASTEXITCODE" }

$generatedDir = Get-ChildItem -LiteralPath $generatedRoot -Directory |
    Where-Object Name -Like '*for_code_JGB520_Team27*' |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1
if (-not $generatedDir) { throw 'Generated JGB520 directory was not found.' }

& $SysplorerPython (Join-Path $PSScriptRoot 'postprocess_generated.py') --directory $generatedDir.FullName
if ($LASTEXITCODE -ne 0) { throw "Generated-code post-processing failed with exit code $LASTEXITCODE" }

Copy-Item -LiteralPath (Join-Path $LibraryRoot 'Raspberry_Pi_Interface\Source\JGB520.c') -Destination $generatedDir.FullName -Force
Copy-Item -LiteralPath (Join-Path $LibraryRoot 'Raspberry_Pi_Interface\Source\JGB520.h') -Destination $generatedDir.FullName -Force
Copy-Item -LiteralPath (Join-Path $oneClickRoot 'runtime\team27_main.c') -Destination $generatedDir.FullName -Force
Copy-Item -LiteralPath (Join-Path $oneClickRoot 'runtime\Makefile') -Destination $generatedDir.FullName -Force
Write-Host "2/3 Deployable sources are ready: $($generatedDir.FullName)" -ForegroundColor Green

if (-not $EnableRemoteRun) {
    Write-Host 'SAFETY LOCK: code was generated, but motors were not started.' -ForegroundColor Yellow
    Write-Host 'Set PiHost and EnableRemoteRun=$true in config.ps1 only after lifting the drive wheels.'
    exit 0
}

if ($PiHost -eq 'CHANGE_ME' -or $PiHost -notmatch '^[A-Za-z0-9.-]+$') { throw 'Set a valid PiHost in config.ps1.' }
if ($PiUser -notmatch '^[A-Za-z0-9_-]+$') { throw 'PiUser is invalid.' }
if ($RemoteDir -notmatch '^/[A-Za-z0-9_./-]+$') { throw 'RemoteDir is invalid.' }
if (-not (Get-Command ssh -ErrorAction SilentlyContinue)) { throw 'OpenSSH ssh client is unavailable.' }
if (-not (Get-Command scp -ErrorAction SilentlyContinue)) { throw 'OpenSSH scp client is unavailable.' }

$target = "$PiUser@$PiHost"
Write-Host "3/3 Uploading, compiling, and starting on $target ..." -ForegroundColor Cyan
& ssh -p $PiPort $target "mkdir -p '$RemoteDir'"
if ($LASTEXITCODE -ne 0) { throw 'SSH connection or remote mkdir failed.' }
& scp -P $PiPort -r (Join-Path $generatedDir.FullName '.') "${target}:$RemoteDir"
if ($LASTEXITCODE -ne 0) { throw 'SCP upload failed.' }

Write-Host 'Starting the car in foreground. Ctrl+C requests a two-motor stop.' -ForegroundColor Yellow
& ssh -t -p $PiPort $target "cd '$RemoteDir' && make clean && make && sudo ./team27_car"
if ($LASTEXITCODE -ne 0) { throw "Remote build or run failed with exit code $LASTEXITCODE" }
