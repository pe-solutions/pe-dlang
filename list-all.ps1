#Requires -Version 5.1
<#
.SYNOPSIS
    Run all Project Euler solutions (release mode) and print a summary table.
.DESCRIPTION
    Runs every pe-XXXX package with --build=release and parses each solution's
    stdout into three columns: Project, Answer, and Elapsed time.
.EXAMPLE
    .\list-all.ps1
#>

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

Write-Host ("Running {0} solutions (release mode) ..." -f $total)
Write-Host ""

$rows       = [System.Collections.Generic.List[PSCustomObject]]::new()
$failed     = [System.Collections.Generic.List[string]]::new()
$timer      = [System.Diagnostics.Stopwatch]::StartNew()

foreach ($dir in $dirs) {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName               = 'dub'
    $psi.Arguments              = 'run --build=release'
    $psi.WorkingDirectory       = $dir.FullName
    $psi.UseShellExecute        = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError  = $true
    $psi.CreateNoWindow         = $true

    $proc       = [System.Diagnostics.Process]::Start($psi)
    $stdoutTask = $proc.StandardOutput.ReadToEndAsync()
    $stderrTask = $proc.StandardError.ReadToEndAsync()
    $proc.WaitForExit()
    $stdout = $stdoutTask.Result

    if ($proc.ExitCode -ne 0) {
        $failed.Add($dir.Name)
        $rows.Add([PSCustomObject]@{
            'Project Euler Problem' = $dir.Name
            Answer                 = 'FAILED'
            'Elapsed time'         = '-'
        })
        continue
    }

    $project = $dir.Name
    $answer  = '-'
    $elapsed = '-'

    foreach ($line in ($stdout -split "`n")) {
        $line = $line.Trim()
        if ($line -match '^Project Euler (#\d+)')         { $project = $Matches[1] }
        elseif ($line -match '^Answer:\s*(.+)')           { $answer  = $Matches[1] }
        elseif ($line -match '^Elapsed time:\s*(.+)\.$') { $elapsed = $Matches[1] }
        elseif ($line -match '^Elapsed time:\s*(.+)')    { $elapsed = $Matches[1] }
    }

    $rows.Add([PSCustomObject]@{
        'Project Euler Problem' = $project
        Answer                 = $answer
        'Elapsed time'         = $elapsed
    })
}

$timer.Stop()
$totalSec = [math]::Round($timer.Elapsed.TotalSeconds, 1)

$rows | Format-Table -AutoSize

$summaryColor = if ($failed.Count -eq 0) { 'Green' } else { 'Yellow' }
Write-Host ("Completed {0}/{1} solutions in {2}s" -f ($total - $failed.Count), $total, $totalSec) -ForegroundColor $summaryColor

if ($failed.Count -gt 0) {
    Write-Host ("Failed ({0}):" -f $failed.Count) -ForegroundColor Red
    foreach ($n in $failed) {
        Write-Host ("  - {0}" -f $n) -ForegroundColor Red
    }
    exit 1
}
