#!/bin/bash

xsetroot -cursor-name left_ptr &
xss-lock slock -n &
udiskie &
picom &
nm-applet &
volumeicon &
trayer --edge top --align right --distance 4,4 --distancefrom top,right --widthtype request --transparent true --height 24 --alpha 0 --tint 0x282c34 --padding 5 --monitor 0 --iconspacing 3 &
dunst &
feh --bg-scale --randomize /usr/share/backgrounds/* &
pcmanfm -d &
unclutter --timeout 10 &
