#!/bin/bash

#swaymsg -t get_outputs

OUTPUTS_GEN_FILE=$HOME/.config/sway/enabled_configs/outputs_gen.conf

# Clean file
echo '' > $OUTPUTS_GEN_FILE

function write_line {
    echo $1 >> $OUTPUTS_GEN_FILE
}  

CURR_OUTPUTS_LIST=$(swaymsg -t get_outputs | jq -r '.[] | "\(.make) \(.model) \(.serial)"')
CURR_OUTPUT_COUNT=$(swaymsg -t get_outputs | jq -r '.[] | "\(.make) \(.model) \(.serial)"' | wc -l)

# Output positions from left to right
OUTPUT_POS1=""
OUTPUT_POS2=""
OUTPUT_POST3=""

OUTPUT_MAIN=""
OUTPUT_SECUNDARY=""
OUTPUT_EXTRA=""

LAPTOP_MODEL="eDP-1"
ASUS_MODEL="Ancor Communications Inc ASUS ML239 BBLMIB518036"
LG_MODEL="Goldstar Company Ltd LG HDR WFHD 0x0000DEEE"
DELL1_MODEL="Dell Inc. DELL U2419H 10XNRS2"
DELL2_MODEL="Dell Inc. DELL U2417H 5K9YD83VB68L"

if grep -Fxq "$ASUS_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_POS1=$ASUS_MODEL
    OUTPUT_POS2=$LAPTOP_MODEL
    OUTPUT_MAIN=$OUTPUT_POS1
    OUTPUT_SECUNDARY=$OUTPUT_POS2

elif grep -Fxq "$LG_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_POS1=$LAPTOP_MODEL
    OUTPUT_POS2=$LG_MODEL
    OUTPUT_MAIN=$OUTPUT_POS2
    OUTPUT_SECUNDARY=$OUTPUT_POS1

    if grep -Fxq "$DELL2_MODEL" <<< $CURR_OUTPUTS_LIST; then
    echo "DELL!"
        OUTPUT_POS1=$DELL2_MODEL
        OUTPUT_SECUNDARY=$OUTPUT_POS1
    fi

elif grep -Fxq "$DELL1_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_POS1=$LAPTOP_MODEL
    OUTPUT_POS2=$DELL1_MODEL
    OUTPUT_MAIN=$OUTPUT_POS2
    OUTPUT_SECUNDARY=$OUTPUT_POS1

elif grep -Fxq "$DELL2_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_POS1=$DELL2_MODEL
    OUTPUT_POS2=$LAPTOP_MODEL
    OUTPUT_MAIN=$OUTPUT_POS1
    OUTPUT_SECUNDARY=$OUTPUT_POS2

elif [ $CURR_OUTPUT_COUNT -eq 2 ]; then 
    OUTPUT_POS1=$(tail -1 <<< "$CURR_OUTPUTS_LIST")
    OUTPUT_POS2=$LAPTOP_MODEL
    OUTPUT_MAIN=$OUTPUT_POS1
    OUTPUT_SECUNDARY=$OUTPUT_POS2
fi

############################################
# Setup outputs
write_line "output \"$OUTPUT_POS1\" pos 0 0"

if [ ! -z "$OUTPUT_POS2" ]; then
    write_line "output \"$OUTPUT_POS2\" pos 1920 0"
fi
if [ ! -z "$OUTPUT_POST3" ]; then
    write_line "output \"$OUTPUT_POST3\" pos 3840 0"
fi

############################################
# Setup workspace assignments

WSBSOUTPUT=$OUTPUT_MAIN
WS1OUTPUT=$OUTPUT_MAIN
WS2OUTPUT=$OUTPUT_MAIN
WS3OUTPUT=$OUTPUT_MAIN
WS4OUTPUT=$OUTPUT_MAIN
WS5OUTPUT=$OUTPUT_MAIN
WS6OUTPUT=$OUTPUT_MAIN
WS7OUTPUT=$OUTPUT_MAIN
WS8OUTPUT=$OUTPUT_MAIN
WS9OUTPUT=$OUTPUT_MAIN
WS10OUTPUT=$OUTPUT_MAIN

if [ ! -z "$OUTPUT_SECUNDARY" ]; then
    if [ ! -z "$OUTPUT_EXTRA" ]; then
        WSBSOUTPUT=$OUTPUT_MAIN
        WS1OUTPUT=$OUTPUT_MAIN
        WS2OUTPUT=$OUTPUT_SECUNDARY
        WS3OUTPUT=$OUTPUT_MAIN
        WS4OUTPUT=$OUTPUT_MAIN
        WS5OUTPUT=$OUTPUT_MAIN
        WS6OUTPUT=$OUTPUT_MAIN
        WS7OUTPUT=$OUTPUT_SECUNDARY
        WS8OUTPUT=$OUTPUT_SECUNDARY
        WS9OUTPUT=$OUTPUT_SECUNDARY
        WS10OUTPUT=$OUTPUT_EXTRA
    else
        WSBSOUTPUT=$OUTPUT_SECUNDARY
        WS1OUTPUT=$OUTPUT_MAIN
        WS2OUTPUT=$OUTPUT_MAIN
        WS3OUTPUT=$OUTPUT_MAIN
        WS4OUTPUT=$OUTPUT_MAIN
        WS5OUTPUT=$OUTPUT_MAIN
        WS6OUTPUT=$OUTPUT_MAIN
        WS7OUTPUT=$OUTPUT_SECUNDARY
        WS8OUTPUT=$OUTPUT_SECUNDARY
        WS9OUTPUT=$OUTPUT_SECUNDARY
        WS10OUTPUT=$OUTPUT_SECUNDARY
    fi

fi

write_line "set \$wsbsoutput \"$WSBSOUTPUT\""
write_line "set \$ws1output  \"$WS1OUTPUT\""
write_line "set \$ws2output  \"$WS2OUTPUT\""
write_line "set \$ws3output  \"$WS3OUTPUT\""
write_line "set \$ws4output  \"$WS4OUTPUT\""
write_line "set \$ws5output  \"$WS5OUTPUT\""
write_line "set \$ws6output  \"$WS6OUTPUT\""
write_line "set \$ws7output  \"$WS7OUTPUT\""
write_line "set \$ws8output  \"$WS8OUTPUT\""
write_line "set \$ws9output  \"$WS9OUTPUT\""
write_line "set \$ws10output \"$WS10OUTPUT\""

notify-send -t 5000 Sway "Output config generated"

if [ "$1" == "reload" ]; then
    swaymsg reload
fi