#!/bin/bash

if ! command -v microsoft-edge-stable &> /dev/null; then
  echo "Installing Microsoft Edge..."
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  cat <<'EOF' | sudo tee /etc/yum.repos.d/microsoft-edge.repo > /dev/null
[microsoft-edge]
name=Microsoft Edge
baseurl=https://packages.microsoft.com/yumrepos/edge
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
  sudo dnf install -y microsoft-edge-stable
else
  echo "Microsoft Edge is already installed, skipping."
fi

# Set Microsoft Edge as default browser
xdg-settings set default-web-browser microsoft-edge.desktop
