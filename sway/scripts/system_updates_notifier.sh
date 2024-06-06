#!/bin/bash

. /etc/os-release
OS_NAME=$NAME

HAS_UPDATES_ICON=
UPDATE_COUNT=0

if [[ "${OS_NAME}" = "Arch Linux" ]]; then
    TMPPATH="${TMPDIR:-/tmp}/checkup-db-${USER}"
    DBPATH="$(pacman-conf DBPath)"

    mkdir -p "$TMPPATH"
    ln -s "$DBPATH/local" "$TMPPATH" &>/dev/null
    fakeroot -- pacman -Sy --dbpath "$TMPPATH" --logfile /dev/null &>/dev/null
    list=`pacman -Qu --dbpath "$TMPPATH" 2>/dev/null`

    if [ "$list" != "" ]; then
        UPDATE_COUNT=`echo "$list" | wc -l`
    fi

else    
    UPDATE_COUNT=`/usr/lib/update-notifier/apt-check --human-readable | head -1 | awk '{print $1;}'`
fi

URGENCY="normal"
if [ "$UPDATE_COUNT" -gt "100" ]; then
    URGENCY="critical"
fi

if [ "$UPDATE_COUNT" -gt "10" ]; then
    ACTION=$(notify-send -u $URGENCY -a Hyprland -i view-refresh-symbolic \
        --action update="Start Update" "System Updates" "There are $UPDATE_COUNT updates available")

    if [ "$ACTION" = "update" ]; then
        if [[ "${OS_NAME}" = "Arch Linux" ]]; then
            kitty --detach yay -Syu
        fi
    fi
fi
