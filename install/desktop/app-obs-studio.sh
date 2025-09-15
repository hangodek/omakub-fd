#!/bin/bash

# Install OBS Studio - Free and open source software for live streaming and screen recording
echo "Installing OBS Studio..."

# Check if OBS Studio is already installed
if dnf list installed obs-studio &>/dev/null; then
    echo "OBS Studio is already installed, skipping installation..."
    exit 0
fi

# Install OBS Studio via DNF
sudo dnf install -y obs-studio

echo "OBS Studio installed successfully!"