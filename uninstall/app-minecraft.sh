#!/bin/bash

flatpak uninstall -y com.mojang.Minecraft
sudo dnf remove -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
