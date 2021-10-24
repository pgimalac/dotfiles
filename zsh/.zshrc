#!/bin/zsh

# Path to your oh-my-zsh installation.
ZSH="$HOME/.oh-my-zsh"

DOTFILES="$HOME/.dotfiles"
CONFIG="$HOME/.config"
NEXTCLOUD="$HOME/Nextcloud"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pierre"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Bold blue directories, like exa does
export LS_COLORS="di=34;01"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

if [ -z "$plugins" ]; then
    readonly plugins=(
        compleat
        dirhistory # custom
        extract
        fancy-ctrl-z
        fzf # custom
        quick-command-change # custom
        quick-directory-change # custom
        detach # custom
        random # custom
        reload # custom
        safe-paste # custom
        zmv # custom
        transfer # custom
        universalarchive # custom
        zsh-autosuggestions # not really custom but I have a wrapper
        zsh-syntax-highlighting # kind of custom, wrapper
        copy # custom # has to be put at the end to remove ^X bindings
    )
fi

source $ZSH/oh-my-zsh.sh
# enables ** recursive patterns
setopt extended_glob glob_star_short

# interpret ?@*+! after a parenthesis
setopt ksh_glob

# deletes the glob pattern when it has no match
# but "cat *.c" => "cat" if no c file, which has a very different behavior
# setopt null_glob

# prints files starting with a dot when globbing (including file completion)
# but also shows files starting with a dot when tabbing
# setopt glob_dots

# no duplicate consecutive commands in history
setopt histignoredups

# short versions of loops
setopt short_loops

# Preferred editor for local and remote sessions
export EDITOR=vim

# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# else
#     export EDITOR='subl'
# fi

# PAGER env vars
# Use less since most does not support reading ANSI colors, and bat can color man pages
# -R to read ANSI colors
export PAGER="less -R"
# -F to quit when displaying less than one screen, ie not always use fullscreen
export BAT_PAGER="less -RF"
# we want to always use fullscreen, even for small man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p --pager=\"$PAGER\"'"

# my aliases
# override existing applications
alias du="dust"
alias cat="bat -pp"
alias find=fd
alias grep="noglob rg"
alias sed="noglob sed"
alias awk="noglob awk"
alias ls="exa -h -g --classify --icons"
alias tree="exa --tree -h --classify --icons"
# alias paru="MAKEFLAGS=j8 paru" # added MAKEFLAGS directly in /etc/makepkg.conf
alias ssh="TERM=xterm ssh"
alias dd="ddi"
alias zathura="detach zathura"
alias vlc="detach vlc"
alias libreoffice="detach libreoffice"
alias feh="detach feh"

# short aliases
alias la='ls -a' # override alias from $(OH_MY_ZSH)/lib/directories.zsh
alias ga="git add"
alias gs="git status"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gc="git checkout"
alias gpush="git push"
alias gpull="git pull"
alias gp="git pull && git push"
gall() { git add . && git commit -am "$1" && git pull && git push }
alias gd="git diff"
alias zshrc='subl ~/.zshrc'
alias h=history
alias tmp="cd /tmp"
alias dotfiles="cd $DOTFILES"
alias config="cd $CONFIG"
alias sl=ls
alias open="detach xdg-open"

# new functions
alias music="vlc $HOME/Nextcloud/Musique/other/* --random"
alias classic="vlc $HOME/Nextcloud/Musique/classic/* --random"
alias cpg++="g++ -g -Wall -Wextra -DONLINE_JUDGE -O2 -std=c++17"

spawn() {
    if [ "$#@" -eq "0" ]; then
        detach alacritty
    else
        for d in "$@"; do
            detach alacritty --working-directory $d
        done
    fi
}
lcd () { cd "$1" && ls ${@:2:$#} }

# some more bindings
bindkey "^B" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

# some zsh styles
# cd completion doesn't show the current directory with ..
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# don't show completion functions in completion
zstyle ':completion:*:functions' ignored-patterns '_*'

# when there is no match for a function show approximates with at most 2 errors
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate
