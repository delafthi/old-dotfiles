#!/bin/bash

trayer --edge top --align right --distance 4,4 --distancefrom top,right --widthtype request --transparent true --height 24 --alpha 0 --tint 0x282c34 --padding 5 --monitor 0 --iconspacing 3 &
dunst &
feh --bg-scale --randomize /usr/share/backgrounds/* &
