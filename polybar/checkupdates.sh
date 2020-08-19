#!/bin/zsh

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l); then
    updates_arch=0
fi

if ! updates_aur=$(trizen -Qua 2> /dev/null | wc -l); then
    updates_aur=0
fi

if [ "$updates_arch" -gt 0 ] || [ "$updates_aur" -gt 0 ]; then
    echo "$updates_arch  $updates_aur"
else
    echo ""
fi
