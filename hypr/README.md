# Dependencies

- amixer
- brightnessctl
- chayang
- gammastep
- grim
- playerctl
- pulsemixer
- slurp
- swappy
- swayidle
- swaylock
- swaync
- waybar
- wofi

# Tips

## Make SSH use password from Gnome Keyring for keys

Add the following to your `.bashrh`:

```bash
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start 2>/dev/null)
    export SSH_AUTH_SOCK
fi
```
