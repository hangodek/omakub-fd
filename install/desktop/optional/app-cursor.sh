#!/bin/bash

if [ ! -f /opt/cursor/cursor.appimage ]; then
  echo "Installing Cursor..."
  cd /tmp
  curl -L "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable" | jq -r '.downloadUrl' | xargs curl -L -o cursor.appimage
  chmod +x cursor.appimage
  sudo mkdir -p /opt/cursor
  sudo mv cursor.appimage /opt/cursor/
  cd -

  cat <<EOF | sudo tee /usr/share/applications/cursor.desktop > /dev/null
[Desktop Entry]
Name=Cursor
Exec=/opt/cursor/cursor.appimage
Icon=cursor
Type=Application
Categories=Development;
EOF
else
  echo "Cursor is already installed, skipping."
fi
