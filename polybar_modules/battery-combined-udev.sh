#!/bin/sh

battery_print() {
    PATH_AC="/sys/class/power_supply/AC"
    PATH_BATTERY_0="/sys/class/power_supply/BAT0"
    PATH_BATTERY_1="/sys/class/power_supply/BAT1"

    ac=0
    battery_level_0=0
    battery_level_1=0
    battery_max_0=0
    battery_max_1=0

    if [ -f "$PATH_AC/online" ]; then
        ac=$(cat "$PATH_AC/online")
    fi

    if [ -f "$PATH_BATTERY_0/energy_now" ]; then
        battery_level_0=$(cat "$PATH_BATTERY_0/energy_now")
    fi

    if [ -f "$PATH_BATTERY_0/energy_full" ]; then
        battery_max_0=$(cat "$PATH_BATTERY_0/energy_full")
    fi

    if [ -f "$PATH_BATTERY_1/energy_now" ]; then
        battery_level_1=$(cat "$PATH_BATTERY_1/energy_now")
    fi

    if [ -f "$PATH_BATTERY_1/energy_full" ]; then
        battery_max_1=$(cat "$PATH_BATTERY_1/energy_full")
    fi

    battery_level=$(("$battery_level_0 + $battery_level_1"))
    battery_max=$(("$battery_max_0 + $battery_max_1"))

    battery_percent=$(("$battery_level * 100"))
    battery_percent=$(("$battery_percent / $battery_max"))

    if [ "$ac" -eq 1 ]; then
        if [ "$battery_percent" -gt 99 ]; then
            icon="󰂅"
        elif [ "$battery_percent" -gt 90 ]; then
            icon="󰂋"
        elif [ "$battery_percent" -gt 80 ]; then
            icon="󰂊"
        elif [ "$battery_percent" -gt 70 ]; then
            icon="󰢞"
        elif [ "$battery_percent" -gt 60 ]; then
            icon="󰂉"
        elif [ "$battery_percent" -gt 50 ]; then
            icon="󰢝"
        elif [ "$battery_percent" -gt 40 ]; then
            icon="󰂈"
        elif [ "$battery_percent" -gt 30 ]; then
            icon="󰂇"
        elif [ "$battery_percent" -gt 20 ]; then
            icon="󰂆"
        elif [ "$battery_percent" -gt 10 ]; then
            icon="󰢜"
        fi

        echo "$icon $battery_percent%"

    else
        if [ "$battery_percent" -gt 99 ]; then
            icon="󰁹"
        elif [ "$battery_percent" -gt 90 ]; then
            icon="󰂂"
        elif [ "$battery_percent" -gt 80 ]; then
            icon="󰂁"
        elif [ "$battery_percent" -gt 70 ]; then
            icon="󰂀"
        elif [ "$battery_percent" -gt 60 ]; then
            icon="󰁿"
        elif [ "$battery_percent" -gt 50 ]; then
            icon="󰁾"
        elif [ "$battery_percent" -gt 40 ]; then
            icon="󰁽"
        elif [ "$battery_percent" -gt 30 ]; then
            icon="󰁼"
        elif [ "$battery_percent" -gt 20 ]; then
            icon="󰁻"
        elif [ "$battery_percent" -gt 10 ]; then
            icon="󰁺"
        fi

        echo "$icon $battery_percent%"
    fi
}

path_pid="/tmp/polybar-battery-combined-udev.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac
