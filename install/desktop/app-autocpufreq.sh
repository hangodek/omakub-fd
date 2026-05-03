#!/bin/bash

# Remove Fedora default power profiles / tuned
sudo dnf remove -y tuned power-profiles-daemon 2>/dev/null || true

# Install auto-cpufreq from Terra repo
if ! command -v auto-cpufreq &> /dev/null; then
  echo "Installing auto-cpufreq..."
  sudo dnf install -y python3-auto-cpufreq
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
governor = ondemand
turbo = auto
EOF

# Enable and start auto-cpufreq
sudo systemctl enable --now auto-cpufreq
