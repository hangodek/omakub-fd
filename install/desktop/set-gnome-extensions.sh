#!/bin/bash

# Install gnome-extensions-app and CLI for easy user extension management later
sudo dnf install -y gnome-extensions-app pipx
pipx install gnome-extensions-cli --system-site-packages

# Turn off default Fedora/GNOME extensions that might conflict
gnome-extensions disable ding@rastersoft.com 2>/dev/null || true

# Pause to assure user is ready to accept confirmations
gum confirm "To install Gnome extensions, you need to accept some confirmations. Ready?"

# Install user extensions
gext install tactile@lundal.io
gext install space-bar@luchrioh
gext install undecorate@sun.wxg@gmail.com
gext install AlphabeticalAppGrid@stuarthayhurst
gext install caffeine@patapon.info
gext install impatience@gfxmonk.net

# Compile gsettings schemas in order to be able to set them
sudo cp ~/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
sudo cp ~/.local/share/gnome-shell/extensions/space-bar\@luchrioh/schemas/org.gnome.shell.extensions.space-bar.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
sudo cp ~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid\@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

has_schema() {
	gsettings list-schemas | grep -qx "$1"
}

set_gsetting() {
	local schema="$1"
	local key="$2"
	shift 2

	if has_schema "$schema" && gsettings list-keys "$schema" 2>/dev/null | grep -qx "$key"; then
		gsettings set "$schema" "$key" "$@"
	else
		echo "Skipping gsettings: $schema $key (schema/key missing)"
	fi
}

# Configure Tactile
set_gsetting org.gnome.shell.extensions.tactile col-0 1
set_gsetting org.gnome.shell.extensions.tactile col-1 2
set_gsetting org.gnome.shell.extensions.tactile col-2 1
set_gsetting org.gnome.shell.extensions.tactile col-3 0
set_gsetting org.gnome.shell.extensions.tactile row-0 1
set_gsetting org.gnome.shell.extensions.tactile row-1 1
set_gsetting org.gnome.shell.extensions.tactile gap-size 32

# Configure AlphabeticalAppGrid
set_gsetting org.gnome.shell.extensions.alphabetical-app-grid folder-order-position "end"
