# build-cursorignore updater for Windows
# Usage: irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/update.ps1 | iex

$ErrorActionPreference = "Stop"

$SKILL_NAME = "build-cursorignore"
$CURSOR_SKILLS_DIR = "$env:USERPROFILE\.cursor\skills"
$INSTALL_DIR = "$CURSOR_SKILLS_DIR\$SKILL_NAME"

Write-Host "Updating $SKILL_NAME..." -ForegroundColor Cyan

# Check if installed
if (-not (Test-Path $INSTALL_DIR)) {
    Write-Host "[ERROR] $SKILL_NAME is not installed. Run install first." -ForegroundColor Red
    exit 1
}

# Check if it's a git repo
if (-not (Test-Path "$INSTALL_DIR\.git")) {
    Write-Host "[ERROR] Not a git repository. Reinstall with:" -ForegroundColor Red
    Write-Host "irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.ps1 | iex" -ForegroundColor Yellow
    exit 1
}

# Pull latest changes
Write-Host "Pulling latest changes..." -ForegroundColor Cyan
$prevEAP = $ErrorActionPreference
$ErrorActionPreference = "SilentlyContinue"
$gitOutput = & git -C $INSTALL_DIR pull --quiet 2>&1
$ErrorActionPreference = $prevEAP

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n[OK] Update successful!" -ForegroundColor Green
    Write-Host "Restart Cursor to use the latest version." -ForegroundColor Cyan
} else {
    Write-Host "`n[ERROR] Update failed. Try reinstalling:" -ForegroundColor Red
    Write-Host "irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.ps1 | iex" -ForegroundColor Yellow
}
