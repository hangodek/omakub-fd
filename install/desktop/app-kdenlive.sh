#!/bin/bash

# Install Kdenlive - Professional video editing suite
echo "Installing Kdenlive..."

# Install Kdenlive via DNF (DNF will skip if already installed)
sudo dnf install -y kdenlive

echo "Kdenlive installation completed!"