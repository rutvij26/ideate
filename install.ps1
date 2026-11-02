$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TargetDir = Join-Path $env:USERPROFILE ".claude\skills\ideate"

Write-Host "/ideate install"
Write-Host "Source: $RepoDir"
Write-Host "Target: $TargetDir"

if (Test-Path $TargetDir) {
    $answer = Read-Host "$TargetDir already exists. Overwrite? [y/N]"
    if ($answer -notmatch '^[yY]$') {
        Write-Host "Install cancelled."
        exit 0
    }
    Remove-Item -Recurse -Force $TargetDir
}

# Try symlink first (requires admin or Developer Mode on Windows)
try {
    New-Item -ItemType Junction -Path $TargetDir -Target $RepoDir | Out-Null
    Write-Host "Done (junction link). Restart Claude Code and run /ideate."
} catch {
    # Fall back to copy
    Copy-Item -Recurse $RepoDir $TargetDir
    Write-Host "Done (copy). Note: updates to the repo will not auto-sync. Re-run install.ps1 to update."
    Write-Host "Restart Claude Code and run /ideate."
}
