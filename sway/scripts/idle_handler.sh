#!/bin/bash

locktime=$1
screenofftime=$2
lockcmd=$3
presleepcmd=$4

let notifytime=$locktime-5 
swayidle -w \
    timeout $locktime "$lockcmd" \
    timeout $screenofftime 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    before-sleep "swaylock -f"
