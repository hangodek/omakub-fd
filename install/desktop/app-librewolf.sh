#!/bin/bash

if ! command -v librewolf &> /dev/null; then
  echo "Installing LibreWolf..."
  sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo
  sudo dnf install -y librewolf
else
  echo "LibreWolf is already installed, skipping."
fi

# Set LibreWolf as default browser
xdg-settings set default-web-browser librewolf.desktop
