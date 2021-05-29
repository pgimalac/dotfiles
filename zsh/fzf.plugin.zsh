#!/bin/zsh

# some fzf variables
export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'

# some fzf functions
fzf_change_directory() {
    local directory
    directory=$(
        fd --type d | \
        fzf --query="$1" --no-multi --select-1 --exit-0 \
            --preview 'exa --tree -h --classify --icons {} | head -100'
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
    local user_col=1 pid_col=2 ppid_col=3

    ps axo user,pid,ppid,%cpu,%mem,state,start,cmd --sort -pid --no-header |
    fzf --multi -e |
    tr -s '[:blank:]' |
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
    done

}

# some fzf aliases
alias fkill='fzf_kill'
alias fge='fzf_grep_edit'
alias ffe='fzf_find_edit'
alias fcd='fzf_change_directory'
