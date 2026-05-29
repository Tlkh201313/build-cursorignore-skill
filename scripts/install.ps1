# build-cursorignore installer for Windows
# Usage: irm https://raw.githubusercontent.com/YOUR_USER/build-cursorignore/main/scripts/install.ps1 | iex

$ErrorActionPreference = "Stop"

$SKILL_NAME = "build-cursorignore"
$CURSOR_SKILLS_DIR = "$env:USERPROFILE\.cursor\skills"
$INSTALL_DIR = "$CURSOR_SKILLS_DIR\$SKILL_NAME"
$REPO_URL = "https://github.com/Tlkh201313/build-cursorignore-skill"

Write-Host "Installing $SKILL_NAME..." -ForegroundColor Cyan

# Create skills directory if it doesn't exist
if (-not (Test-Path $CURSOR_SKILLS_DIR)) {
    New-Item -ItemType Directory -Force -Path $CURSOR_SKILLS_DIR | Out-Null
    Write-Host "Created $CURSOR_SKILLS_DIR" -ForegroundColor Green
}

# Remove existing installation if present
if (Test-Path $INSTALL_DIR) {
    Write-Host "Removing existing installation..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $INSTALL_DIR
}

# Clone the repository
Write-Host "Cloning repository..." -ForegroundColor Cyan
try {
    git clone --depth 1 $REPO_URL $INSTALL_DIR 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "git clone failed"
    }
} catch {
    Write-Host "Git not found. Downloading zip instead..." -ForegroundColor Yellow
    
    # Download zip as fallback
    $zipUrl = "$REPO_URL/archive/refs/heads/master.zip"
    $zipPath = "$env:TEMP\$SKILL_NAME.zip"
    $extractPath = "$env:TEMP\$SKILL_NAME-extract"
    
    # Clean up any previous attempts
    Remove-Item -Path $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
    
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
    
    # Create install directory
    New-Item -ItemType Directory -Force -Path $INSTALL_DIR | Out-Null
    
    # Move contents to install directory
    $extractedDir = Get-ChildItem -Path $extractPath -Directory | Select-Object -First 1
    Copy-Item -Path "$($extractedDir.FullName)\*" -Destination $INSTALL_DIR -Recurse -Force
    
    # Cleanup
    Remove-Item -Path $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
}

# Verify installation
$skillFile = Join-Path $INSTALL_DIR "SKILL.md"
if (Test-Path $skillFile) {
    Write-Host "`n✓ Installation successful!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "1. Restart Cursor" -ForegroundColor White
    Write-Host "2. Open your app repo in Cursor Agent" -ForegroundColor White
    Write-Host "3. Type /build-cursorignore and press Enter" -ForegroundColor White
    Write-Host "`nInstalled to: $INSTALL_DIR" -ForegroundColor Gray
} else {
    Write-Host "`n✗ Installation may have issues. SKILL.md not found." -ForegroundColor Red
    Write-Host "Please check: $INSTALL_DIR" -ForegroundColor Yellow
}
