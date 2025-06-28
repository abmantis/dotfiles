#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

entries=" \t Lock\n󰩈 \t Logout\n󰤄 \t Suspend\n󱉰 \t Hibernate\n󰑐 \t Reboot\n⏻ \t Poweroff"

selected=$(echo -e $entries|wofi --prompt "Type an action" --normal-window --width 250 --height 270 --dmenu\
  --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  lock)
    exec loginctl lock-session;;
  logout)
    exec niri msg action quit;;
  suspend)
    exec systemctl suspend-then-hibernate;;
  hibernate)
    exec systemctl hibernate;;
  reboot)
    exec systemctl reboot;;
  poweroff)
    exec systemctl poweroff -i;;
esac
