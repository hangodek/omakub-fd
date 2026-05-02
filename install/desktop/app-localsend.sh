#!/bin/bash

if [ ! -f /opt/localsend/localsend_app ]; then
  echo "Installing LocalSend..."
  cd /tmp
  LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  wget -O LocalSend.AppImage "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.AppImage"
  chmod +x LocalSend.AppImage
  sudo mkdir -p /opt/localsend
  sudo mv LocalSend.AppImage /opt/localsend/localsend_app
  cd -

  # Create desktop entry
  cat <<EOF | sudo tee /usr/share/applications/localsend.desktop > /dev/null
[Desktop Entry]
Name=LocalSend
Exec=/opt/localsend/localsend_app
Icon=localsend
Type=Application
Categories=Network;FileTransfer;
EOF
else
  echo "LocalSend is already installed, skipping."
fi
