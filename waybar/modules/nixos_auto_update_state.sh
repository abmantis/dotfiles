#!/bin/bash

# get status using systemctl is-failed
ENABLED_STATUS=$(systemctl is-enabled nixos-upgrade.service)
UPDATE_STATUS=$(systemctl is-failed nixos-upgrade.service)

if [ "$UPDATE_STATUS" = "failed" ] || [ "$ENABLED_STATUS" != "linked" ]; then
    printf '{"text":"", "tooltip":"NixOS update failed","class":"failed"}\n'
elif [ "$UPDATE_STATUS" = "activating" ]; then
    printf '{"text":"", "tooltip":"NixOS is updating","class":"activating"}\n'
elif [ "$UPDATE_STATUS" = "inactive" ]; then
    printf '{"text":"", "tooltip":"NixOS is up to date","class":"inactive"}\n'
else 
    printf '{"text":"?", "tooltip":"NixOS update status unknown","class":"unknown"}\n'
fi

