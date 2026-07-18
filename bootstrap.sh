#!/bin/bash
# bootstrap.sh - The "Golden Baseline"

# Set the source of truth
BASE_DIR="/data/data/com.termux/files/home/DreamManifest"

# Force-set the default mirror if one isn't detected
if [ ! -f "$PREFIX/etc/apt/sources.list.d/termux.list" ]; then
    echo "deb https://packages.termux.dev/apt/termux-main stable main" > $PREFIX/etc/apt/sources.list
    apt update -y
fi

echo "--- BUILDING INFRASTRUCTURE ---"
mkdir -p "$BASE_DIR/apps" "$BASE_DIR/bin" "$BASE_DIR/logs"

# Ensure PATH is set permanently
if ! grep -q "DreamManifest/bin" ~/.bashrc; then
    echo 'export PATH=$PATH:'"$BASE_DIR/bin" >> ~/.bashrc
fi
export PATH=$PATH:$BASE_DIR/bin

echo "--- SYNCING CORE ---"
if [ ! -d "$BASE_DIR/apps/dream-core" ]; then
    cd "$BASE_DIR/apps"
    git clone https://github.com/ChefStag/dreamspace-core.git dream-core
fi

# Set Identity for the environment
cd "$BASE_DIR/apps/dream-core"
git config user.name "ChefStag"
git config user.email "your-email@example.com"
git config credential.helper store

echo "--- RUNNING RECOVERY ---"
# Execute the Cloud-based recovery script
chmod +x backend-recovery.sh
./backend-recovery.sh

# Force refresh the shell for the current session
source ~/.bashrc
echo "Bootstrap complete. Your environment is fully synced with the Cloud."
    echo "ERROR: Could not find backend-recovery.sh in the repo!"
    exit 1
fi

# Force refresh the shell for the current session
source ~/.bashrc

echo "Bootstrap complete. Your environment is ready."
