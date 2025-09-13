#!/bin/bash

sudo dnf remove -y neovim
rm ~/.local/share/applications/Neovim.desktop
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
