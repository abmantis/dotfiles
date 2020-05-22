#!/bin/bash

POMO_OUTPUT=$(~/.config/waybar/modules/pomo.sh clock)
POMO_STATUS=$(echo "$POMO_OUTPUT" | cut -c-2)
POMO_MINUTES=$(echo "$POMO_OUTPUT" | cut -c3-4)
POMO_SECONDS=$(echo "$POMO_OUTPUT" | cut -c6-7)

ICON=""
TEXT=""
REMAINING="--:--"
if [ "$POMO_STATUS" = " W" ]; then
    STATUS="Work"
    CLASS="work"
elif [ "$POMO_STATUS" = " B" ]; then
    STATUS="Break"
    CLASS="break"
    ICON=""
elif [ "$POMO_STATUS" = "  " ]; then
    STATUS="Stoped"
    CLASS="stoped"
else
    STATUS="Paused"
    CLASS="paused"
fi

if [[ "$STATUS" =~ ^(Work|Break)$ ]]; then
    TEXT=$(($POMO_MINUTES + 1))
    REMAINING="$POMO_MINUTES:$POMO_SECONDS"
fi

printf '{"text":"%s %s","tooltip":"%s (%s)","class":"%s"}\n' \
        "$ICON" "$TEXT" "$STATUS" "$REMAINING" "$CLASS"
exit 0

BATTERY=0
DISPLAYDEVICE=$(upower -e | grep 'DisplayDevice')
UPOWER_DATA=$(upower -i ${DISPLAYDEVICE})
BATTERY_STATE=$(echo "${UPOWER_DATA}" | grep -E "state|to\ full" | awk '{print $2}')
BATTERY_POWER=$(echo "${UPOWER_DATA}" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
BATTERY_TIME=$(echo "${UPOWER_DATA}" | grep -E "time\ to\ empty" | awk '{print $4 " " $5}')

printf -v BATTERY_POWER_INT %.0f "$BATTERY_POWER"

if [[ "${BATTERY_POWER_INT}" -gt 90 ]]; then
    BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -gt 60 ]]; then
     BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -gt 40 ]]; then
     BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -gt 15 ]]; then
     BATTERY_ICON=""
elif [[ "${BATTERY_POWER_INT}" -le 15 ]]; then
     BATTERY_ICON=""
else
    BATTERY_ICON=""
fi

if [[ "${BATTERY_STATE}" != "discharging" ]]; then
    BATTERY_ICON=""
fi

STATUS="Paused"
if [[ "${BATTERY_POWER_INT}" -le 15 ]]; then
    CLASS="low"
    TEXT="$BATTERY_ICON $BATTERY_POWER_INT%"
elif [[ "${BATTERY_POWER_INT}" -le 65 ]]; then
    CLASS="mid"
    TEXT="$BATTERY_ICON $BATTERY_POWER_INT%"
else
    CLASS="high"
    TEXT="$BATTERY_ICON"
fi

printf '{"text":"%s","tooltip":"Remaining: %s%% (%s)","class":"%s"}\n' \
			"$TEXT" "$BATTERY_POWER_INT" "$BATTERY_TIME"  "$CLASS"
