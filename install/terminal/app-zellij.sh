#!/bin/bash

if ! command -v zellij &> /dev/null; then
  echo "Installing Zellij..."
  cd /tmp
  wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
  tar -xf zellij.tar.gz zellij
  sudo install zellij /usr/local/bin/
  rm zellij.tar.gz zellij
  cd -
else
  echo "Zellij is already installed, skipping."
fi
