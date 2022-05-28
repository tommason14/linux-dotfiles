#!/bin/zsh
# scale 0.9999 to stop pointer flickering

# external display is either DP1 (if plugged in on left side) or DP2 (if plugged in on right side)
connected=$(xrandr | grep ' connected' | awk '{print $1}' | tr '\n' ' ')
[[ $connected =~ DP2 ]] && external=DP2 || external=DP1

xrandr --output eDP1 --primary --mode 2560x1600 --scale 0.9999 --pos 0x0 --rotate normal --output $external --mode 1920x1080 --scale 2 --pos 2560x260 --rotate normal
