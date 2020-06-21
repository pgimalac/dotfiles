#!/bin/sh

# creates the hardlinks between the files of this repo and the real config files
# takes as argument a file containing a list of file in this repo and their location in the computer

# may take three optional arguments:
# -v --verbose : to print more things
# -f --force   :  by default, when a config file already exists at the indicated location the scripts asks the user
# if he wants to override it. With this option it automatically overrides the files.
# -b --backup  : to save the previous config files somewhere

# anything that is not one of those arguments is considered to be the input file.

# the separator must be a string that doesn't appear in any of the files
separator="|"

verbose=0
force=0
backup=0

source_list=""
prefix=""

function log {
    if [ $verbose = "0" ]; then
        echo "$@"
    fi
}

function err {
    echo "$@" 1>&2
}

function trim {
    while read -r line; do
        echo "$line" | /bin/sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | /bin/cat -s
    done
}

while [[ $# -gt 0 ]]; do
    param="$1"
    case $param in
        "-f"|"--force")
            force=1;;

        "-v"|"--verbose")
            verbose=1;;

        "-b"|"--backup")
            backup=1;;

        "-p"|"--prefix")
            if [ -z "$p" ]; then
                prefix="$2"
                shift
            else
                err "A prefix has already been given"
                exit 1
            fi;;

        *)
            if [ -z "$source_list" ]; then
                source_list="$param"
            else
                err "A source file has already been given (\"$source_list\")."
                exit 2
            fi
    esac
    shift
done

args=""
if [ $force = "1" ]; then
    args="$args -f"
fi

if [ $verbose = "1" ]; then
    args="$args -v"
fi

if [ $backup = "1" ]; then
    args="$args -b"
fi

# echo "$args"

if [ -z "$source_list" ]; then
    err "No source file given as argument." 1>&2
    exit 10
fi

log "Using $source_list as the source file."

if [ ! -e "$source_list" ]; then
    err "$source_list does not exist."
    exit 11
fi

if [ ! -f "$source_list" ]; then
    err "$source_list is not a file."
    exit 12
fi

if [ ! -r "$source_list" ]; then
    err "$source_list is not readable."
    exit 13
fi

while read -r line; do
    echo "$line" | tr "$separator" "\n" | trim | (
        read -r from;
        read -r to;

        if [ -n "$prefix" ] && [ ${to:0:1} != '/' ]; then
            to="$prefix/$to"
        fi

        if [ "$verbose" = "1" ]; then
            if [[ `diff "$from" "$to"` ]]; then
                # diff "$from" "$to"
                echo "diff \"$from\" \"$to\""
                exit 1
            fi
            # echo "ln $args \"$from\" \"$to\""
        fi

        # ln $args "$from" "$to"
        )
done < "$source_list"
