#!/bin/sh
# scale 0.9999 to stop pointer flickering
xrandr --output eDP1 --primary --mode 2560x1600 --scale 0.9999x0.9999 --pos 0x0 --rotate normal --output DP1 --mode 1920x1080 --scale 2x2 --pos 2560x260 --rotate normal
