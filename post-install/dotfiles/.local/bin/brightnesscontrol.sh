#!/usr/bin/env bash
step=5
get_brightness() { brightnessctl -m | grep -o '[0-9]\+%' | head -c-2; }
[ -z "$1" ] && exit 1
step="${2:-$step}"
case $1 in
  i) [ "$(get_brightness)" -lt 10 ] && step=1; brightnessctl set +"${step}"% ;;
  d) [ "$(get_brightness)" -le 10 ] && step=1; [ "$(get_brightness)" -le 1 ] && brightnessctl set "${step}%" || brightnessctl set "${step}"%- ;;
  *) exit 1 ;;
esac
notify-send -a brightness -t 800 "Brightness" "$(get_brightness)%"
