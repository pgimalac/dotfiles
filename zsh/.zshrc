#!/bin/zsh

export PATH=$PATH:/opt/comelec/bin:$HOME/.opam/default/bin

# Path to your oh-my-zsh installation.
export ZSH="/home/pierre/.oh-my-zsh"

fpath=($HOME/.zfunc $fpath)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pierre"
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Bold blue directories, like exa does
LS_COLORS="di=34;01"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

if [ -z "$plugins" ]; then
    plugins=(
        # autojump
        compleat
        copydir
        copyfile
        dirhistory
        extract
        # safe-paste
        zsh-autosuggestions
        zsh-syntax-highlighting
    )
fi

# safe-paste
# faster paste (does not call highlight on each character)
# but coloration problems due to zsh_autosuggestions
# and weirdly when typing something and going up in the history it prompts
# every commands, not just the ones starting with what you type

# merged a pull request on my fork to cancel that last bug
# but a relatively similar one appeared then

source $ZSH/oh-my-zsh.sh

# enables ** recursive patterns
setopt extended_glob glob_star_short
# interpret ?@*+! after a parenthesis
setopt ksh_glob
# deletes the glob pattern when it has no match
# setopt null_glob
# prints files starting with a dot when globbing (including file completion)
# setopt glob_dots
# no duplicate consecutive commands in history
setopt histignoredups
# short versions of loops
setopt short_loops

# You may need to manually set your language environment
export LANG="fr_FR.UTF-8"
export TORBROWSER_PKGLANG="fr-FR"

export ALL="$LANG"
export LANGUAGE="$LANG"
export LC_ADDRESS="POSIX"
export LC_COLLATE="POSIX"
export LC_CTYPE="$LANG"
export LC_IDENTIFICATION="$LANG"
export LC_MEASUREMENT="$LANG"
export LC_MESSAGE="POSIX"
export LC_MONETARY="$LANG"
export LC_NAME="POSIX"
export LC_NUMERIC="$LANG"
export LC_PAPER="$LANG"
export LC_TELEPHONE="$LANG"
export LC_TIME="$LANG"

# Preferred editor for local and remote sessions
export EDITOR=vim

# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# else
#     export EDITOR='subl'
# fi

export ARCHFLAGS="-arch x86_64"

# PAGER env vars
# Use less since most does not support reading ANSI colors, and bat can color man pages
# -R to read ANSI colors
export PAGER="less -R"
# -F to quit when displaying less than one screen, ie not always use fullscreen
export BAT_PAGER="less -RF"
# we want to always use fullscreen, even for small man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p --pager=\"$PAGER\"'"

# fzf variables
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'

# my aliases
alias du="dust"
alias cat="bat -pp"
alias find=fd
alias grep=rg
alias ls="exa -h -g --classify --icons"
alias la='ls -a' # override alias from $(OH_MY_ZSH)/lib/directories.zsh
alias tree="exa --tree -h --classify --icons"
alias paru="MAKEFLAGS=j8 paru"
alias ga="git add"
alias gs="git status"
alias gcam="git commit -am"
alias gcm="git commit -m"
alias gc="git checkout"
alias gpush="git push"
alias gpull="git pull"
alias gp="git pull && git push"
alias gd="git diff"
alias zshrc='subl ~/.zshrc'
alias h=history
alias tmp="cd /tmp"
alias sl=ls
alias ssh="TERM=xterm ssh"
alias music="pdetach vlc $HOME/Nextcloud/Musique/other/* --random"
alias classic="pdetach vlc $HOME/Nextcloud/Musique/classic/* --random"
alias cpg++="g++ -g -Wall -Wextra -DONLINE_JUDGE -O2 -std=c++17"
alias dd="ddi"
alias open="xdg-open"
alias detach=pdetach
alias reload="exec zsh"
alias restart="reload"
alias copy="xclip -i -selection clipboard"
alias paste="xclip -o -selection clipboard; echo"

# some nice functions
mkcd () { mkdir "$@" && cd ${@:$#} }
lcd () { cd "$1" && ls ${@:2:$#} }

fzf_change_directory() {
    local directory
    directory=$(
        fd --type d | \
        fzf --query="$1" --no-multi --select-1 --exit-0 \
            --preview 'tree -C {} | head -100'
    )
    if [[ -n $directory ]]; then
        cd "$directory"
    fi
}

fzf_find_edit() {
    local file
    file=$(
        fzf --query="$1" --no-multi --select-1 --exit-0 \
            --preview 'bat --color=always --line-range :500 {}'
    )
    if [[ -n $file ]]; then
        $EDITOR "$file"
    fi
}

fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match
    match=$(
        rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
    )
    local file
    file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
    fi
}

fzf_kill() {
    local user_col=1 pid_col=2 ppid_col=3 lines

    lines=$(
        ps axo user,pid,ppid,%cpu,%mem,state,start,cmd --sort -pid --no-header |
        fzf --multi -e |
        tr -s '[:blank:]'
    )

    while IFS= read -r line; do
        if [[ -z "$line" ]]; then
            break
        fi

        pid=$(
            echo $line |
            cut -d' ' -f"$pid_col"
        )

        user=$(
            echo "$line" |
            cut -d' ' -f"$user_col"
        )

        if [[ "$user" == "$USER" ]]; then
            echo "kill -KILL $pid"
            kill -KILL "$pid"
        else
            echo "sudo kill -KILL $pid"
            sudo kill -KILL "$pid"
        fi
    done <<< "$lines"

}

zathura() {
    /bin/zathura --fork $@ >/dev/null 2>&1
}

# some variables to personnalize plugins
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555"
bindkey '^ ' autosuggest-accept

# some fzf aliases
alias fkill='fzf_kill'
alias fge='fzf_grep_edit'
alias ffe='fzf_find_edit'
alias fcd='fzf_change_directory'

# ocaml
export OCAMLRUNPARAM="b1"
# opam configuration
# test -r /home/pierre/.opam/opam-init/init.zsh && . /home/pierre/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# to remove a bug with bat completion
# => manual patch in the completion script
# might need to update the script if bat is updated...
# compdef '' bat

# copied from zsh-reload module
# compiles zsh config files for faster start
local cache="$ZSH_CACHE_DIR"
autoload -U compinit zrecompile
compinit -i -d "$cache/zcomp-$HOST"

for f in ${ZDOTDIR:-~}/.zshrc "$cache/zcomp-$HOST"; do
    zrecompile -p $f >/dev/null && command rm -f $f.zwc.old
done


# My version of copybuffer
# Mostly stolen from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copybuffer
# copy the active line from the command line buffer
# onto the system clipboard, and clear the line

copybuffer () {
    if which clipcopy &>/dev/null; then
        echo -n "$BUFFER" | clipcopy
        BUFFER=""
    else
        echo "clipcopy function not found. Please make sure you have Oh My Zsh installed correctly."
    fi
}

zle -N copybuffer

# remove all ctrl+x bindkeys
# otherwise zsh will wait (less than 1s but still) for a second key press
bindkey -r "^X^B" "^X^E" "^X^F" "^X^J" "^X^K" "^X^N" "^X^O" "^X^R" "^X^U" "^X^V" "^X^X" "^X*" "^X=" "^X?" "^XC" "^XG" "^Xa" "^Xc" "^Xd" "^Xe" "^Xg" "^Xh" "^Xm" "^Xn" "^Xr" "^Xs" "^Xt" "^Xu" "^X~"

bindkey "^X" copybuffer
