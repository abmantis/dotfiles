#!/bin/bash

USAGE_F=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) ; }' \
          <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))
USAGE=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $USAGE_F)
FREQ=$(lscpu | grep 'CPU MHz:' | awk '{printf "%.1f", ($3/1000)}')
TEMPS=$(paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/' | awk -vRS="\n" -vORS="\\\n" '1')

if [ "$USAGE" -ge "80" ]; then
    CLASS="critical"
elif [ "$USAGE" -ge "50" ]; then
    CLASS="warning"
else
    CLASS="normal"
fi

printf '{"text":" %s%%", "tooltip":"Usage: %s%%\\nFrequency: %sGHz\\n\\nTemperatures:\\n%s","class":"%s"}\n' \
        "$USAGE" "$USAGE" "$FREQ" "$TEMPS" "$CLASS"
