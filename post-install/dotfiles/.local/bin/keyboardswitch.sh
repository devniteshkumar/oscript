#!/bin/bash
niri msg action switch-layout next
layMain=$(niri msg keyboard-layouts | grep '^ \*' | sed 's/^ \* [0-9]* //')
notify-send -a keyboard -t 800 "Keyboard" "${layMain}"
