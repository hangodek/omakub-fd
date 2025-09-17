#!/bin/bash

# Install EasyEffects (audio effects processor)
echo "Installing EasyEffects..."
sudo dnf install -y easyeffects

# Create EasyEffects config directory if it doesn't exist
mkdir -p ~/.config/easyeffects/output ~/.config/easyeffects/input

# Install community presets from JackHack96/PulseEffects-Presets (non-interactive)
echo "Installing EasyEffects community presets..."
cd /tmp
curl -fsSL https://github.com/JackHack96/PulseEffects-Presets/archive/master.zip -o presets.zip
unzip -q presets.zip
cp -r PulseEffects-Presets-master/output/* ~/.config/easyeffects/output/ 2>/dev/null || true
cp -r PulseEffects-Presets-master/input/* ~/.config/easyeffects/input/ 2>/dev/null || true
cp -r PulseEffects-Presets-master/irs ~/.config/easyeffects/ 2>/dev/null || true
rm -rf presets.zip PulseEffects-Presets-master
cd -

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