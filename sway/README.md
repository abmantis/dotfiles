# Components:
- Waybar
- swaylock and swayidle
- wofi
- swaybg
- mako
- grim (for screenshots)
- slurp (for screenshots)
- wl-copy (for screenshots)
- swappy (for screenshots)
- gammastep (optional for redshift-like functionality)
- jq (used in some commands)
- wlogout (nice logout menu)

# Deps:
- lxpolkit
- pavucontrol
- brightnessctl (don't forget the udev rules, add the user to the "video" group and reboot)

# Install the Ubuntu nerd font for bar icons:
- Download a [Ubuntu Nerd Font](http://nerdfonts.com/)
- Unzip and copy to `~/.fonts`
- Run the command `fc-cache -fv` to manually rebuild the font cache

# Using Gnome Keyring with Chrome
Chrome must be launched with `--password-store=gnome` for it to use the Gnome Keyring to store passwords. For this to work seamlessly, copy the desktop file to the user folder:
`cp /usr/share/applications/google-chrome.desktop .local/share/applications/`
Then edit this and add `--password-store=gnome` to the varios `Exec` lines.

For ssh keys with passphrases, add the following to the `.bash_profile`:
```
# Gnome keyring setup for SSH
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
```

# Setting env vars for sway:
Copy the files in `sway/.config/environment.d/` file files to `~/.config/environment.d/`.

# Sway non-generic configs:
Non-generic configs (ones that are specific to a machine), go into the sway/available_configs directory. Each machine creates a link (ln -s) inside the sway/enabled_configs dir to their specific config file.
