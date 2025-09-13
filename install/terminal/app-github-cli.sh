#!/bin/bash

# Install GitHub CLI for Fedora (dnf4/dnf5 compatible)
GH_REPO_URL="https://cli.github.com/packages/rpm/gh-cli.repo"
if dnf --version 2>/dev/null | grep -q '^5\.'; then
	if command -v dnf5 >/dev/null 2>&1; then
		sudo dnf5 config-manager addrepo "$GH_REPO_URL"
	else
		sudo dnf config-manager addrepo "$GH_REPO_URL"
	fi
else
	sudo dnf config-manager --add-repo "$GH_REPO_URL"
fi
sudo dnf install -y gh
