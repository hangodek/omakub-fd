#!/bin/bash

cd /tmp
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
wget -O LocalSend.AppImage "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.AppImage"

# Make it executable and move to applications directory
chmod +x LocalSend.AppImage
sudo mkdir -p /opt/localsend
sudo mv LocalSend.AppImage /opt/localsend/

# Create desktop entry
cat > ~/.local/share/applications/localsend.desktop << EOF
[Desktop Entry]
Name=LocalSend
Comment=Share files to nearby devices
Exec=/opt/localsend/LocalSend.AppImage
Icon=localsend
Type=Application
Categories=Network;FileTransfer;
StartupNotify=true
EOF

cd -
