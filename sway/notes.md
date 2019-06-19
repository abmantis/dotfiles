# Deps:
- lxpolkit
- pavucontrol
- brightnessctl (don't forget the udev rules, add the user to the "video" group and reboot)

# Install the Ubuntu nerd font for bar icons:
- Download a [Ubuntu Nerd Font](http://nerdfonts.com/)
- Unzip and copy to `~/.fonts`
- Run the command `fc-cache -fv` to manually rebuild the font cache