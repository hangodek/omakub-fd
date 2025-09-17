#!/bin/bash

# Browse the web with the most popular browser. See https://www.google.com/chrome/

echo "Installing Google Chrome..."

cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ./google-chrome-stable_current_x86_64.rpm
rm google-chrome-stable_current_x86_64.rpm
cd -

echo "Google Chrome installation completed!"