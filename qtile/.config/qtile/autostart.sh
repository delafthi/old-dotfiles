#!/bin/bash

xsetroot -cursor-name left_ptr &
#xrandr --output DP-1 --mode 2560x1440 --rate 143.97 --primary --output HDMI-0 --mode 2560x1440 --rate 60.00 --right-of DP-1 --output DP-1-1 --mode 2560x1440 --rate 120.00 --left-of DP-1 &
xrandr --output DP-1 --mode 2560x1440 --rate 143.97 --output HDMI-0 --auto --right-of DP-1
xss-lock slock -n &
udiskie &
picom &
nm-applet &
xfce4-power-manager &
volumeicon &
blueman-applet &
trayer --edge top --align right --distance 4,4 --distancefrom top,right --widthtype request --transparent true --height 24 --alpha 0 --tint 0x282c34 --padding 5 --monitor 0 --iconspacing 3 &
dunst &
feh --bg-scale --randomize /usr/share/backgrounds/*
pcmanfm -d &
unclutter --timeout 10 &
