#!/usr/bin/env bash

DIR="$HOME/.config/polybar"
# Terminate already running bar instances
# pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

laptop_screen_state=$(bat /proc/acpi/button/lid/LID1/state | awk '{print $2}')
is_external_monitor_connected=$(xrandr --query | grep 'HDMI-1 connected' | awk '{print $1 " " $2}')

pb_set-temp-path &

if [[ $is_external_monitor_connected != "HDMI-1 connected" && $laptop_screen_state == "open" ]]; then
	polybar -q main-laptop -c "$DIR"/config.ini &
	notify-send "Polybar" "Main Laptop bar launched"
	
elif [[ $is_external_monitor_connected == "HDMI-1 connected" && $laptop_screen_state == "open" ]]; then
	xrandr --output HDMI-1 --primary --output eDP-1 --auto --right-of HDMI-1
	polybar -q main-home -c "$DIR"/config.ini &
	polybar -q secondary-laptop -c "$DIR"/config.ini &
	notify-send "Polybar" "Main Home and Secondary Laptop bars launched"
else
	xrandr --output eDP-1 --off
	polybar -q main-home -c "$DIR"/config.ini &
	notify-send "Polybar" "Main Home bar launched"
fi
