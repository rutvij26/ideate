$Target = Join-Path $env:USERPROFILE ".claude\skills\ideate"
$Repo   = "https://github.com/rutvij26/ideate"
$Branch = "main"

# ── Update path ────────────────────────────────────────────────────────────────
if (Test-Path (Join-Path $Target ".git")) {
    Write-Host "/ideate is already installed at $Target"
    $answer = Read-Host "Update to latest? [Y/n]"
    if ($answer -match '^[nN]$') {
        Write-Host "No changes made."
        exit 0
    }
    Push-Location $Target
    git pull --ff-only
    Pop-Location
    Write-Host "Updated. Restart Claude Code to pick up changes."
    exit 0
}

# ── Fresh install ───────────────────────────────────────────────────────────────
if (Test-Path $Target) {
    $answer = Read-Host "$Target already exists. Overwrite? [y/N]"
    if ($answer -notmatch '^[yY]$') {
        Write-Host "Install cancelled."
        exit 0
    }
    Remove-Item -Recurse -Force $Target
}

if (Get-Command git -ErrorAction SilentlyContinue) {
    git clone --depth=1 --branch $Branch $Repo $Target
} else {
    Write-Host "git not found — downloading zip instead..."
    $tmp = Join-Path $env:TEMP "ideate-install-$(Get-Random)"
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null
    Invoke-WebRequest "$Repo/archive/refs/heads/$Branch.zip" -OutFile "$tmp\ideate.zip"
    Expand-Archive "$tmp\ideate.zip" -DestinationPath $tmp -Force
    Move-Item "$tmp\ideate-$Branch" $Target
    Remove-Item -Recurse -Force $tmp
}

Write-Host ""
Write-Host "Done. Restart Claude Code and run /ideate to get started."
