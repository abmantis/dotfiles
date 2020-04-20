#!/bin/bash

VPN_STATUS=$(barracudavpn -t | sed -n -e 's/^Status:\s* //p')

if [[ "$VPN_STATUS" = "CONNECTED" ]]; then
    TEXT="Connected"
    CLASS="connected"
else
    TEXT="Disconnected"
    CLASS="disconnected"
fi

echo -e "{\"text\":\""$TEXT"\", \"class\":\""$CLASS"\"}"