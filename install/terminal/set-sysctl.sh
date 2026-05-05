#!/bin/bash

# Apply system performance optimizations
echo "Applying system performance tweaks..."

cat <<EOF | sudo tee /etc/sysctl.d/99-omakub-performance.conf > /dev/null
# TCP BBR Congestion Control & Fast Open for faster internet
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_fastopen = 3

# Increase inotify watches for IDEs (VS Code/Cursor)
fs.inotify.max_user_watches = 524288

# Increase max map count for gaming (Proton/Steam)
vm.max_map_count = 2147483642
EOF

sudo sysctl -p /etc/sysctl.d/99-omakub-performance.conf

# Disable core dumps for the current user (prevents large dump files from wasting disk space)
CURRENT_USER=$(whoami)
if ! grep -q "^${CURRENT_USER}.*hard.*core.*0" /etc/security/limits.conf 2>/dev/null; then
  echo "${CURRENT_USER}  hard  core  0" | sudo tee -a /etc/security/limits.conf > /dev/null
fi
if ! grep -q "^${CURRENT_USER}.*soft.*core.*0" /etc/security/limits.conf 2>/dev/null; then
  echo "${CURRENT_USER}  soft  core  0" | sudo tee -a /etc/security/limits.conf > /dev/null
fi
echo "Core dumps disabled for user ${CURRENT_USER}."
