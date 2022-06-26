#!/bin/bash

locktime=$1
screenofftime=$2
lockcmd="$3 -f"

swayidle -w \
    timeout $locktime "$lockcmd" \
    timeout $screenofftime 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    before-sleep "$lockcmd"