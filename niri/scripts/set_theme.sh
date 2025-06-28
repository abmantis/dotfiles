#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme $gtk3Theme
gsettings set org.gnome.desktop.interface icon-theme $iconTheme
gsettings set org.gnome.desktop.interface color-scheme $colorScheme
gsettings set org.gnome.desktop.interface cursor-theme $XCURSOR_THEME
gsettings set org.gnome.desktop.interface cursor-size $XCURSOR_SIZE

gsettings set org.gnome.desktop.interface font-name "Ubuntu 11"
gsettings set org.gnome.desktop.interface monospace-font-name "Commit Mono 11"
gsettings set org.gnome.desktop.interface document-font-name "Ubuntu 11"
