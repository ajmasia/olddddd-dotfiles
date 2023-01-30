#!/usr/bin/env bash

DIR="$HOME/.config/polybar"
# Terminate already running bar instances
# pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

laptop_screen_state=$(bat /proc/acpi/button/lid/LID1/state | awk '{print $2}')
is_external_monitor_connected=$(xrandr --query | grep 'HDMI-A-0 connected')

echo $laptop_screen_state
echo $is_external_monitor_connected

if [[ $is_external_monitor_connected == "" ]]; then
  polybar -q main-laptop -c "$DIR"/config.ini & 
elif [[ $laptop_screen_state == "open" ]]; then
  xrandr --output HDMI-A-0 --primary --output eDP --auto --left-of HDMI-A-0
  polybar -q main-home -c "$DIR"/config.ini &
  # polybar -q secondary-laptop -c "$DIR"/config.ini &
else
  xrandr --output eDP --off
  polybar -q external -c "$DIR"/config.ini &
fi
