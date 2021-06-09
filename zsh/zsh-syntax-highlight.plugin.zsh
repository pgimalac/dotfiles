#!/bin/false

# from https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
# modified to have syntax highlight on the pasted text

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

function pasteinit {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

function pastefinish {
    zle -N self-insert $OLD_SELF_INSERT
    _zsh_highlight
}

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
