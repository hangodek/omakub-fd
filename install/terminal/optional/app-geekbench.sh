#!/bin/bash

if ! command -v geekbench6 &> /dev/null; then
  echo "Installing Geekbench..."
  GB_VERSION="6.3.0"
  cd /tmp
  curl -sLo geekbench.tar.gz "https://cdn.geekbench.com/Geekbench-${GB_VERSION}-Linux.tar.gz"
  tar -xf geekbench.tar.gz
  sudo rm -rf /opt/Geekbench-${GB_VERSION}-Linux
  sudo mv Geekbench-${GB_VERSION}-Linux /opt/
  sudo ln -sf /opt/Geekbench-${GB_VERSION}-Linux/geekbench6 /usr/local/bin/geekbench6
  rm geekbench.tar.gz
  cd -
else
  echo "Geekbench is already installed, skipping."
fi
