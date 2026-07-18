#!/data/data/com.termux/files/usr/bin/bash
# bootstrap.sh - The "Golden Baseline"
set -e 

# 1. Set variables
BASE_DIR="$HOME/DreamManifest"

# 2. Fix Repository Mirrors (Non-interactively)
if [ ! -f "$PREFIX/etc/apt/sources.list.d/termux.list" ]; then
    echo "deb https://packages.termux.dev/apt/termux-main stable main" > "$PREFIX/etc/apt/sources.list"
    pkg update -y
fi

# 3. Ensure base dependencies
pkg install -y git

# 4. Build Infrastructure
echo "--- BUILDING INFRASTRUCTURE ---"
mkdir -p "$BASE_DIR/apps" "$BASE_DIR/bin" "$BASE_DIR/logs"

# 5. Handle PATH configuration
if ! grep -q "DreamManifest/bin" "$HOME/.bashrc"; then
    echo "export PATH=\$PATH:$BASE_DIR/bin" >> "$HOME/.bashrc"
fi
export PATH=$PATH:$BASE_DIR/bin

# 6. Sync Core
echo "--- SYNCING CORE ---"
if [ ! -d "$BASE_DIR/apps/dream-core" ]; then
    cd "$BASE_DIR/apps"
    git clone https://github.com/ChefStag/dreamspace-core.git dream-core
fi

# 7. Set Identity
cd "$BASE_DIR/apps/dream-core"
git config user.name "ChefStag"
git config user.email "your-email@example.com"
git config credential.helper store

# 8. Running Recovery
echo "--- RUNNING RECOVERY ---"
if [ -f "backend-recovery.sh" ]; then
    chmod +x backend-recovery.sh
    ./backend-recovery.sh
else
    echo "ERROR: Could not find backend-recovery.sh in the repo!"
    exit 1
fi

echo "Bootstrap complete. Your environment is ready."
    exit 1
fi

# Force refresh the shell for the current session
source ~/.bashrc

echo "Bootstrap complete. Your environment is ready."
