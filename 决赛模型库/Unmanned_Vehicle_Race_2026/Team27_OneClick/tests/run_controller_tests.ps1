param(
    [string]$GeneratedRoot = ''
)

$ErrorActionPreference = 'Stop'

$oneClickRoot = Split-Path -Parent $PSScriptRoot
$formalGeneratedRoot = Join-Path $oneClickRoot 'generated'
$generatedRoot = if ($GeneratedRoot) {
    $GeneratedRoot
} else {
    $formalGeneratedRoot
}
$directDirectory = Get-Item -LiteralPath $generatedRoot -ErrorAction SilentlyContinue
$directComplete = $directDirectory -and $directDirectory.PSIsContainer -and
    (Test-Path -LiteralPath (Join-Path $directDirectory.FullName 'for_code_JGB520_Team27.c')) -and
    (Test-Path -LiteralPath (Join-Path $directDirectory.FullName 'for_code_JGB520_Team27_capi.c')) -and
    (Test-Path -LiteralPath (Join-Path $directDirectory.FullName 'for_code_JGB520_Team27_data.c'))
$generatedDir = if ($directComplete) {
    $directDirectory
} else {
    Get-ChildItem -LiteralPath $generatedRoot -Directory |
        Where-Object Name -Like '*for_code_JGB520_Team27*' |
        Where-Object {
            (Test-Path -LiteralPath (Join-Path $_.FullName 'for_code_JGB520_Team27.c')) -and
            (Test-Path -LiteralPath (Join-Path $_.FullName 'for_code_JGB520_Team27_capi.c')) -and
            (Test-Path -LiteralPath (Join-Path $_.FullName 'for_code_JGB520_Team27_data.c'))
        } |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1
}
if (-not $generatedDir) { throw "No complete generated model directory was found under: $generatedRoot" }
if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) { throw 'gcc was not found.' }

$buildDir = Join-Path ([IO.Path]::GetTempPath()) 'team27_controller_tests'
New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
$exe = Join-Path $buildDir 'controller_harness.exe'
$stubs = Join-Path $oneClickRoot 'runtime\test_stubs'
$hardwareHeaders = Join-Path (Split-Path -Parent $oneClickRoot) 'Raspberry_Pi_Interface\Source'

& gcc -std=gnu99 -O0 -Wall -Wextra -Wno-unused-parameter -Wno-sign-compare -Wno-parentheses `
    "-I$stubs" "-I$($generatedDir.FullName)" "-I$hardwareHeaders" `
    (Join-Path $PSScriptRoot 'controller_harness.c') `
    (Join-Path $generatedDir.FullName 'for_code_JGB520_Team27.c') `
    (Join-Path $generatedDir.FullName 'for_code_JGB520_Team27_capi.c') `
    (Join-Path $generatedDir.FullName 'for_code_JGB520_Team27_data.c') `
    -lm -o $exe
if ($LASTEXITCODE -ne 0) { throw "controller harness compile failed: $LASTEXITCODE" }

foreach ($scenario in 'clear', 'outside_warning', 'cw_tie',
    'left_open', 'right_open', 'dis2_fr', 'dis5_fl', 'dis4_sl',
    'dis3_sr', 'early_diagonal', 'deadband', 'raw_stop', 'backup',
    'backup_once', 'backup_release', 'backup_right_arc', 'backup_left_arc',
    'tight_stop_backup', 'narrow_ray', 'invalid_ray',
    'corner_turnaway', 'persistent_corner', 'transient_corner',
    'release', 'path_veto', 'static_single', 'moving_bend',
    'narrow', 'parallel_corridor', 'front_dropout', 'centre_one_side', 'blocked_paths', 'corner_tier', 'steer_slew',
    'speed_tiers') {
    & $exe $scenario
    if ($LASTEXITCODE -ne 0) { throw "controller scenario failed: $scenario" }
}
Write-Host 'OK: all 35 V3.8 fixed-ultrasonic/Ackermann controller scenarios passed.' -ForegroundColor Green
