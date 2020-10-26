#!/bin/bash

light-locker &
xss-lock -- light-locker -n &
udiskie &
picom &
nm-applet &
xfce4-power-manager &
volumeicon &
blueman-applet &
trayer --edge top --align right --widthtype request --transparent true --height 22 --alpha 0 --tint 0x2e3440 --padding 5 --monitor 0,1 &
dunst &
~/.fehbg &
pcmanfm -d &
