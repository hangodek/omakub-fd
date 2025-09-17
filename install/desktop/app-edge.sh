#!/bin/bash

# Install Microsoft Edge for Fedora

echo "Installing Microsoft Edge..."

# Import Microsoft GPG key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add Microsoft Edge repository
sudo dnf config-manager  --from-repofile=https://packages.microsoft.com/yumrepos/edge/config.repo

# Install Microsoft Edge (DNF will skip if already installed)
sudo dnf install -y microsoft-edge-stable

# Set Edge as default browser
xdg-settings set default-web-browser microsoft-edge.desktop

echo "Microsoft Edge installation completed!"