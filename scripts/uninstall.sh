#!/bin/bash
# build-cursorignore uninstaller for macOS/Linux
# Usage: curl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/main/scripts/uninstall.sh | bash

set -e

SKILL_NAME="build-cursorignore"
CURSOR_SKILLS_DIR="$HOME/.cursor/skills"
INSTALL_DIR="$CURSOR_SKILLS_DIR/$SKILL_NAME"

echo "Uninstalling $SKILL_NAME..."

# Check if installed
if [ ! -d "$INSTALL_DIR" ]; then
    echo ""
    echo "$SKILL_NAME is not installed."
    echo "Checked: $INSTALL_DIR"
    exit 0
fi

# Confirm uninstall (skip if piped)
if [ -t 0 ]; then
    read -p "Are you sure you want to uninstall $SKILL_NAME? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Uninstall cancelled."
        exit 0
    fi
fi

# Remove installation
echo "Removing $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"

# Verify removal
if [ ! -d "$INSTALL_DIR" ]; then
    echo ""
    echo "✓ Uninstall successful!"
    echo ""
    echo "Next steps:"
    echo "1. Restart Cursor"
    echo "2. The /build-cursorignore command will no longer appear"
else
    echo ""
    echo "✗ Uninstall may have issues. Some files remain."
    echo "Please check: $INSTALL_DIR"
fi
