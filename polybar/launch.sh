#!/bin/zsh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
    sleep 0.1;
done

# Launch bar
pdetach polybar -r top 2>>/tmp/polybar_top.log 1>&2
pdetach polybar -r bot 2>>/tmp/polybar_bot.log 1>&2
