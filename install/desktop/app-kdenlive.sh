#!/bin/bash

# Install Kdenlive - Professional video editing suite
echo "Installing Kdenlive..."

# Check if Kdenlive is already installed via Flatpak
if flatpak list | grep -q "org.kde.kdenlive"; then
    echo "Kdenlive is already installed, skipping installation..."
    exit 0
fi

# Install Kdenlive via Flatpak (more up-to-date than DNF package)
flatpak install -y flathub org.kde.kdenlive

echo "Kdenlive installed successfully!"