#!/usr/bin/env bash
step=5
notify_vol() { notify-send -a volume -t 800 "Volume" "${1}%"; }
change_volume() { pamixer "${srce}" -"${1}" "${2:-$step}"; notify_vol "$(pamixer "${srce}" --get-volume)"; }
toggle_mute() { pamixer "${srce}" -t; notify-send -a volume -t 800 "Volume" "Mute toggled"; }
while getopts "io" opt; do
  case $opt in i) srce="--default-source";; o) srce="";; *) exit 1;; esac
done
shift $((OPTIND - 1))
[ -z "$1" ] && exit 1
case $1 in i|d) change_volume "$1" "${2:-$step}";; m) toggle_mute;; *) exit 1;; esac
