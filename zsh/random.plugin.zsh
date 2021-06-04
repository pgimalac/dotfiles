random() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "${1:-16}" | head -n 1
}

temp () {
    if [ "$#@" -eq "0" ]; then
        until take "/tmp/$(random)" 2>/dev/null; do
        done
    elif [ "$#@" -eq "1" ]; then
        take "/tmp/$1"
    else
        echo "At most one argument expected." 1&>2
        return 1;
    fi
}
