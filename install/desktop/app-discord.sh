#!/bin/bash

# Install Discord - Voice and text chat for gamers
echo "Installing Discord..."

# Check if Discord is already installed via Flatpak
if flatpak list | grep -q "com.discordapp.Discord"; then
    echo "Discord is already installed, skipping installation..."
    exit 0
fi

# Install Discord via Flatpak
flatpak install -y flathub com.discordapp.Discord

echo "Discord installed successfully!"