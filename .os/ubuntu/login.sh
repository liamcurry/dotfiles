#!/usr/bin/env sh

# Allows sharing of X11 and GTK clipboard
autocutsel &
autocutsel -s PRIMARY &

# Swaps caps/ctrl
/usr/bin/setxkbmap -option "ctrl:swapcaps"
/usr/bin/setxkbmap -option "ctrl:nocaps"
