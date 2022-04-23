#!/bin/bash

# Screen Setup

intern=LVDS1
extern=VGA1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    #xrandr --output "$intern" --off --output "$extern" --auto
    xrandr --output LVDS1 --primary --mode 1366x768 --pos 1366x0 --rotate normal --output DP1 --off --output HDMI1 --off --output VGA1 --mode 1366x768 --pos 0x0 --rotate normal --output VIRTUAL1 --off
fi
