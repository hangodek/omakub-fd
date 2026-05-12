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

ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"
ZELLIJ_THEMES_DIR="$ZELLIJ_CONFIG_DIR/themes"

mkdir -p "$ZELLIJ_THEMES_DIR"

if [ ! -f "$ZELLIJ_CONFIG_DIR/config.kdl" ]; then
  cp "$OMAKUB_PATH/configs/zellij.kdl" "$ZELLIJ_CONFIG_DIR/config.kdl"
fi

for dir in "$OMAKUB_PATH"/themes/*; do
  if [ -d "$dir" ] && [ -f "$dir/zellij.kdl" ]; then
    theme_name=$(basename "$dir")
    cp "$dir/zellij.kdl" "$ZELLIJ_THEMES_DIR/$theme_name.kdl"
  fi
done
