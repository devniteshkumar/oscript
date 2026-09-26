#!/usr/bin/env bash
set -euo pipefail
dcol="$1"
template_path="${2:-$HOME/.config/wallbash}"
[ -f "$dcol" ] || { echo "dcol file not found: $dcol"; exit 1; }
source "$dcol"
mkdir -p "$HOME/.config/kitty" "$HOME/.config/waybar" "$HOME/.config/rofi" "$HOME/.config/wlogout"
cat > "$HOME/.config/kitty/colors.conf" <<EOF
foreground #${dcol_txt1}
background #${dcol_pry1}
cursor #${dcol_pry4}
color0 #${dcol_pry1}
color7 #${dcol_txt1}
color8 #${dcol_pry2}
color15 #${dcol_txt4}
EOF
cat > "$HOME/.config/waybar/colors.css" <<EOF
@define-color bar-bg rgba(27,27,41,0.75);
@define-color bar-fg rgba(248,248,255,0.85);
@define-color bar-solid-bg rgba(27,27,41,1);
@define-color accent-bg rgba(62,58,107,0.60);
@define-color accent-fg rgba(248,248,255,0.65);
@define-color hover-bg rgba(62,58,107,0.8);
@define-color hover-alt-bg rgba(62,58,107,0.6);
@define-color icons-fg rgba(30,20,50,1);
@define-color color1 rgba(62,58,107,0.90);
@define-color color2 rgba(44,41,82,1);
@define-color color3 rgba(169,167,190,1);
@define-color color4 rgba(62,58,107,0.90);
@define-color color5 rgba(44,41,82,0.95);
@define-color color6 rgba(44,41,82,1);
@define-color color7 rgba(44,41,82,0.95);
@define-color color8 rgba(169,167,190,0.95);
@define-color accent-color rgba(248,248,255,1);
EOF
cat > "$HOME/.config/rofi/colors.rasi" <<EOF
* {
 main-bg: #1B1B29E4;
 main-fg: #F8F8FFE6;
 main-br: #A9A7BEF6;
 main-ex: #2C2952E6;
 select-bg: #3E3A6B80;
 select-fg: #F8F8FFE6;
}
EOF
cat > "$HOME/.config/wlogout/colors.css" <<EOF
@define-color win-bg rgba(27,27,41,0.25);
@define-color btn-bg rgba(27,27,41,0.85);
@define-color hover-bg rgba(44,41,82,0.90);
@define-color focus-bg rgba(44,41,82,0.90);
EOF
