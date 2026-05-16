#!/bin/bash

# ─── Post-install tweaks setelah upgrade utama ────────────────────────────────

# ── Firmware Update ───────────────────────────────────────────────────────────
echo "Checking for firmware updates (fwupd)..."
if command -v fwupdmgr &>/dev/null; then
	fwupdmgr refresh --force || true
	fwupdmgr get-updates || true
	fwupdmgr update --assume-yes || true
else
	echo "fwupdmgr not found, skipping firmware update."
fi

# ── Flatpak ───────────────────────────────────────────────────────────────────
echo "Configuring Flathub remotes..."
# System-wide Flathub
flatpak remote-add --if-not-exists flathub \
	https://dl.flathub.org/repo/flathub.flatpakrepo || true
# User-home Flathub
flatpak remote-add --user --if-not-exists flathub \
	https://flathub.org/repo/flathub.flatpakrepo || true

# ── AppImage support (fuse-libs) ──────────────────────────────────────────────
echo "Installing AppImage support (fuse-libs)..."
sudo dnf install -y fuse-libs

# ── Media Codecs ─────────────────────────────────────────────────────────────
echo "Installing multimedia codecs..."
sudo dnf4 group install -y multimedia
sudo dnf swap -y 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf update -y @multimedia \
	--setopt="install_weak_deps=False" \
	--exclude=PackageKit-gstreamer-plugin
sudo dnf group install -y sound-and-video

# ── H/W Video Acceleration (VA-API) ──────────────────────────────────────────
echo "Installing VA-API base packages..."
sudo dnf install -y ffmpeg-libs libva libva-utils

# Detect GPU vendor and install appropriate VA-API driver
GPU_VENDOR=$(lspci 2>/dev/null | grep -iE 'VGA|3D|Display' || true)

if echo "$GPU_VENDOR" | grep -qi 'intel'; then
	echo "Intel GPU detected — installing intel-media-driver..."
	sudo dnf swap -y libva-intel-media-driver intel-media-driver --allowerasing || true
	sudo dnf install -y libva-intel-driver || true
fi

if echo "$GPU_VENDOR" | grep -qi 'amd\|radeon\|advanced micro'; then
	echo "AMD GPU detected — installing mesa freeworld VA drivers..."
	sudo dnf install -y mesa-va-drivers-freeworld || true
	sudo dnf install -y mesa-va-drivers-freeworld.i686 || true
fi

# ── Set UTC Hardware Clock ────────────────────────────────────────────────────
# Prevents time drift issues in dual-boot setups
echo "Setting hardware clock to UTC..."
sudo timedatectl set-local-rtc '0'
