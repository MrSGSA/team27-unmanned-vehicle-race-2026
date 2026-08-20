$ErrorActionPreference = 'Stop'
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[Console]::InputEncoding = $utf8NoBom
[Console]::OutputEncoding = $utf8NoBom
$OutputEncoding = $utf8NoBom
$env:PYTHONIOENCODING = 'utf-8'
. (Join-Path $PSScriptRoot '..\config.ps1')

if (-not (Test-Path -LiteralPath $SysplorerPython)) {
    throw "Sysplorer Python was not found: $SysplorerPython"
}

$oneClickRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$generatedRoot = Join-Path $oneClickRoot 'generated'
$controller = Join-Path $LibraryRoot 'Controller\ObsAvoidController_Team27_MWorks.mo'
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

Write-Host '1/3 Checking model and generating JGB520 code for local audit...' -ForegroundColor Cyan
& $SysplorerPython (Join-Path $PSScriptRoot 'sysplorer_codegen.py') `
    --controller $controller --vehicle $vehicle --output $generatedRoot
if ($LASTEXITCODE -ne 0) { throw "Code generation failed with exit code $LASTEXITCODE" }
[Console]::OutputEncoding = $utf8NoBom
$OutputEncoding = $utf8NoBom

$generatedDir = Get-ChildItem -LiteralPath $generatedRoot -Directory |
    Where-Object Name -Like '*for_code_JGB520_Team27*' |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1
if (-not $generatedDir) { throw 'Generated JGB520 directory was not found.' }

& $SysplorerPython (Join-Path $PSScriptRoot 'postprocess_generated.py') --directory $generatedDir.FullName
if ($LASTEXITCODE -ne 0) { throw "Generated-code post-processing failed with exit code $LASTEXITCODE" }

Write-Host "2/3 MWORKS-generated sources passed the read-only audit: $($generatedDir.FullName)" -ForegroundColor Green
& (Join-Path $oneClickRoot 'tests\run_controller_tests.ps1') -GeneratedRoot $generatedRoot
if ($LASTEXITCODE -ne 0) { throw "Controller regression failed with exit code $LASTEXITCODE" }
Write-Host '3/3 All 19 V3 fixed-ultrasonic generated-code scenarios passed.' -ForegroundColor Green
Write-Host 'COMPETITION LOCK: local audit is complete. Download only with the official MWORKS ExternalMode tool.' -ForegroundColor Yellow
