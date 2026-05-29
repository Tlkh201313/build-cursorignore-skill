#!/bin/bash
# build-cursorignore installer for macOS/Linux
# Usage: curl -fsSL https://raw.githubusercontent.com/YOUR_USER/build-cursorignore/main/scripts/install.sh | bash

set -e

SKILL_NAME="build-cursorignore"
CURSOR_SKILLS_DIR="$HOME/.cursor/skills"
INSTALL_DIR="$CURSOR_SKILLS_DIR/$SKILL_NAME"
REPO_URL="https://github.com/Tlkh201313/build-cursorignore-skill"

echo "Installing $SKILL_NAME..."

# Create skills directory if it doesn't exist
mkdir -p "$CURSOR_SKILLS_DIR"

# Remove existing installation if present
if [ -d "$INSTALL_DIR" ]; then
    echo "Removing existing installation..."
    rm -rf "$INSTALL_DIR"
fi

# Try git clone first, fall back to curl/wget
if command -v git &> /dev/null; then
    echo "Cloning repository..."
    git clone --depth 1 "$REPO_URL" "$INSTALL_DIR" 2>/dev/null || {
        echo "Git clone failed, trying download..."
        INSTALL_VIA_DOWNLOAD=true
    }
else
    INSTALL_VIA_DOWNLOAD=true
fi

# Download via curl/wget if git failed or not available
if [ "$INSTALL_VIA_DOWNLOAD" = true ]; then
    echo "Downloading..."
    TEMP_DIR=$(mktemp -d)
    ZIP_URL="$REPO_URL/archive/refs/heads/main.zip"
    
    if command -v curl &> /dev/null; then
        curl -fsSL "$ZIP_URL" -o "$TEMP_DIR/$SKILL_NAME.zip"
    elif command -v wget &> /dev/null; then
        wget -q "$ZIP_URL" -O "$TEMP_DIR/$SKILL_NAME.zip"
    else
        echo "Error: git, curl, or wget required"
        exit 1
    fi
    
    # Extract and move
    cd "$TEMP_DIR"
    unzip -q "$SKILL_NAME.zip" 2>/dev/null || {
        echo "Error: unzip required"
        exit 1
    }
    
    EXTRACTED_DIR=$(ls -d */ | head -1)
    mv "$EXTRACTED_DIR"* "$INSTALL_DIR"/ 2>/dev/null || true
    mv "$EXTRACTED_DIR".* "$INSTALL_DIR"/ 2>/dev/null || true
    
    # Cleanup
    cd - > /dev/null
    rm -rf "$TEMP_DIR"
fi

# Verify installation
if [ -f "$INSTALL_DIR/SKILL.md" ]; then
    echo ""
    echo "✓ Installation successful!"
    echo ""
    echo "Next steps:"
    echo "1. Restart Cursor"
    echo "2. Open your app repo in Cursor Agent"
    echo "3. Type /build-cursorignore and press Enter"
    echo ""
    echo "Installed to: $INSTALL_DIR"
else
    echo ""
    echo "✗ Installation may have issues. SKILL.md not found."
    echo "Please check: $INSTALL_DIR"
fi
