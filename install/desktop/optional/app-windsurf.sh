#!/bin/bash

# Install Windsurf for Fedora
sudo rpm --import https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg
echo -e '[windsurf]\nname=Windsurf\nbaseurl=https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/rpm\nenabled=1\ngpgcheck=1\ngpgkey=https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg' | sudo tee /etc/yum.repos.d/windsurf.repo
sudo dnf install -y windsurf
