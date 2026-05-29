#!/usr/bin/env bash
# build-cursorignore updater for macOS/Linux
# Usage: curl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/update.sh | bash

set -e

SKILL_NAME="build-cursorignore"
INSTALL_DIR="$HOME/.cursor/skills/$SKILL_NAME"

echo -e "\033[36mUpdating $SKILL_NAME...\033[0m"

# Check if installed
if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "\033[31m[ERROR] $SKILL_NAME is not installed. Run install first.\033[0m"
    exit 1
fi

# Check if it's a git repo
if [ ! -d "$INSTALL_DIR/.git" ]; then
    echo -e "\033[31m[ERROR] Not a git repository. Reinstall with:\033[0m"
    echo -e "\033[33mcurl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.sh | bash\033[0m"
    exit 1
fi

# Pull latest changes
echo -e "\033[36mPulling latest changes...\033[0m"
if git -C "$INSTALL_DIR" pull --quiet; then
    echo -e "\n\033[32m[OK] Update successful!\033[0m"
    echo -e "\033[36mRestart Cursor to use the latest version.\033[0m"
else
    echo -e "\n\033[31m[ERROR] Update failed. Try reinstalling:\033[0m"
    echo -e "\033[33mcurl -fsSL https://raw.githubusercontent.com/Tlkh201313/build-cursorignore-skill/master/scripts/install.sh | bash\033[0m"
    exit 1
fi
