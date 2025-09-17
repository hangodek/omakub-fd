#!/bin/bash

# Browse the web with the most popular browser. See https://www.google.com/chrome/

# Check if Chrome is already installed
if dnf list installed google-chrome-stable &>/dev/null; then
    echo "Google Chrome is installed. Checking for updates..."
    if dnf check-update google-chrome-stable &>/dev/null; then
        echo "Google Chrome is up to date, skipping installation..."
        return 0
    else
        echo "Google Chrome update available, proceeding with installation..."
    fi
else
    echo "Installing Google Chrome..."
fi

cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ./google-chrome-stable_current_x86_64.rpm
rm google-chrome-stable_current_x86_64.rpm
cd -
