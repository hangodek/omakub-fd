#!/bin/bash

# Install RyzenAdj only when a Ryzen CPU is detected.
if ! lscpu | grep -qi "ryzen"; then
  echo "Skipping RyzenAdj: Ryzen CPU not detected."
  exit 0
fi

if ! command -v ryzenadj >/dev/null 2>&1; then
  sudo dnf install -y cmake gcc-c++ pciutils-devel

  BUILD_DIR=$(mktemp -d)
  trap 'rm -rf "$BUILD_DIR"' EXIT

  git clone https://github.com/FlyGoat/RyzenAdj "$BUILD_DIR/RyzenAdj"
  cmake -S "$BUILD_DIR/RyzenAdj" -B "$BUILD_DIR/RyzenAdj/build" -DCMAKE_BUILD_TYPE=Release
  make -C "$BUILD_DIR/RyzenAdj/build" -j"$(nproc)"
  sudo cp -v "$BUILD_DIR/RyzenAdj/build/ryzenadj" /usr/local/bin/
else
  echo "RyzenAdj already installed."
fi

if gum confirm "Set RyzenAdj power/temperature limits and apply them on boot/resume?"; then
  echo "Leave a field empty to skip setting that limit."
  STAPM_LIMIT=$(gum input --placeholder "25000" --prompt "STAPM limit (mW)> ")
  FAST_LIMIT=$(gum input --placeholder "25000" --prompt "PPT fast limit (mW)> ")
  SLOW_LIMIT=$(gum input --placeholder "25000" --prompt "PPT slow limit (mW)> ")
  TCTL_LIMIT=$(gum input --placeholder "85" --prompt "Tctl temp limit (C)> ")

  sudo tee /etc/ryzenadj.conf > /dev/null <<EOF
STAPM_LIMIT="${STAPM_LIMIT}"
FAST_LIMIT="${FAST_LIMIT}"
SLOW_LIMIT="${SLOW_LIMIT}"
TCTL_LIMIT="${TCTL_LIMIT}"
EOF

  sudo tee /usr/local/bin/omakub-ryzenadj-apply > /dev/null <<'EOF'
#!/bin/bash

if [[ -f /etc/ryzenadj.conf ]]; then
  source /etc/ryzenadj.conf
fi

args=()
if [[ -n "$STAPM_LIMIT" ]]; then args+=("-a" "$STAPM_LIMIT"); fi
if [[ -n "$FAST_LIMIT" ]]; then args+=("-b" "$FAST_LIMIT"); fi
if [[ -n "$SLOW_LIMIT" ]]; then args+=("-c" "$SLOW_LIMIT"); fi
if [[ -n "$TCTL_LIMIT" ]]; then args+=("-f" "$TCTL_LIMIT"); fi

if [[ ${#args[@]} -eq 0 ]]; then
  echo "No RyzenAdj limits set; skipping."
  exit 0
fi

ryzenadj "${args[@]}"
EOF
  sudo chmod +x /usr/local/bin/omakub-ryzenadj-apply

  sudo tee /etc/systemd/system/omakub-ryzenadj.service > /dev/null <<'EOF'
[Unit]
Description=Apply RyzenAdj power and temperature limits
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/omakub-ryzenadj-apply

[Install]
WantedBy=multi-user.target
EOF

  sudo tee /usr/lib/systemd/system-sleep/omakub-ryzenadj > /dev/null <<'EOF'
#!/bin/bash

case "$1" in
  post)
    /usr/local/bin/omakub-ryzenadj-apply
    ;;
esac
EOF
  sudo chmod +x /usr/lib/systemd/system-sleep/omakub-ryzenadj

  sudo systemctl daemon-reload
  sudo systemctl enable --now omakub-ryzenadj.service
  sudo /usr/local/bin/omakub-ryzenadj-apply
fi
