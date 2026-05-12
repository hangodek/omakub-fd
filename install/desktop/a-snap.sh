#!/bin/bash

# Install snapd and snap-store
echo "Installing snapd and snap-store..."
sudo dnf install -y snapd fuse squashfuse kernel-modules
sudo ln -s /var/lib/snapd/snap /snap 2>/dev/null || true
sudo snap install snap-store
