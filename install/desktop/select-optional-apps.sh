#!/bin/bash

if [[ -v OMAKUB_FIRST_RUN_OPTIONAL_APPS ]]; then
	apps=$OMAKUB_FIRST_RUN_OPTIONAL_APPS

	if [[ -n "$apps" ]]; then
		OMAKUB_ROOT="${OMAKUB_PATH:-$HOME/.local/share/omakub}"
		SNAP_INSTALLER="$OMAKUB_ROOT/install/desktop/a-snap.sh"

		for app in $apps; do
			script="$OMAKUB_ROOT/install/desktop/optional/app-${app,,}.sh"
			if [[ -f "$script" ]] && grep -q "snap install" "$script"; then
				if ! command -v snap &> /dev/null; then
					source "$SNAP_INSTALLER"
				fi
			fi
			source "$script"
		done
	fi
fi
