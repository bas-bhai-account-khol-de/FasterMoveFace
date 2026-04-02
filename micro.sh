#!/bin/bash



# Check if micromamba is already installed in $BIN_DEST or in PATH


# --- Configuration ---
# Where the micromamba executable will live
BIN_DEST="$HOME/.local/bin"
# Where your environments and packages will be stored
MAMBA_ROOT="$HOME/micromamba"
# The shell you are using (e.g., bash, zsh)
MY_SHELL=$(basename "$SHELL")

if command -v micromamba >/dev/null 2>&1 || [ -x "$BIN_DEST/micromamba" ]; then
    echo "Micromamba is already installed. Skipping installation."
    exit 0
fi

echo "--- Starting Micromamba Installation ---"

# 1. Create directories
mkdir -p "$BIN_DEST"
mkdir -p "$MAMBA_ROOT"

# 2. Download Micromamba binary
# We use the official multi-arch download link
echo "Downloading micromamba binary..."
curl -Ls https://micro.mamba.pm/api/micromamba/$(uname -s | tr '[:upper:]' '[:lower:]')-64/latest | tar -xj -C "$BIN_DEST" --strip-components=1 bin/micromamba

# 3. Initialize Shell
# This adds the necessary code to your .bashrc or .zshrc
echo "Initializing shell ($MY_SHELL)..."
"$BIN_DEST/micromamba" shell init -s "$MY_SHELL" -r "$MAMBA_ROOT"

echo "--- Installation Complete ---"
echo "Please RESTART your terminal or run: source ~/.${MY_SHELL}rc"