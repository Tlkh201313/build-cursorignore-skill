# build-cursorignore uninstaller for Windows
# Usage: irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/main/scripts/uninstall.ps1 | iex

$ErrorActionPreference = "Stop"

$SKILL_NAME = "build-cursorignore"
$CURSOR_SKILLS_DIR = "$env:USERPROFILE\.cursor\skills"
$INSTALL_DIR = "$CURSOR_SKILLS_DIR\$SKILL_NAME"

Write-Host "Uninstalling $SKILL_NAME..." -ForegroundColor Cyan

# Check if installed
if (-not (Test-Path $INSTALL_DIR)) {
    Write-Host "`n$SKILL_NAME is not installed." -ForegroundColor Yellow
    Write-Host "Checked: $INSTALL_DIR" -ForegroundColor Gray
    exit 0
}

# Confirm uninstall
$confirm = Read-Host "Are you sure you want to uninstall $SKILL_NAME? (y/N)"
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "Uninstall cancelled." -ForegroundColor Yellow
    exit 0
}

# Remove installation
Write-Host "Removing $INSTALL_DIR..." -ForegroundColor Yellow
Remove-Item -Recurse -Force $INSTALL_DIR

# Verify removal
if (-not (Test-Path $INSTALL_DIR)) {
    Write-Host "`n✓ Uninstall successful!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "1. Restart Cursor" -ForegroundColor White
    Write-Host "2. The /build-cursorignore command will no longer appear" -ForegroundColor White
} else {
    Write-Host "`n✗ Uninstall may have issues. Some files remain." -ForegroundColor Red
    Write-Host "Please check: $INSTALL_DIR" -ForegroundColor Yellow
}
