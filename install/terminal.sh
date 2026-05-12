#!/bin/bash

OMAKUB_ROOT="${OMAKUB_PATH:-$HOME/.local/share/omakub}"
BASE_INSTALLER="$OMAKUB_ROOT/install/terminal/set-base.sh"

# Apply base optimizations before updates
source "$BASE_INSTALLER"

# Needed for all installers
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install -y curl git unzip

# Run terminal installers
for installer in "$OMAKUB_ROOT"/install/terminal/*.sh; do
	[[ "$installer" == "$BASE_INSTALLER" ]] && continue
	source "$installer"
done
