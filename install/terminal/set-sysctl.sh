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

# Reduce user-level systemd stop timeout (default 90s is way too long)
mkdir -p ~/.config/systemd/user.conf.d
cat <<EOF > ~/.config/systemd/user.conf.d/10-omakub-timeout.conf
[Manager]
DefaultTimeoutStopSec=10s
EOF

echo "User systemd stop timeout set to 10s."
