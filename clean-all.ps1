#Requires -Version 5.1
<#
.SYNOPSIS
    Clean all Project Euler solutions.
.PARAMETER ShowOutput
    Print dub output for every solution, not only on failure.
.EXAMPLE
    .\clean-all.ps1
    .\clean-all.ps1 -ShowOutput
#>
param(
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

$passed     = 0
$failed     = 0
$failedList = [System.Collections.Generic.List[string]]::new()
$timer      = [System.Diagnostics.Stopwatch]::StartNew()

Write-Host ("Cleaning {0} solutions" -f $total)
Write-Host ""

foreach ($dir in $dirs) {
    $name = $dir.Name
    Write-Host -NoNewline ("  {0} ... " -f $name)

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName         = 'dub'
    $psi.Arguments        = 'clean'
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

    if ($ok) {
        Write-Host 'OK' -ForegroundColor Green
        $passed++
    } else {
        Write-Host 'FAILED' -ForegroundColor Red
        $failed++
        $failedList.Add($name)
    }

    if ($ShowOutput -or -not $ok) {
        $color = if ($ok) { 'DarkGray' } else { 'Red' }
        if ($stdout) { $stdout.TrimEnd() -split "`n" | ForEach-Object { Write-Host "      $_" -ForegroundColor $color } }
        if ($stderr) { $stderr.TrimEnd() -split "`n" | ForEach-Object { Write-Host "      $_" -ForegroundColor $color } }
    }
}

$timer.Stop()
$elapsed = [math]::Round($timer.Elapsed.TotalSeconds, 1)

Write-Host ""
$summaryColor = if ($failed -eq 0) { 'Green' } else { 'Yellow' }
Write-Host ("Cleaned: {0}/{1}  ({2}s)" -f $passed, $total, $elapsed) -ForegroundColor $summaryColor

if ($failed -gt 0) {
    Write-Host ("Failed ({0}):" -f $failed) -ForegroundColor Red
    foreach ($n in $failedList) {
        Write-Host ("  - {0}" -f $n) -ForegroundColor Red
    }
    exit 1
}
