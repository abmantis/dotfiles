#!/bin/bash
status=$(systemctl is-failed nixos-upgrade.service)
if [ "$status" = "failed" ]; then
    notify-send -u critical -a "NixOS" "NixOS upgrade failed" \
        "nixos-upgrade.service is in a failed state."
else
    notify-send -u low -a "NixOS" "NixOS upgrade OK" \
        "nixos-upgrade.service status: $status"
fi
