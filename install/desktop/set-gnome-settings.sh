#!/bin/bash

# Center new windows in the middle of the screen
gsettings set org.gnome.mutter center-new-windows true

# Set fonts (SF Pro & Cascadia)
gsettings set org.gnome.desktop.interface font-name 'SF Pro Text Medium 12'
gsettings set org.gnome.desktop.interface document-font-name 'SF Pro Text 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font 12'

# Font Rendering settings
gsettings set org.gnome.desktop.interface font-hinting 'slight'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface text-scaling-factor 1.40

# Enable fractional scaling and set to 100%
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']" 2>/dev/null || true

# Reveal week numbers in the Gnome calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

# Turn off ambient sensors for setting screen brightness (they rarely work well!)
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

# Disable GNOME App Search and Tracker File Indexing
gsettings set org.gnome.desktop.search-providers disable-external true
gsettings set org.freedesktop.Tracker3.Miner.Files index-recursive-directories "[]" 2>/dev/null || true
gsettings set org.freedesktop.Tracker3.Miner.Files index-single-directories "[]" 2>/dev/null || true
