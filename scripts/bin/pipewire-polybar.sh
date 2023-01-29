#!/bin/bash
info=$(amixer sget Master | grep "Front Left" | tail -1)

if [[ $info =~ "off" ]]; then
    echo "muted"
else
    echo "$info" | awk '{print $(NF-1)}' | sed 's/[][]//g'
fi 
