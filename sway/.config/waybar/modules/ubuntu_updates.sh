#!/bin/bash

# count how many updates we have got
ups=`/usr/lib/update-notifier/apt-check --human-readable | head -1 | awk '{print $1;}'`

HAS_UPDATES_ICON=

if [ -f /var/run/reboot-required ]; then
    echo -e "{\"text\":\""$HAS_UPDATES_ICON"\", \"class\":\"restart\", \"tooltip\":\"A system restart is required.\"}" 
elif [ "$ups" -gt "0" ]; then
    echo -e "{\"text\":\""$HAS_UPDATES_ICON"\", \"class\":\"update\", \"tooltip\":\"There are $ups updates\"}"
else
    echo -e "{\"text\":\"\", \"class\":\"uptodate\"}"
fi
