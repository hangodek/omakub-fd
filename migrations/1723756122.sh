#!/bin/bash

# Uninstall Vitals
if [ -n "$(gnome-extensions list | grep Vitals@CoreCoding.com)" ]; then
  gnome-extensions uninstall Vitals@CoreCoding.com
fi

# TopHat extension removed.

# Logout
gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt
