#!/bin/bash

while read -r uuid
do
    info=`bluetoothctl info $uuid`
    if echo "$info" | grep -q "Connected: yes" && echo "$info" | grep -q "UUID: Headset" && echo "$info" | grep -q "Battery Percentage"; then
       NAME=$(echo "$info" | grep "Name" | cut -d " " -f2-)
       BATTERY=$(echo "$info" | grep "Battery Percentage" | cut -d "(" -f2 | cut -d ")" -f1) 
       break
    fi
done <<< "$(bluetoothctl paired-devices | cut -f2 -d' ')"

if [ -z "$BATTERY" ]; then
    printf '{}\n'
    exit
fi

BATTERY_ICON=""
if [[ "${BATTERY}" -le 15 ]]; then
    CLASS="low"
    TEXT="$BATTERY_ICON $BATTERY%"
elif [[ "${BATTERY}" -le 30 ]]; then
    CLASS="mid"
    TEXT="$BATTERY_ICON $BATTERY%"
else
    CLASS="high"
    TEXT="$BATTERY_ICON"
fi

printf '{"text":"%s","tooltip":"%s Battery: %s%%","class":"%s"}\n' \
			"$TEXT" "$NAME" "$BATTERY" "$CLASS"
