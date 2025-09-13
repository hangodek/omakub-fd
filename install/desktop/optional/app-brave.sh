#!/bin/bash

# Install Brave Browser for Fedora
sudo dnf install -y dnf-plugins-core

# dnf5 removed the old "config-manager --add-repo" syntax. Support both.
BRAVE_REPO_URL="https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo"

if dnf --version 2>/dev/null | grep -q '^5\.'; then
	# dnf5: use "dnf5 config-manager addrepo <url>" form (some builds keep the dnf symlink)
	if command -v dnf5 >/dev/null 2>&1; then
		sudo dnf5 config-manager addrepo "$BRAVE_REPO_URL"
	else
		# fallback in case only 'dnf' command exists but is version 5
		sudo dnf config-manager addrepo "$BRAVE_REPO_URL"
	fi
else
	# dnf4 and earlier
	sudo dnf config-manager --add-repo "$BRAVE_REPO_URL"
fi

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser
