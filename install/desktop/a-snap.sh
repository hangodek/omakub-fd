#!/bin/bash

# Install snapd and snap-store
if command -v snap &> /dev/null; then
	echo "snap is already installed, skipping."
	return 0 2>/dev/null || exit 0
fi

echo "Installing snapd and snap-store..."
sudo dnf install -y snapd fuse squashfuse kernel-modules

# Enable and start snapd service immediately so snap command is available in this session
sudo systemctl enable --now snapd.socket snapd.service

# Create the classic snap symlink
sudo ln -s /var/lib/snapd/snap /snap 2>/dev/null || true

# Make snap command available immediately in the current shell session
export PATH="$PATH:/var/lib/snapd/snap/bin:/snap/bin:/usr/bin"

# Wait for snapd to be fully ready
sudo snap wait system seed.loaded 2>/dev/null || sleep 5

sudo snap install snap-store
