#!/usr/bin/env bash

# use pywal colours, but don't set the terminal theme
wal -R -s

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi
