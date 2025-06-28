#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IDLE_LOCK_TIME="${1:-60}"
SCREEN_OFF_TIME="${2:-75}"

LOCK_CMD="$CURRENT_DIR/lock_screen.sh"
IDLE_LOCK_CMD="$CURRENT_DIR/lock_screen.sh &"
SLEEP_LOCK_CMD="$CURRENT_DIR/lock_screen.sh"

swayidle -w \
    timeout $IDLE_LOCK_TIME "$IDLE_LOCK_CMD" \
    timeout $SCREEN_OFF_TIME 'niri msg action power-off-monitors' \
        resume 'niri msg action power-on-monitors' \
    lock "$LOCK_CMD" \
    before-sleep "$SLEEP_LOCK_CMD"
