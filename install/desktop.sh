#!/bin/bash

# Run snap installer first when needed
OMAKUB_ROOT="${OMAKUB_PATH:-$HOME/.local/share/omakub}"
SNAP_INSTALLER="$OMAKUB_ROOT/install/desktop/a-snap.sh"

if ! command -v snap &> /dev/null; then
	source "$SNAP_INSTALLER"
fi

# Run desktop installers
for installer in "$OMAKUB_ROOT"/install/desktop/*.sh; do
	[[ "$installer" == "$SNAP_INSTALLER" ]] && continue
	source "$installer"
done

# Logout to pickup changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot || true
