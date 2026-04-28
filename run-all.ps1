#Requires -Version 5.1
<#
.SYNOPSIS
    Run all Project Euler solutions.
.PARAMETER Release
    Run in release mode (dub run --build=release).
.PARAMETER ShowOutput
    Also print dub's own build messages (stderr) on success, not only on failure.
.EXAMPLE
    .\run-all.ps1
    .\run-all.ps1 -Release
    .\run-all.ps1 -ShowOutput
#>
param(
    [switch]$Release,
    [switch]$ShowOutput
)

$ErrorActionPreference = 'Continue'

$rootDir = $PSScriptRoot
$dirs = Get-ChildItem -Path $rootDir -Directory -Filter 'pe-*' |
        Where-Object { $_.Name -match '^pe-\d{4}$' } |
        Sort-Object Name

$total = $dirs.Count

if ($total -eq 0) {
    Write-Host "No pe-XXXX directories found under $rootDir." -ForegroundColor Yellow
    exit 1
}

$mode    = if ($Release) { 'release' } else { 'debug' }
$dubArgs = if ($Release) { 'run --build=release' } else { 'run' }

$passed     = 0
$failed     = 0
$failedList = [System.Collections.Generic.List[string]]::new()
$timer      = [System.Diagnostics.Stopwatch]::StartNew()

Write-Host ("Running {0} solutions ({1} mode)" -f $total, $mode)
Write-Host ""

foreach ($dir in $dirs) {
    $name = $dir.Name
    Write-Host ("  {0}" -f $name) -ForegroundColor Cyan

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName         = 'dub'
    $psi.Arguments        = $dubArgs
    $psi.WorkingDirectory = $dir.FullName
    $psi.UseShellExecute  = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError  = $true
    $psi.CreateNoWindow   = $true

    $proc       = [System.Diagnostics.Process]::Start($psi)
    $stdoutTask = $proc.StandardOutput.ReadToEndAsync()
    $stderrTask = $proc.StandardError.ReadToEndAsync()
    $proc.WaitForExit()
    $stdout = $stdoutTask.Result
    $stderr = $stderrTask.Result

    $ok = ($proc.ExitCode -eq 0)

    # Always show solution output (stdout is the answer).
    if ($stdout) { $stdout.TrimEnd() -split "`n" | ForEach-Object { Write-Host "    $_" } }

    if ($ok) {
        $passed++
    } else {
        Write-Host "    FAILED" -ForegroundColor Red
        $failed++
        $failedList.Add($name)
    }

    # Show dub's own messages (stderr) on failure always, on success only if -ShowOutput.
    if ($ShowOutput -or -not $ok) {
        $color = if ($ok) { 'DarkGray' } else { 'Red' }
        if ($stderr) { $stderr.TrimEnd() -split "`n" | ForEach-Object { Write-Host "    $_" -ForegroundColor $color } }
    }
}

$timer.Stop()
$elapsed = [math]::Round($timer.Elapsed.TotalSeconds, 1)

Write-Host ""
$summaryColor = if ($failed -eq 0) { 'Green' } else { 'Yellow' }
Write-Host ("Passed: {0}/{1}  ({2}s)" -f $passed, $total, $elapsed) -ForegroundColor $summaryColor

if ($failed -gt 0) {
    Write-Host ("Failed ({0}):" -f $failed) -ForegroundColor Red
    foreach ($n in $failedList) {
        Write-Host ("  - {0}" -f $n) -ForegroundColor Red
    }
    exit 1
}
