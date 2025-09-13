#!/bin/bash

sudo dnf remove -y VirtualBox
sudo dnf autoremove -y
rm -rf ~/.config/VirtualBox
