#!/bin/bash

#!/bin/bash

# Install Typora using RPM package for Fedora
cd /tmp
wget -O typora.rpm "https://downloads.typora.io/linux/typora-1.10.8.x86_64.rpm"
sudo dnf install -y ./typora.rpm
rm typora.rpm
cd -

# Add iA Typora theme
mkdir -p ~/.config/Typora/themes
cp ~/.local/share/omakub/configs/typora/ia_typora.css ~/.config/Typora/themes/
cp ~/.local/share/omakub/configs/typora/ia_typora_night.css ~/.config/Typora/themes/
