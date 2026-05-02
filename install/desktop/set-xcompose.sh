#!/bin/bash

envsubst < ~/.local/share/omakub/configs/xcompose > ~/.XCompose
ibus restart
# Keep Caps Lock as normal Caps Lock instead of mapping it to compose key for emojis
gsettings set org.gnome.desktop.input-sources xkb-options "[]"
