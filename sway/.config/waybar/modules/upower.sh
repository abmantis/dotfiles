#!/bin/bash

BATTERY=0
DISPLAYDEVICE=$(upower -e | grep 'DisplayDevice')
UPOWER_DATA=$(upower -i ${DISPLAYDEVICE})
BATTERY_STATE=$(echo "${UPOWER_DATA}" | grep -E "state|to\ full" | awk '{print $2}')
BATTERY_POWER=$(echo "${UPOWER_DATA}" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
BATTERY_TIME=$(echo "${UPOWER_DATA}" | grep -E "time\ to\ empty" | awk '{print $4}{print $5}')
URGENT_VALUE=10

printf -v BATTERY_POWER_INT %.0f "$BATTERY_POWER"

if [[ "${BATTERY_POWER_INT}" -gt 87 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -gt 63 ]]; then
     BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -gt 38 ]]; then
     BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -gt 13 ]]; then
     BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -le 13 ]]; then
     BATTERY_ICON=""
else
    BATTERY_ICON=""
fi


if [[ "${BATTERY_STATE}" != "discharging" ]]; then
    BATTERY_ICON=""
fi

if [[ "${BATTERY_POWER_INT}" -le 15 ]]; then
    CLASS="low"
else
    CLASS="normal"
fi

echo -e "{\"text\":\""$BATTERY_ICON $BATTERY_POWER_INT%"\", \"class\":\""$CLASS"\", \"tooltip\":\"Remaining: "$BATTERY_TIME"\"}"
