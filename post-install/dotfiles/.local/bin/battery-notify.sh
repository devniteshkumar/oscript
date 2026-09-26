#!/usr/bin/env bash
ICONS_DIR="${XDG_CONFIG_HOME}/mako/icons"
HIGH_THRESHOLD=85
LOW_THRESHOLD=10
INTERVAL=5
if ! grep -q "Battery" /sys/class/power_supply/BAT*/type 2>/dev/null; then exit 0; fi
get_battery_info() {
  local total=0 count=0
  for battery in /sys/class/power_supply/BAT*; do
    battery_status=$(<"$battery/status")
    local capacity=$(<"$battery/capacity")
    total=$((total + capacity)); count=$((count + 1))
  done
  battery_percentage=$((total / count))
}
notify_battery_status() {
  local status=$1 percentage=$2
  case "$status" in
    Discharging)
      if [[ "$prev_status" != "Discharging" ]]; then
        notify-send -a "Battery Monitor" -u normal -i "${ICONS_DIR}/battery-discharging.svg" "Charger Unplugged" "Battery is at ${percentage}%"
        prev_status="Discharging"
      fi
      if [[ $percentage -le $LOW_THRESHOLD ]] && [[ $((last_notified - percentage)) -ge $INTERVAL || $last_notified -eq -1 ]]; then
        notify-send -a "Battery Monitor" -u critical -t 0 -i "${ICONS_DIR}/battery-alert.svg" "Battery Low" "Battery is at ${percentage}%. Please plug in the charger."
        last_notified=$percentage
      fi ;;
    Charging|"Not charging")
      if [[ "$is_first_run" == true ]]; then prev_status="Charging"
      elif [[ "$prev_status" == Discharging ]]; then
        makoctl dismiss -a
        notify-send -a "Battery Monitor" -u normal -i "${ICONS_DIR}/battery-charging.svg" "Charger Plugged In" "Battery is at ${percentage}%"
        prev_status="Charging"
      elif [[ $percentage -ge $HIGH_THRESHOLD ]] && [[ $((percentage - last_notified)) -ge $INTERVAL || $last_notified -eq -1 ]]; then
        notify-send -a "Battery Monitor" -u normal -i "${ICONS_DIR}/battery-charging.svg" "Battery Charged" "Battery is at ${percentage}%. You can unplug the charger."
        last_notified=$percentage
      fi ;;
    Full)
      if [[ "$prev_status" != Full ]]; then
        notify-send -a "Battery Monitor" -u normal -i "${ICONS_DIR}/battery.svg" "Battery Full" "Battery is fully charged. You can unplug the charger."
        prev_status=Full
      fi ;;
  esac
}
get_battery_info
last_notified=-1
prev_status=$battery_status
is_first_run=true
last_status=$battery_status
last_percentage=$battery_percentage
while sleep 5; do
  get_battery_info
  if [ "$battery_status" != "$last_status" ] || [ "$battery_percentage" != "$last_percentage" ]; then
    notify_battery_status "$battery_status" "$battery_percentage"
    is_first_run=false
    last_status=$battery_status
    last_percentage=$battery_percentage
  fi
done
