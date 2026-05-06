#!/bin/bash

# Install gnome-extensions-app and CLI for easy user extension management later
sudo dnf install -y gnome-extensions-app pipx
pipx install gnome-extensions-cli --system-site-packages
