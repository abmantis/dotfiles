#!/usr/bin/env bash

# Ensure headless_output_stop.sh is called on script exit
trap "$(dirname "$0")/headless_output_stop.sh" EXIT

echo "Select a resolution:"
options=("2560x1440" "1920x1080" "1280x1280" "1280x720" "1024x768" "800x600")
select RESOLUTION in "${options[@]}"; do
    if [[ -n "$RESOLUTION" ]]; then
        echo "You selected $RESOLUTION"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

WIDHT=$(echo "$RESOLUTION" | cut -d'x' -f1)
HEIGHT=$(echo "$RESOLUTION" | cut -d'x' -f2)

# Step 1: Create a new output
swaymsg create_output

# Step 2: Find the name of the newly created output
NEW_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.name | startswith("HEADLESS-")) | .name' | sort | tail -n 1)

# Check if the output was successfully created
if [ -z "$NEW_OUTPUT" ]; then
    echo "Failed to create a new output."
    exit 1
fi

WORKSPACE_NAME="󰊠"
# Step 3: Assign a workspace to the new output
swaymsg workspace $WORKSPACE_NAME output "$NEW_OUTPUT"

# Step 4: Set the resolution for the new output
swaymsg output "$NEW_OUTPUT" resolution "$RESOLUTION"

# Step 5: Set the background color for the new output
swaymsg output "$NEW_OUTPUT" bg "#220900" solid_color

# Step 6: Switch to workspace sshr and then back to the previous workspace
CURRENT_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')
swaymsg workspace $WORKSPACE_NAME
swaymsg workspace "$CURRENT_WORKSPACE"

swaymsg for_window [app_id="at.yrlf.wl_mirror"] floating enable, resize set "$WIDHT" "$HEIGHT"
wl-mirror "$NEW_OUTPUT" &
wl_mirror_pid=$!
sleep 0.1
swaymsg [app_id="at.yrlf.wl_mirror"] resize set "$WIDHT" "$HEIGHT"
sleep 0.1
swaymsg [app_id="at.yrlf.wl_mirror"] border pixel

notify-send "Created new output $NEW_OUTPUT."
wait "$wl_mirror_pid"
