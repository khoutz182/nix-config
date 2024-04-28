#!/bin/bash

/usr/bin/numlockx on

LOWER=$(xrandr --listmonitors | tail -n +2 | sort -t " " -k 5 | head -n 1 | cut -d ' ' -f 6)
UPPER=$(xrandr --listmonitors | tail -n +2 | sort -t " " -k 5 | tail -n 1 | cut -d ' ' -f 6)

# if [ "$1" != "switch" ]; then
#     xrandr --output $UPPER --primary --left-of $LOWER --output $LOWER --off
# else
#     xrandr --output $LOWER --primary --left-of $UPPER --output $UPPER --off
# fi

xrandr --output DP-2 --primary --right-of DP-4 --auto --output DP-4 --rotate right --auto

xdotool mousemove 960 540
