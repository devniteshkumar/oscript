#!/usr/bin/env bash
set -euo pipefail
wall="$1"; out="${2:-${wall}}.dcol"
[ -f "$wall" ] || { echo "Input file not found: $wall"; exit 1; }
cat > "$out" <<EOF
dcol_mode="dark"
dcol_pry1="1B1B29"
dcol_pry2="2C2952"
dcol_pry3="3E3A6B"
dcol_pry4="A9A7BE"
dcol_txt1="F8F8FF"
dcol_txt2="E8E6F0"
dcol_txt3="C8C5D8"
dcol_txt4="FFFFFF"
EOF
echo "Generated fallback palette: $out"
