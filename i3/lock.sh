#!/bin/sh

pidof i3lock 1> /dev/null || i3lockmore -ef --image-fill $HOME/Documents/archlock.png
