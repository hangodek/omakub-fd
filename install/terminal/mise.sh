#!/bin/bash

# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
sudo dnf install -y gpg wget curl
sudo rpm --import https://mise.jdx.dev/gpg-key.pub
echo -e '[mise]\nname=mise\nbaseurl=https://mise.jdx.dev/rpm\nenabled=1\ngpgcheck=1\ngpgkey=https://mise.jdx.dev/gpg-key.pub' | sudo tee /etc/yum.repos.d/mise.repo
sudo dnf install -y mise
