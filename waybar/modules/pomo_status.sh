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
