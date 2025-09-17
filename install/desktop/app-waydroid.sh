#!/bin/bash

# Install Waydroid - Android container for Linux
echo "Installing Waydroid..."

# Check if Waydroid is already installed
if dnf list installed waydroid &>/dev/null; then
    echo "Waydroid is already installed, skipping installation..."
    return 0
fi

# Install Waydroid
echo "Installing Waydroid package..."
sudo dnf install -y waydroid

echo "Waydroid installed successfully!"