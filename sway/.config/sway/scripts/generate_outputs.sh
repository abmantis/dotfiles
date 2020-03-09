#!/bin/bash

#swaymsg -t get_outputs

OUTPUTS_GEN_FILE=$HOME/.config/sway/enabled_configs/outputs_gen.conf

# Clean file
echo '' > $OUTPUTS_GEN_FILE

CURR_OUTPUTS_LIST=$(swaymsg -t get_outputs | jq -r '.[] | "\(.make) \(.model) \(.serial)"')

if grep -Fxq "Ancor Communications Inc ASUS ML239 BBLMIB518036" <<< $CURR_OUTPUTS_LIST
then
    # Setup outputs
    echo '
        output eDP-1 pos 0 0
        output "Ancor Communications Inc ASUS ML239 BBLMIB518036" pos 1920 0
        ' \
    >> $OUTPUTS_GEN_FILE

    # Set outputs for each workspace
    echo '
        set $wsbsoutput eDP-1
        set $ws1output  "Ancor Communications Inc ASUS ML239 BBLMIB518036" 
        set $ws2output  "Ancor Communications Inc ASUS ML239 BBLMIB518036" 
        set $ws3output  "Ancor Communications Inc ASUS ML239 BBLMIB518036" 
        set $ws4output  "Ancor Communications Inc ASUS ML239 BBLMIB518036" 
        set $ws5output  "Ancor Communications Inc ASUS ML239 BBLMIB518036" 
        set $ws6output  "Ancor Communications Inc ASUS ML239 BBLMIB518036" 
        set $ws7output  eDP-1
        set $ws8output  eDP-1
        set $ws9output  eDP-1
        set $ws10output eDP-1
        ' \
    >> $OUTPUTS_GEN_FILE
elif grep -Fxq "Dell Inc. DELL U2417H 5K9YD83VB68L" <<< $CURR_OUTPUTS_LIST
then
    # Setup outputs
    echo '
        output eDP-1 pos 0 0
        output "Dell Inc. DELL U2419H 611KRS2" pos 1920 0
        output "Dell Inc. DELL U2417H 5K9YD83VB68L" pos 3840 0
        ' \
    >> $OUTPUTS_GEN_FILE

    # Set outputs for each workspace
    echo '
        set $wsbsoutput eDP-1
        set $ws1output  "Dell Inc. DELL U2419H 611KRS2"
        set $ws2output  "Dell Inc. DELL U2417H 5K9YD83VB68L"
        set $ws3output  "Dell Inc. DELL U2419H 611KRS2"
        set $ws4output  "Dell Inc. DELL U2419H 611KRS2"
        set $ws5output  "Dell Inc. DELL U2419H 611KRS2"
        set $ws6output  "Dell Inc. DELL U2419H 611KRS2"
        set $ws7output  "Dell Inc. DELL U2417H 5K9YD83VB68L"
        set $ws8output  "Dell Inc. DELL U2417H 5K9YD83VB68L"
        set $ws9output  "Dell Inc. DELL U2417H 5K9YD83VB68L"
        set $ws10output eDP-1
        ' \
    >> $OUTPUTS_GEN_FILE
else
    # Set outputs for each workspace
    echo '
        set $wsbsoutput eDP-1
        set $ws1output  eDP-1
        set $ws2output  eDP-1
        set $ws3output  eDP-1
        set $ws4output  eDP-1
        set $ws5output  eDP-1
        set $ws6output  eDP-1
        set $ws7output  eDP-1
        set $ws8output  eDP-1
        set $ws9output  eDP-1
        set $ws10output eDP-1
        ' \
    >> $OUTPUTS_GEN_FILE
fi

# reload sway
swaymsg reload
