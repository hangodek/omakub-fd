#!/bin/bash

# Install GitHub CLI for Fedora
sudo dnf install -y dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo --overwrite
sudo dnf install -y gh --repo gh-cli
