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

OUTPUT_LAPTOP="eDP-1"
OUTPUT_E1=""
OUTPUT_E2=""

ASUS_MODEL="Ancor Communications Inc ASUS ML239 BBLMIB518036"
LG_MODEL="Goldstar Company Ltd LG HDR WFHD 0x0000DEEE"
DELL1_MODEL="Dell Inc. DELL U2419H 10XNRS2"
DELL2_MODEL="Dell Inc. DELL U2417H 5K9YD89MC9JL"

if grep -Fxq "$ASUS_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_E1=$ASUS_MODEL

elif grep -Fxq "$LG_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_E1=$LG_MODEL

elif grep -Fxq "$DELL1_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_E1=$DELL1_MODEL
    
    if grep -Fxq "$DELL2_MODEL" <<< $CURR_OUTPUTS_LIST; then
        OUTPUT_E2=$DELL2_MODEL
    fi

elif grep -Fxq "$DELL2_MODEL" <<< $CURR_OUTPUTS_LIST; then
    OUTPUT_E1=$DELL2_MODEL
elif [ $CURR_OUTPUT_COUNT -eq 2 ]; then 
    OUTPUT_E1=$(tail -1 <<< "$CURR_OUTPUTS_LIST")
fi

############################################
# Setup outputs
write_line "output \"$OUTPUT_LAPTOP\" scale 1"
write_line "output \"$OUTPUT_LAPTOP\" pos 0 0"

if [ ! -z "$OUTPUT_E1" ]; then
    write_line "output \"$OUTPUT_E1\" pos 1920 0"
fi
if [ ! -z "$OUTPUT_E2" ]; then
    write_line "output \"$OUTPUT_E2\" pos 3840 0"
fi

############################################
# Setup workspace assignments

WSBSOUTPUT=$OUTPUT_LAPTOP
WS1OUTPUT=$OUTPUT_LAPTOP
WS2OUTPUT=$OUTPUT_LAPTOP
WS3OUTPUT=$OUTPUT_LAPTOP
WS4OUTPUT=$OUTPUT_LAPTOP
WS5OUTPUT=$OUTPUT_LAPTOP
WS6OUTPUT=$OUTPUT_LAPTOP
WS7OUTPUT=$OUTPUT_LAPTOP
WS8OUTPUT=$OUTPUT_LAPTOP
WS9OUTPUT=$OUTPUT_LAPTOP
WS10OUTPUT=$OUTPUT_LAPTOP

if [ ! -z "$OUTPUT_E1" ]; then
    if [ ! -z "$OUTPUT_E2" ]; then
        WSBSOUTPUT=$OUTPUT_LAPTOP
        WS1OUTPUT=$OUTPUT_E1
        WS2OUTPUT=$OUTPUT_E2
        WS3OUTPUT=$OUTPUT_E1
        WS4OUTPUT=$OUTPUT_E1
        WS5OUTPUT=$OUTPUT_E1
        WS6OUTPUT=$OUTPUT_E1
        WS7OUTPUT=$OUTPUT_E2
        WS8OUTPUT=$OUTPUT_E2
        WS9OUTPUT=$OUTPUT_E2
        WS10OUTPUT=$OUTPUT_LAPTOP
    else
        WSBSOUTPUT=$OUTPUT_LAPTOP
        WS1OUTPUT=$OUTPUT_E1
        WS2OUTPUT=$OUTPUT_E1
        WS3OUTPUT=$OUTPUT_E1
        WS4OUTPUT=$OUTPUT_E1
        WS5OUTPUT=$OUTPUT_E1
        WS6OUTPUT=$OUTPUT_E1
        WS7OUTPUT=$OUTPUT_LAPTOP
        WS8OUTPUT=$OUTPUT_LAPTOP
        WS9OUTPUT=$OUTPUT_LAPTOP
        WS10OUTPUT=$OUTPUT_LAPTOP
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