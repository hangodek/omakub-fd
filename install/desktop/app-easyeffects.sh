#!/bin/bash

# Install EasyEffects (audio effects processor) and community presets
echo "Installing EasyEffects..."
sudo dnf install -y easyeffects

# Install community presets from JackHack96/PulseEffects-Presets
echo "Installing EasyEffects community presets (all presets)..."
echo "1" | bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"

# Configure PipeWire for optimal DSP performance
echo "Configuring PipeWire DSP settings..."
sudo cp /usr/share/pipewire/pipewire.conf /usr/share/pipewire/pipewire.conf.backup

# Update PipeWire configuration with DSP settings
sudo sed -i 's/^[[:space:]]*#*[[:space:]]*default\.clock\.rate[[:space:]]*=.*/    default.clock.rate          = 48000/' /usr/share/pipewire/pipewire.conf
sudo sed -i 's/^[[:space:]]*#*[[:space:]]*default\.clock\.quantum[[:space:]]*=.*/    default.clock.quantum       = 2048/' /usr/share/pipewire/pipewire.conf
sudo sed -i 's/^[[:space:]]*#*[[:space:]]*default\.clock\.min-quantum[[:space:]]*=.*/    default.clock.min-quantum   = 2048/' /usr/share/pipewire/pipewire.conf
sudo sed -i 's/^[[:space:]]*#*[[:space:]]*default\.clock\.max-quantum[[:space:]]*=.*/    default.clock.max-quantum   = 2048/' /usr/share/pipewire/pipewire.conf

echo "EasyEffects, presets, and PipeWire DSP configuration completed successfully!"
echo "Note: PipeWire changes will take effect after restarting the PipeWire service or rebooting."