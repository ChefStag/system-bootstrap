#!/bin/bash
# bootstrap.sh - The "Golden Baseline"

BASE_DIR="$HOME/DreamManifest"

echo "--- BUILDING INFRASTRUCTURE ---"
mkdir -p "$BASE_DIR/apps" "$BASE_DIR/bin" "$BASE_DIR/logs"

# Ensure PATH is set for this session and permanently
if [[ ":$PATH:" != *":$BASE_DIR/bin:"* ]]; then
    echo 'export PATH=$PATH:'"$BASE_DIR/bin" >> ~/.bashrc
    export PATH=$PATH:$BASE_DIR/bin
fi

echo "--- SYNCING CORE ---"
if [ ! -d "$BASE_DIR/apps/dream-core" ]; then
    cd "$BASE_DIR/apps"
    git clone https://github.com/ChefStag/dreamspace-core.git dream-core
fi

# Set Identity to prevent 'Author identity unknown' errors
cd "$BASE_DIR/apps/dream-core"
git config user.name "ChefStag"
git config user.email "your-email@example.com" # Replace with your email
git config credential.helper store

echo "--- RUNNING SETUP ---"
chmod +x scripts/backend-recovery.sh
./scripts/backend-recovery.sh

# Force refresh the shell for the current session
source ~/.bashrc

echo "Bootstrap complete. Your environment is ready."
