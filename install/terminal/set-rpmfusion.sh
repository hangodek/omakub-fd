#!/bin/bash

# ─── RPM Fusion & Terra ───────────────────────────────────────────────────────
# Enable RPM Fusion (free + nonfree) for access to Steam, Discord, codecs, etc.

echo "Enabling RPM Fusion repositories..."
if ! rpm -q rpmfusion-free-release &>/dev/null; then
	sudo dnf install -y \
		"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
		"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
else
	echo "RPM Fusion already enabled, skipping."
fi

# Enable Terra repository (Fyra Labs)
echo "Enabling Terra repository..."
if ! rpm -q terra-release &>/dev/null; then
	sudo dnf install -y --nogpgcheck \
		--repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' \
		terra-release
else
	echo "Terra already enabled, skipping."
fi

# Install AppStream metadata for the Software Center
echo "Installing AppStream metadata..."
sudo dnf group upgrade -y core
sudo dnf4 group install -y core
