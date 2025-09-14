#!/bin/bash

# Install EasyEffects (audio effects processor) and community presets
echo "Installing EasyEffects..."
sudo dnf install -y easyeffects

# Install community presets from JackHack96/PulseEffects-Presets
echo "Installing EasyEffects community presets (all presets)..."
echo "1" | bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"

echo "EasyEffects and presets installed successfully!"