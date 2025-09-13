#!/bin/bash

cd /tmp
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
wget -O LocalSend.AppImage "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.AppImage"

# Make it executable and move to applications directory
chmod +x LocalSend.AppImage
sudo mkdir -p /opt/localsend
sudo mv LocalSend.AppImage /opt/localsend/

cd -
