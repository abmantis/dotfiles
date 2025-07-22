#!/bin/bash

if ! command -v niri &> /dev/null; then
    echo "Error: niri command not found."
    exit 1
fi


output_status=$(niri msg -j outputs | jq -r 'if .["eDP-1"].current_mode != null then "ON" else "OFF" end')

if [ -z "$output_status" ]; then
    echo "Error: Could not find eDP-1 output or determine its status."
    echo "Available outputs:"
    niri msg outputs | grep -E "^[A-Za-z0-9-]+" | sed 's/://'
    exit 1
fi

echo "Current eDP-1 status: $output_status"

if [ "$output_status" = "ON" ]; then
    echo "Disabling eDP-1..."
    niri msg output eDP-1 off
    if [ $? -eq 0 ]; then
        echo "eDP-1 disabled successfully."
    else
        echo "Failed to disable eDP-1."
        exit 1
    fi
else
    echo "Enabling eDP-1..."
    niri msg output eDP-1 on
    if [ $? -eq 0 ]; then
        echo "eDP-1 enabled successfully."
    else
        echo "Failed to enable eDP-1."
        exit 1
    fi
fi
