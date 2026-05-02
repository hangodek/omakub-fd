#!/bin/bash

mkdir -p ~/.local/share/fonts

if ! ls ~/.local/share/fonts/Caskaydia* &> /dev/null && ! ls ~/.local/share/fonts/Cascadia* &> /dev/null; then
  echo "Installing Cascadia fonts..."
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
  unzip CascadiaMono.zip -d CascadiaFont
  cp CascadiaFont/*.ttf ~/.local/share/fonts
  rm -rf CascadiaMono.zip CascadiaFont
  cd -
else
  echo "Cascadia fonts already installed, skipping."
fi

if ! ls ~/.local/share/fonts/iAWriterMonoS-*.ttf &> /dev/null; then
  echo "Installing iA-Fonts..."
  cd /tmp
  wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip iafonts.zip -d iaFonts
  cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
  rm -rf iafonts.zip iaFonts
  cd -
else
  echo "iA-Fonts already installed, skipping."
fi

if ! ls ~/.local/share/fonts/Arial.ttf &> /dev/null && ! ls ~/.local/share/fonts/arial.ttf &> /dev/null; then
  echo "Installing Microsoft Fonts..."
  cd /tmp
  git clone https://github.com/FSKiller/Microsoft-Fonts.git msfonts
  cp -r msfonts/*.ttf msfonts/*.TTF ~/.local/share/fonts/ 2>/dev/null || true
  rm -rf msfonts
  cd -
else
  echo "Microsoft Fonts already installed, skipping."
fi

fc-cache
