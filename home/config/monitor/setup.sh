#!/bin/bash

LEFT=$(xrandr | rg " connected " | awk '{print $1}' | sort -t " " -k 5 | head -n 1)
RIGHT=$(xrandr | rg " connected " | awk '{print $1}' | sort -t " " -k 5 | tail -n 1)

xrandr --output DP-2 --primary --right-of DP-0 --auto --output DP-0 --rotate right --auto

xdotool mousemove 1960 540
