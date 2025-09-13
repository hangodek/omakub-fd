#!/bin/bash

# Install Java and Minecraft Launcher for Fedora
sudo dnf install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

# Minecraft launcher is best installed via Flatpak on Fedora
flatpak install -y flathub com.mojang.Minecraft
