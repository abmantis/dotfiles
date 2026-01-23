#!/bin/bash

gtk3Theme="adw-gtk3-dark"
iconTheme="Adwaita"
colorScheme="prefer-dark"

gsettings set org.gnome.desktop.interface gtk-theme $gtk3Theme
gsettings set org.gnome.desktop.interface icon-theme $iconTheme
gsettings set org.gnome.desktop.interface color-scheme $colorScheme
gsettings set org.gnome.desktop.interface cursor-theme $XCURSOR_THEME
gsettings set org.gnome.desktop.interface cursor-size $XCURSOR_SIZE

gsettings set org.gnome.desktop.interface font-name "Fira Sans Book 10"
gsettings set org.gnome.desktop.interface document-font-name "Liberation Sans 11"
gsettings set org.gnome.desktop.interface monospace-font-name "CommitMono 11"
