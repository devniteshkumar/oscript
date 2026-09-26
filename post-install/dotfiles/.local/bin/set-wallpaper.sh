#!/usr/bin/env bash
WALL_DIR="$HOME/.config/awww/wallpapers"
CURRENT_FILE="$HOME/.config/awww/current_wallpaper.txt"
apply_wallpaper() {
  local wallpaper="$1"
  [ "$wallpaper" = random ] && wallpaper="$(find "$WALL_DIR" -type f | shuf -n1)"
  [ -f "$wallpaper" ] || wallpaper="$WALL_DIR/$wallpaper"
  [ -f "$wallpaper" ] || { echo "set-wallpaper: file not found: $wallpaper" >&2; return 1; }
  awww img "$wallpaper" --transition-type fade --transition-fps 60 --transition-duration 1
  basename "$wallpaper" >"$CURRENT_FILE"
}
[ -n "$1" ] && apply_wallpaper "$1"
