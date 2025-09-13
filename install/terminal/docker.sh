#!/bin/bash

# Add the official Docker repo for Fedora (dnf4 and dnf5 compatibility)
DOCKER_REPO_URL="https://download.docker.com/linux/fedora/docker-ce.repo"
if dnf --version 2>/dev/null | grep -q '^5\.'; then
	if command -v dnf5 >/dev/null 2>&1; then
		sudo dnf5 config-manager addrepo "$DOCKER_REPO_URL"
	else
		sudo dnf config-manager addrepo "$DOCKER_REPO_URL"
	fi
else
	sudo dnf config-manager --add-repo "$DOCKER_REPO_URL"
fi

# Install Docker engine and standard plugins
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Give this user privileged Docker access
sudo usermod -aG docker ${USER}

# Limit log size to avoid running out of disk
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json
