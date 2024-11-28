#!/bin/bash

set_nvim () {
    nvim --server $1 --remote-expr "execute(\"set background=$2\")" 1>/dev/null
}

set_light () {
    kitty +kitten themes --config-file-name theme.conf --reload-in=all Edge-light &
    pkill -SIGUSR1 kitty
    find $XDG_RUNTIME_DIR -name "nvim.*" 2>/dev/null | while read file; do set_nvim "$file" "light"; done &
    find /tmp/nvim.$USER/ -type s 2>/dev/null | while read file; do set_nvim "$file" "light"; done &
}

set_dark () {
    kitty +kitten themes --config-file-name theme.conf --reload-in=all Edge-neon &
    pkill -SIGUSR1 kitty
    find $XDG_RUNTIME_DIR -name "nvim.*" 2>/dev/null | while read file; do set_nvim "$file" "dark"; done &
    find /tmp/nvim.$USER/ -type s 2>/dev/null | while read file; do set_nvim "$file" "dark"; done &
}


gsettings monitor org.gnome.desktop.interface color-scheme | while read scheme
do
    if [[ $scheme == *light* ]]; then
        set_light
    else
        set_dark
    fi
done
