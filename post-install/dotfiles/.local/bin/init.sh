#!/usr/bin/env bash
set -euo pipefail
WALLPAPER_DIR="$HOME/.config/awww/wallpapers"
mkdir -p "$HOME/.config/awww/colors" "$HOME/.cache/wallpaper-selector"
echo "Rice initialized. Add wallpapers to $WALLPAPER_DIR and run set-wallpaper.sh."
if find "$WALLPAPER_DIR" -maxdepth 1 -type f | grep -q .; then
  set-wallpaper.sh random || true
fi
