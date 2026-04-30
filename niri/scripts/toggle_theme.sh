#!/bin/bash

if [[ $(gsettings get org.gnome.desktop.interface color-scheme) == *light* ]]; then
    dms ipc call theme dark
    niri msg action do-screen-transition --delay-ms 300
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
else
    dms ipc call theme light
    niri msg action do-screen-transition --delay-ms 300
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
fi
