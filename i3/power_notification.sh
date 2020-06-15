#!/bin/bash

VERY_VERY_LOW_LEVEL="10"
VERY_LOW_LEVEL="20"
LOW_LEVEL="30"

POWER_DISCHARGING="0"
POWER_CHARGING="1"
POWER_NOTCHARGING="2"

CHARGING="0"
LEVEL="50"

INITIAL_SLEEP=30
SLEEP_TIME=20

# TO AVOID PROBLEMS AT BOOT TIME
sleep $INITIAL_SLEEP

while true; do

    BATTINFO=`acpi -b`

    # NOT CHARGING
    # DISCHARGING
    # CHARGING

    # CHANGE CHARGING STATE
    if [[ `echo "$BATTINFO" | grep "Discharging"` ]]; then
        NEW_CHARGING=$POWER_DISCHARGING
    elif [[ `echo "$BATTINFO" | grep "Not charging"` ]]; then
        NEW_CHARGING=$POWER_NOTCHARGING
    else
        NEW_CHARGING=$POWER_CHARGING
    fi

    # CHANGE POWER LEVEL
    if [[ `echo "$BATTINFO" | grep "Not charging"` ]]; then
        NEW_LEVEL=`echo "$BATTINFO" | rev | cut -f 1 -d " " | cut -c -2 --complement | rev`
    else
        NEW_LEVEL=`echo "$BATTINFO" | cut -f 4 -d " " | rev | cut -c -2 --complement | rev`
    fi

    # NOTIFY WHEN NEEDED

    # NOTIFY END OF CHARGE
    if [[ "$CHARGING" = $POWER_CHARGING ]] && [[ "$NEW_CHARGING" = $POWER_NOTCHARGING ]]; then
        DISPLAY=:0 /usr/bin/notify-send -u low "Battery charged"
    fi

    # WHEN STOPPING CHARGE AT A LOW LEVEL WE WANT A NOTIFICATION
    if [[ "$CHARGING" = $POWER_CHARGING ]] && [[ "$NEW_CHARGING" = $POWER_DISCHARGING ]]; then
        LEVEL="50"
    fi

    # NOTIFY LOW CHARGE
    if [[ "$NEW_CHARGING" = $POWER_DISCHARGING ]]; then
        if [[ "$NEW_LEVEL" -le $VERY_VERY_LOW_LEVEL ]] && [[ "$LEVEL" -gt $VERY_VERY_LOW_LEVEL ]]; then
            DISPLAY=:0 /usr/bin/notify-send -u critical "Battery dropped at $NEW_LEVEL"
        elif [[ "$NEW_LEVEL" -le $VERY_LOW_LEVEL ]] && [[ "$LEVEL" -gt $VERY_LOW_LEVEL ]]; then
            DISPLAY=:0 /usr/bin/notify-send -u normal "Battery dropped at $NEW_LEVEL"
        elif [[ "$NEW_LEVEL" -le $LOW_LEVEL ]] && [[ "$LEVEL" -gt $LOW_LEVEL ]]; then
            DISPLAY=:0 /usr/bin/notify-send -u low "Battery dropped at $NEW_LEVEL"
        fi
    fi

    CHARGING=$NEW_CHARGING
    LEVEL=$NEW_LEVEL

    sleep $SLEEP_TIME

done
