#!/bin/bash

# Install RyzenAdj and UXTU4Linux only when a Ryzen CPU is detected.
if ! lscpu | grep -qi "ryzen"; then
  echo "Skipping RyzenAdj/UXTU4Linux: Ryzen CPU not detected."
  exit 0
fi

# Install dependencies for RyzenAdj (UXTU4Linux wrapper)
sudo dnf install -y cmake gcc-c++ pciutils-devel python3-pip

# 1. Install RyzenAdj binary if not present
if ! command -v ryzenadj >/dev/null 2>&1; then
  echo "Installing RyzenAdj binary..."
  BUILD_DIR=$(mktemp -d)
  trap 'rm -rf "$BUILD_DIR"' EXIT

  git clone https://github.com/FlyGoat/RyzenAdj "$BUILD_DIR/RyzenAdj"
  cmake -S "$BUILD_DIR/RyzenAdj" -B "$BUILD_DIR/RyzenAdj/build" -DCMAKE_BUILD_TYPE=Release
  make -C "$BUILD_DIR/RyzenAdj/build" -j"$(nproc)"
  sudo cp -v "$BUILD_DIR/RyzenAdj/build/ryzenadj" /usr/local/bin/
else
  echo "RyzenAdj binary already installed."
fi

# 2. Install UXTU4Linux (Interactive UI and Daemon)
echo "Installing UXTU4Linux..."
curl -fsSL https://raw.githubusercontent.com/HorizonUnix/UXTU4Linux/main/install.sh | bash

echo "UXTU4Linux installation complete."
echo "You can now run 'uxtu4linux' in your terminal to choose presets and configure the daemon."
