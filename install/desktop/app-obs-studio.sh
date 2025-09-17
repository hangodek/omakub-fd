#!/bin/bash

# Install OBS Studio - Free and open source software for live streaming and screen recording
echo "Installing OBS Studio..."

# Install OBS Studio via DNF (DNF will skip if already installed)
sudo dnf install -y obs-studio

echo "OBS Studio installation completed!"