#!/bin/bash

# Remove Fedora default power profiles / tuned
sudo dnf remove -y tuned power-profiles-daemon 2>/dev/null || true

# Install auto-cpufreq from Github source
if ! command -v auto-cpufreq &> /dev/null; then
  echo "Installing auto-cpufreq..."
  rm -rf /tmp/auto-cpufreq
  git clone https://github.com/AdnanHodzic/auto-cpufreq.git /tmp/auto-cpufreq
  cd /tmp/auto-cpufreq
  echo "I" | sudo ./auto-cpufreq-installer
  cd -
else
  echo "auto-cpufreq is already installed, skipping."
fi

# Create auto-cpufreq config
echo "Configuring auto-cpufreq..."
cat <<EOF | sudo tee /etc/auto-cpufreq.conf > /dev/null
[charger]
governor = performance
turbo = auto

[battery]
governor = schedutil
turbo = auto
EOF

# Enable and start auto-cpufreq
sudo systemctl enable --now auto-cpufreq
