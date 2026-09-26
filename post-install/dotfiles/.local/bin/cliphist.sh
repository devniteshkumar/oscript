#!/bin/bash
if pkill -x rofi; then exit 0; fi
SELECTED_ITEM=$(cliphist list | rofi -dmenu -theme cliphist)
[ -z "$SELECTED_ITEM" ] && exit 0
cliphist decode <<<"$SELECTED_ITEM" | wl-copy
