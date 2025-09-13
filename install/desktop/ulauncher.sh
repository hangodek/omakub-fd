#!/bin/bash

# Install Ulauncher via DNF
sudo dnf install -y ulauncher

# Change Ulauncher window position from center to top before first launch
sudo sed -i 's/<property name="window_position">center<\/property>/<property name="window_position">top<\/property>/g' /usr/share/ulauncher/ui/UlauncherWindow.ui

# Start ulauncher to have it populate config before we overwrite
mkdir -p ~/.config/autostart/
cp ~/.local/share/omakub/configs/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
ulauncher >/dev/null 2>&1 &
sleep 2 # ensure enough time for ulauncher to set defaults
cp ~/.local/share/omakub/configs/ulauncher.json ~/.config/ulauncher/settings.json
