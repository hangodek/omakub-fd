#!/bin/bash

# Install Microsoft Edge for Fedora

# Check if Edge is already installed
if command -v microsoft-edge &> /dev/null; then
    echo "Microsoft Edge is already installed, skipping..."
    # Still set as default browser in case it wasn't set
    xdg-settings set default-web-browser microsoft-edge.desktop
    exit 0
fi

echo "Installing Microsoft Edge..."

# Import Microsoft GPG key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add Microsoft Edge repository
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge/config.repo

# Install Microsoft Edge
sudo dnf install -y microsoft-edge-stable

# Set Edge as default browser
xdg-settings set default-web-browser microsoft-edge.desktop

echo "Microsoft Edge installed and set as default browser!"