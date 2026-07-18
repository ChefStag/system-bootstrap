#!/bin/bash
# bootstrap.sh

BASE_DIR="$HOME/DreamManifest"

echo "--- BUILDING INFRASTRUCTURE ---"
mkdir -p "$BASE_DIR/apps" "$BASE_DIR/bin" "$BASE_DIR/logs"

# Ensure PATH is set
if [[ ":$PATH:" != *":$BASE_DIR/bin:"* ]]; then
    echo "export PATH=\$PATH:$BASE_DIR/bin" >> ~/.bashrc
    export PATH=$PATH:$BASE_DIR/bin
fi

echo "--- SYNCING CORE ---"
if [ ! -d "$BASE_DIR/apps/dream-core" ]; then
    cd "$BASE_DIR/apps"
    git clone https://github.com/ChefStag/dreamspace-core.git dream-core
fi

echo "--- RUNNING SETUP ---"
cd "$BASE_DIR/apps/dream-core"
# Ensure the script is executable
chmod +x scripts/backend-recovery.sh
./scripts/backend-recovery.sh

echo "Bootstrap complete. Refresh your terminal with 'source ~/.bashrc'"
