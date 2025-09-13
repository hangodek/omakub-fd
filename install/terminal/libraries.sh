#!/bin/bash

sudo dnf install -y \
  make automake eza gcc gcc-c++ kernel-devel pkg-config autoconf bison clang rust cargo \
  openssl-devel readline-devel zlib-devel libyaml-devel ncurses-devel libffi-devel gdbm-devel jemalloc-devel \
  vips-devel ImageMagick-devel mupdf-devel gobject-introspection-devel \
  redis sqlite sqlite-devel mysql-devel postgresql-devel postgresql
