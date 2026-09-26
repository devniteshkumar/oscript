#!/bin/bash
if pkill -x rofi; then exit 0; fi
WALLPAPER_DIR="$HOME/.config/awww/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-selector"
CURRENT_WALLPAPER_FILE="$HOME/.config/awww/current_wallpaper.txt"
mkdir -p "$CACHE_DIR"
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -f "$img" ] || continue
  filename=$(basename "$img"); thumb="$CACHE_DIR/${filename%.*}.png"
  [ ! -f "$thumb" ] || [ "$img" -nt "$thumb" ] && convert "$img" -resize "500x400^" -gravity center -extent "500x400" "$thumb" 2>/dev/null || true
done
options=""
while IFS= read -r img; do
  filename=$(basename "$img"); thumb="$CACHE_DIR/${filename%.*}.png"
  options+="${filename}\0icon\x1f${thumb}\n"
done < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \) -print)
selected=$(echo -en "$options" | rofi -dmenu -i -p "Select Wallpaper" -theme wallpaper-selector -show-icons)
[ -n "$selected" ] && set-wallpaper.sh "$selected"
