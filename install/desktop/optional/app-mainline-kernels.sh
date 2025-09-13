#!/bin/bash

# On Fedora, kernel updates are handled through the main repositories
# Enable testing repositories for newer kernels if needed
sudo dnf install -y kernel kernel-devel
echo "Latest kernel packages installed. Fedora handles kernel updates through DNF."
