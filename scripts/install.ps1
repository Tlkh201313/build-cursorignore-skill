# build-cursorignore installer for Windows
# Usage: irm https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.ps1 | iex

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

# Try git clone first
$useGit = $false
try {
    $null = Get-Command git -ErrorAction Stop
    $useGit = $true
} catch {}

if ($useGit) {
    Write-Host "Cloning repository..." -ForegroundColor Cyan
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"
    $gitOutput = & git clone --quiet --depth 1 $REPO_URL $INSTALL_DIR 2>&1
    $ErrorActionPreference = $prevEAP
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n[OK] Installation successful!" -ForegroundColor Green
        Write-Host "`nNext steps:" -ForegroundColor Cyan
        Write-Host "1. Restart Cursor" -ForegroundColor White
        Write-Host "2. Open your app repo in Cursor Agent" -ForegroundColor White
        Write-Host "3. Type /build-cursorignore and press Enter" -ForegroundColor White
        Write-Host "`nInstalled to: $INSTALL_DIR" -ForegroundColor Gray
        exit 0
    }
    Write-Host "Git clone failed, trying download..." -ForegroundColor Yellow
}

# Download zip as fallback
Write-Host "Downloading zip..." -ForegroundColor Cyan
$zipUrl = "$REPO_URL/archive/refs/heads/master.zip"
$zipPath = "$env:TEMP\$SKILL_NAME.zip"
$extractPath = "$env:TEMP\$SKILL_NAME-extract"

# Clean up any previous attempts
Remove-Item -Path $zipPath -Force -ErrorAction SilentlyContinue
Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue

try {
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

    # Find the extracted folder (GitHub creates repo-branch folder)
    $extractedDir = Get-ChildItem -Path $extractPath -Directory | Select-Object -First 1

    if ($extractedDir) {
        # Create install directory and copy contents
        New-Item -ItemType Directory -Force -Path $INSTALL_DIR | Out-Null
        Copy-Item -Path "$($extractedDir.FullName)\*" -Destination $INSTALL_DIR -Recurse -Force
    } else {
        throw "No folder found in zip"
    }
} finally {
    # Cleanup temp files
    Remove-Item -Path $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
}

# Verify installation
$skillFile = Join-Path $INSTALL_DIR "SKILL.md"
if (Test-Path $skillFile) {
    Write-Host "`n[OK] Installation successful!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "1. Restart Cursor" -ForegroundColor White
    Write-Host "2. Open your app repo in Cursor Agent" -ForegroundColor White
    Write-Host "3. Type /build-cursorignore and press Enter" -ForegroundColor White
    Write-Host "`nInstalled to: $INSTALL_DIR" -ForegroundColor Gray
} else {
    Write-Host "`n[FAIL] Installation may have issues. SKILL.md not found." -ForegroundColor Red
    Write-Host "Please check: $INSTALL_DIR" -ForegroundColor Yellow
}
