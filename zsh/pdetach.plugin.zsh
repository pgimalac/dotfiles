#!/bin/false

function pdetach {
    if [ -t 0 ]; then
        exec <-
    fi

    if [ -t 1 ]; then
        exec 1>-
    fi

    if [ -t 2 ]; then
        exec 2>-
    fi

    (nohup $@ &)
}
