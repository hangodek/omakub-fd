#!/bin/bash

# Play games from https://store.steampowered.com/
# Steam is available in RPM Fusion repositories for Fedora
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y steam
