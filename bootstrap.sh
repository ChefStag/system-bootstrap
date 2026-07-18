#!/data/data/com.termux/files/usr/bin/bash
# bootstrap.sh - The "Golden Baseline"
set -e 

# Anti-Pip Interceptor
pip() {
    echo "--- [SECURITY ALERT] ---"
    echo "Direct pip usage is FORBIDDEN in this environment to prevent system breakage."
    echo "Use 'pkg install python-<package>' instead."
    return 1
}
export -f pip


#!/data/data/com.termux/files/usr/bin/bash

# --- AUTOMATED MIRROR STABILIZATION ---
# If the apt update fails or the sources list is suspect, force set your verified mirror
fix_mirrors() {
    echo "--- STABILIZING REPOSITORY MIRRORS ---"
    # Create the directory if it doesn't exist
    mkdir -p "$PREFIX/etc/apt/sources.list.d"
    
    # Write your verified mirror directly to the sources.list
    echo "deb https://gnlug.org/pub/termux/termux-main stable main" > "$PREFIX/etc/apt/sources.list"
    
    # Update the package index
    pkg update
}

# Run the check: if pkg update fails, run the fix
if ! pkg update -y > /dev/null 2>&1; then
    fix_mirrors
fi
# ---------------------------------------


BASE_DIR="$HOME/DreamManifest"

# 1. Ensure minimal dependencies via pkg only
pkg update -y
pkg install -y git python

# 2. Build Infrastructure
mkdir -p "$BASE_DIR/apps" "$BASE_DIR/bin" "$BASE_DIR/logs"

# 3. Handle PATH
if ! grep -q "DreamManifest/bin" "$HOME/.bashrc"; then
    echo "export PATH=\$PATH:$BASE_DIR/bin" >> "$HOME/.bashrc"
fi

# 4. Sync Core
if [ ! -d "$BASE_DIR/apps/dream-core" ]; then
    cd "$BASE_DIR/apps"
    git clone https://github.com/ChefStag/dreamspace-core.git dream-core
fi

# 5. Set Identity
cd "$BASE_DIR/apps/dream-core"
git config user.name "ChefStag"
git config user.email "your-email@example.com"
git config credential.helper store

echo "Bootstrap complete. Core infrastructure ready."
echo "CRITICAL: Recovery skipped to prevent forbidden pip usage."
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
