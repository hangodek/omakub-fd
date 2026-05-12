#!/bin/bash

# Install CachyOS kernel when CPU supports the required x86_64 levels.
if ! grep -qi "^ID=fedora" /etc/os-release; then
  echo "Skipping CachyOS kernel: not Fedora."
  exit 0
fi

LD_HELP=$(/lib64/ld-linux-x86-64.so.2 --help | grep "(supported, searched)" || true)

if echo "$LD_HELP" | grep -q "x86-64-v3 (supported, searched)"; then
  KERNEL_PKG="kernel-cachyos"
  KERNEL_DEVEL_PKG="kernel-cachyos-devel-matched"
  KERNEL_LABEL="default"
elif echo "$LD_HELP" | grep -q "x86-64-v2 (supported, searched)"; then
  KERNEL_PKG="kernel-cachyos-lts"
  KERNEL_DEVEL_PKG="kernel-cachyos-lts-devel-matched"
  KERNEL_LABEL="lts"
else
  echo "Skipping CachyOS kernel: no x86_64_v2/v3 support detected."
  exit 0
fi

echo "Installing CachyOS kernel (${KERNEL_LABEL})..."

sudo setsebool -P domain_kernel_load_modules on

sudo dnf copr enable -y bieszczaders/kernel-cachyos
sudo dnf install -y "$KERNEL_PKG" "$KERNEL_DEVEL_PKG"

sudo dnf copr enable -y bieszczaders/kernel-cachyos-addons

sudo dnf swap -y zram-generator-defaults cachyos-settings
sudo dracut -f

sudo dnf install -y scx-scheds scx-tools
sudo dnf install -y scx-manager
