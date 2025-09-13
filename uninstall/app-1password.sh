#!/bin/bash

sudo rm -f /etc/yum.repos.d/1password.repo
sudo dnf remove -y 1password 1password-cli
