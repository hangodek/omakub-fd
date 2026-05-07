#!/bin/bash

# Install RyzenAdj only when a Ryzen CPU is detected.
if ! lscpu | grep -qi "ryzen"; then
  echo "Skipping RyzenAdj: Ryzen CPU not detected."
  exit 0
fi

if command -v ryzenadj >/dev/null 2>&1; then
  echo "RyzenAdj already installed."
  exit 0
fi

sudo dnf install -y cmake gcc-c++ pciutils-devel

BUILD_DIR=$(mktemp -d)
trap 'rm -rf "$BUILD_DIR"' EXIT

git clone https://github.com/FlyGoat/RyzenAdj "$BUILD_DIR/RyzenAdj"
cmake -S "$BUILD_DIR/RyzenAdj" -B "$BUILD_DIR/RyzenAdj/build" -DCMAKE_BUILD_TYPE=Release
make -C "$BUILD_DIR/RyzenAdj/build" -j"$(nproc)"
sudo cp -v "$BUILD_DIR/RyzenAdj/build/ryzenadj" /usr/local/bin/
