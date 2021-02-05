#!/bin/bash

locktime=$1
screenofftime=$2
lockcmd="$3 -f"

let notifytime=$locktime-5 
swayidle -w \
    timeout $notifytime 'notify-send -t 5000 Sway "Screen locking soon" -c critical' \
    timeout $locktime "$lockcmd" \
    timeout $screenofftime 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    before-sleep "$lockcmd"