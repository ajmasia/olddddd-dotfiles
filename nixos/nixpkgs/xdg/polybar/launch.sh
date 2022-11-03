#!/usr/bin/env bash

DIR="$HOME/.config/polybar"
# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

is_external_monitor_connected=$(xrandr --query | grep 'HDMI-1 connected')

if [[ $is_external_monitor_connected == "" ]]; then
  polybar -q main-laptop -c "$DIR"/config.ini & 
else
  polybar -q main-home -c "$DIR"/config.ini &
  polybar -q secondary-laptop -c "$DIR"/config.ini &
fi
