#!/bin/bash

LC_NUMERIC="en_US.UTF-8"

TEMPS=""
for dir in /sys/class/thermal/thermal_zone*; do
    if [[ -f "$dir/type" && -f "$dir/temp" ]]; then
        type=$(cat "$dir/type")
        temp=$(cat "$dir/temp" 2>/dev/null | sed 's/\(.\)..$/.\1°C/' )
        TEMPS="$TEMPS$type: \t\t $temp\n"
    fi
done


USAGE_F=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) ; }' \
          <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))
USAGE=$(printf "%.0f" $USAGE_F)
FREQS=$(paste <(lscpu -e | awk 'NR>1{print $1 ":\t" int($9)}') | awk -vRS="\n" -vORS="\\\n" '1')
# TEMPS=$(paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/' | awk -vRS="\n" -vORS="\\\n" '1')

if [ "$USAGE" -ge "80" ]; then
    CLASS="critical"
elif [ "$USAGE" -ge "50" ]; then
    CLASS="warning"
else
    CLASS="normal"
fi
printf '{"text":" %s%%", "tooltip":"Usage: %s%%\\nFrequencies:\\n%s\\n\\nTemperatures:\\n%s","class":"%s"}\n' \
        "$USAGE" "$USAGE" "$FREQS" "$TEMPS" "$CLASS"
