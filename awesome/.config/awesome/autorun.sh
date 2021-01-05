#!/usr/bin/env bash
function run {
    if ! pgrep -f $1 ;
    then
        $@&
    fi
}

run xrandr --output DP-1 --mode 2560x1440 --rate 143.97 --output HDMI-0 --auto --right-of DP-1
run xsetroot -cursor_name left_ptr
run xss-lock slock
run udiskie
run picom
run nm-applet
run blueman-applet
run xfce4-power-manager
run volumeicon
run pcmanfm -d
run unclutter --timeout 10
