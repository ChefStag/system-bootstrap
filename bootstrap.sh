#!/bin/bash
# bootstrap.sh - The "One-Shot" Environment Builder

echo "--- STEP 1: SCAFFOLDING ---"
BASE_DIR="$HOME/DreamManifest"
mkdir -p "$BASE_DIR/apps" "$BASE_DIR/bin" "$BASE_DIR/logs"

# Ensure PATH is set so you can use your bin tools
if [[ ":$PATH:" != *":$BASE_DIR/bin:"* ]]; then
    echo "export PATH=\$PATH:$BASE_DIR/bin" >> ~/.bashrc
    export PATH=$PATH:$BASE_DIR/bin
fi

echo "--- STEP 2: CLONING CORE ---"
# Check if the app is already there to avoid errors
if [ ! -d "$BASE_DIR/apps/dream-core" ]; then
    cd "$BASE_DIR/apps"
    git clone https://github.com/ChefStag/dream-core.git
fi

echo "--- STEP 3: INITIALIZING BACKEND RECOVERY ---"
# Now we trigger your actual project setup
cd "$BASE_DIR/apps/dream-core"
chmod +x scripts/backend-recovery.sh
./scripts/backend-recovery.sh

echo "Bootstrap complete. Type 'talk' to start your assistant."
