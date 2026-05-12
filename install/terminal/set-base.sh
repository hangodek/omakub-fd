#!/bin/bash

# Optimize DNF
echo "Optimizing DNF configuration..."
if ! grep -q "max_parallel_downloads" /etc/dnf/dnf.conf; then
  echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
fi
if ! grep -q "fastestmirror" /etc/dnf/dnf.conf; then
  echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
fi

# Setup DNS over TLS with Cloudflare
echo "Setting up Cloudflare DNS over TLS..."
sudo mkdir -p /etc/systemd/resolved.conf.d
cat <<EOF | sudo tee /etc/systemd/resolved.conf.d/99-dns-over-tls.conf > /dev/null
[Resolve]
DNS=1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 2606:4700:4700::1001#cloudflare-dns.com
DNSOverTLS=yes
Domains=~.
EOF

# Ensure NetworkManager uses systemd-resolved
sudo mkdir -p /etc/NetworkManager/conf.d
cat <<EOF | sudo tee /etc/NetworkManager/conf.d/dns.conf > /dev/null
[main]
dns=systemd-resolved
EOF

# Enable systemd-resolved (changes take effect after reboot to avoid network drops during install)
sudo systemctl enable systemd-resolved

# Disable NetworkManager-wait-online.service to speed up boot
echo "Disabling NetworkManager-wait-online.service..."
sudo systemctl disable NetworkManager-wait-online.service

# Reduce systemd stop timeout to 10s (default is 90s — too long for stuck apps)
echo "Setting systemd stop timeout to 10s..."
sudo mkdir -p /etc/systemd/system.conf.d
cat <<EOF | sudo tee /etc/systemd/system.conf.d/10-omakub-timeout.conf > /dev/null
[Manager]
DefaultTimeoutStopSec=10s
EOF
sudo systemctl daemon-reload

# Stop Gnome Software from autostarting (saves RAM)
if [ -f /etc/xdg/autostart/org.gnome.Software.desktop ]; then
  echo "Disabling Gnome Software autostart..."
  sudo rm /etc/xdg/autostart/org.gnome.Software.desktop
fi
