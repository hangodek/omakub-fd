#!/bin/bash

# Browse the web with the most popular browser. See https://www.google.com/chrome/

# Check if Chrome is installed and if updates are available
if dnf list installed google-chrome-stable &>/dev/null; then
    echo "Google Chrome is installed. Checking for updates..."
    if dnf check-update google-chrome-stable &>/dev/null; then
        echo "Google Chrome is up to date, skipping installation..."
        # Still set as default browser in case it wasn't set
        xdg-settings set default-web-browser google-chrome.desktop
        exit 0
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
xdg-settings set default-web-browser google-chrome.desktop
cd -
