#!/bin/bash

# Check if VS Code is already installed
if command -v code &> /dev/null; then
    echo "VS Code is already installed, skipping..."
    # Still ensure config is copied
    mkdir -p ~/.config/Code/User
    cp ~/.local/share/omakub/configs/vscode.json ~/.config/Code/User/settings.json
    # Try to install extension (skip if already installed)
    code --install-extension enkia.tokyo-night >/dev/null 2>&1 || true
    exit 0
fi

echo "Installing VS Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee /etc/yum.repos.d/vscode.repo

sudo dnf install -y code

mkdir -p ~/.config/Code/User
cp ~/.local/share/omakub/configs/vscode.json ~/.config/Code/User/settings.json

# Install default supported themes
code --install-extension enkia.tokyo-night >/dev/null 2>&1 || true
