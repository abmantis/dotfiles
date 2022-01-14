#!/bin/bash

SINK=$(pactl info | grep "Default Sink" | cut -d " " -f3-)
CARD=$(echo $SINK | cut -d "." -f2)
CARD="bluez_card.$CARD"

if [[ "$SINK" == *"a2dp-sink"* ]]; then
    pactl set-card-profile $CARD headset-head-unit
elif [[ "$SINK" == *"headset-head-unit"* ]]; then
    pactl set-card-profile $CARD a2dp-sink
fi

