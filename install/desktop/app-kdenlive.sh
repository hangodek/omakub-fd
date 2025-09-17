#!/bin/bash

# Install Kdenlive - Professional video editing suite
echo "Installing Kdenlive..."

# Check if Kdenlive is already installed via DNF
if dnf list installed kdenlive &>/dev/null; then
    echo "Kdenlive is already installed, skipping installation..."
    return 0
fi

# Install Kdenlive via DNF
sudo dnf install -y kdenlive

echo "Kdenlive installed successfully!"