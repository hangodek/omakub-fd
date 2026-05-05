#!/bin/bash

# Optimize DNF
echo "Optimizing DNF configuration..."
if ! grep -q "max_parallel_downloads" /etc/dnf/dnf.conf; then
  echo "max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf
fi
if ! grep -q "fastestmirror" /etc/dnf/dnf.conf; then
  echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
fi

# Setup DNS over TLS with Quad9
echo "Setting up Quad9 DNS over TLS..."
sudo mkdir -p /etc/systemd/resolved.conf.d
cat <<EOF | sudo tee /etc/systemd/resolved.conf.d/99-dns-over-tls.conf > /dev/null
[Resolve]
DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net
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

# Stop Gnome Software from autostarting (saves RAM)
if [ -f /etc/xdg/autostart/org.gnome.Software.desktop ]; then
  echo "Disabling Gnome Software autostart..."
  sudo rm /etc/xdg/autostart/org.gnome.Software.desktop
fi
