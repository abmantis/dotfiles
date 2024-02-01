#!/bin/bash

locktime=$1
screenofftime=$2
lockcmd=$3

let notifytime=$locktime-5 
swayidle -w \
    timeout $locktime "$lockcmd" \
    timeout $screenofftime 'hyprctl dispatch dpms off' \
        resume 'hyprctl dispatch dpms on' \
    before-sleep "$lockcmd"
