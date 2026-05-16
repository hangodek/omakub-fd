#!/bin/bash

OMAKUB_ROOT="${OMAKUB_PATH:-$HOME/.local/share/omakub}"
BASE_INSTALLER="$OMAKUB_ROOT/install/terminal/set-base.sh"
RPMFUSION_INSTALLER="$OMAKUB_ROOT/install/terminal/set-rpmfusion.sh"
POST_INSTALLER="$OMAKUB_ROOT/install/terminal/set-fedora-post.sh"

# Apply base optimizations first (DNF tuning, boot tweaks, etc.)
source "$BASE_INSTALLER"

# Enable RPM Fusion + Terra BEFORE the main upgrade so new repos are included
source "$RPMFUSION_INSTALLER"

# Main system upgrade + essential tools
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install -y curl git unzip

# Run remaining terminal installers (skip base & rpmfusion & post, already handled)
for installer in "$OMAKUB_ROOT"/install/terminal/*.sh; do
	[[ "$installer" == "$BASE_INSTALLER" ]]    && continue
	[[ "$installer" == "$RPMFUSION_INSTALLER" ]] && continue
	[[ "$installer" == "$POST_INSTALLER" ]]    && continue
	source "$installer"
done

# Post-install tweaks AFTER upgrade: codecs, firmware, VA-API, OpenH264, Flatpak, UTC
source "$POST_INSTALLER"
