#!/bin/bash

# Install Discord - Voice and text chat for gamers
echo "Installing Discord..."

# Check if Discord is already installed via DNF
if dnf list installed discord &>/dev/null; then
    echo "Discord is already installed, skipping installation..."
    return 0
fi

# Enable RPM Fusion free repository if not already enabled
if ! dnf repolist enabled | grep -q "rpmfusion-free"; then
    echo "Enabling RPM Fusion free repository..."
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
fi

# Install Discord via DNF
sudo dnf install -y discord

echo "Discord installed successfully!"