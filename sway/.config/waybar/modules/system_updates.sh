#!/bin/bash

. /etc/os-release
OS_NAME=$NAME

HAS_UPDATES_ICON=
UPDATE_COUNT=0
REBOOT_REQUIRED=0

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
    # count how many updates we have got
    UPDATE_COUNT=`/usr/lib/update-notifier/apt-check --human-readable | head -1 | awk '{print $1;}'`

    if [ -f /var/run/reboot-required ]; then
        REBOOT_REQUIRED=1
    fi
fi

if [[ $REBOOT_REQUIRED = 1 ]]; then
    echo -e "{\"text\":\""$HAS_UPDATES_ICON"\", \"class\":\"restart\", \"tooltip\":\"A system restart is required.\"}" 
elif [ "$UPDATE_COUNT" -gt "0" ]; then
    echo -e "{\"text\":\""$HAS_UPDATES_ICON"\", \"class\":\"update\", \"tooltip\":\"There are $UPDATE_COUNT updates\"}"
else
    echo -e "{\"text\":\"\", \"class\":\"uptodate\"}"
fi
