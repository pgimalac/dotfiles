#!/bin/false

# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/zmv

# damn that's nice
autoload zmv

alias zcp='noglob zmv -C'
alias zln='noglob zmv -L'
alias zmv='noglob zmv -M'

alias zcpw='zcp -W'
alias zlnw='zln -W'
alias zmvw='zmv -W'
