#!/bin/false

# My version of copybuffer
# Mostly stolen from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer
# copy the active line from the command line buffer
# onto the system clipboard, and clear the line

# using a function instead of an alias avoids some issues
# when this is used before being defined
# because aliases are replaced immediately when used
# while functions are resolved at runtime
function copy {
    xclip -i -selection clipboard $@
}

function paste {
    xclip -o -selection clipboard $@
}

function cutbuffer {
    echo -n "$BUFFER" | copy
    BUFFER=""
}

function copydir {
    echo -n "$PWD" | copy
}

function copyfile {
    copy "$1"
}

zle -N cutbuffer

# remove all ctrl+x bindkeys
# otherwise zsh will wait (less than 1s but still) for a second key press
bindkey -r $(bindkey | grep -e "^\"\^X" | sed -E 's/^\"([^ ]*)\" .*/\1/' | tr '\n' ' ')

bindkey "^X" cutbuffer
