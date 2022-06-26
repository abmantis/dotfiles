#!/bin/bash

BATTERY=0
DEVICE=$(upower -e | grep 'headset_dev' | head -n 1)

if [[ -z "$DEVICE" ]]; then
    printf '{}\n'
    exit
fi

UPOWER_DATA=$(upower -i ${DEVICE})
DEVICE_NAME=$(echo "${UPOWER_DATA}" | grep -E "model" | awk '{print $2}' | tr -d '%')
BATTERY_POWER=$(echo "${UPOWER_DATA}" | grep -E "percentage" | awk '{print $2}' | tr -d '%')

printf -v BATTERY_POWER_INT %.0f "$BATTERY_POWER"

BATTERY_ICON=""

if [[ "${BATTERY_POWER_INT}" -le 15 ]]; then
    CLASS="low"
    TEXT="$BATTERY_ICON $BATTERY_POWER_INT%"
elif [[ "${BATTERY_POWER_INT}" -le 30 ]]; then
    CLASS="mid"
    TEXT="$BATTERY_ICON $BATTERY_POWER_INT%"
else
    CLASS="high"
    TEXT="$BATTERY_ICON"
fi

printf '{"text":"%s","tooltip":"%s remaining: %s%%","class":"%s"}\n' \
			"$TEXT" "$DEVICE_NAME" "$BATTERY_POWER_INT" "$CLASS"
