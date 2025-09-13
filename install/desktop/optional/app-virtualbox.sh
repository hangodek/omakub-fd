#!/bin/bash

# VirtualBox allows you to run VMs for other flavors of Linux or even Windows
# See https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started/
# for a guide on virtualization on Fedora.

# Install kernel headers and development tools required for VirtualBox
sudo dnf install -y kernel-devel kernel-headers dkms qt5-qtx11extras
# Install VirtualBox from RPM Fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y VirtualBox
sudo usermod -aG vboxusers ${USER}
