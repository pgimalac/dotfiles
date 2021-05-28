#!/bin/sh

curl -s "https://archlinux.org/mirrorlist/?country=FR&protocol=https&protocol=http&use_mirror_status=on" |
sed -e 's/^#Server/Server/' -e '/^#/d' -e '/^$/d' -e 's/http:/https:/' |
sort -u |
while IFS= read -r SERVER; do
    rankmirrors -m 0,5 -u $(echo "$SERVER" | sed -e 's/^Server = //') |
        grep --invert-match unreachable |
        grep --invert-match timeout 2>/dev/null |
        sed -E -e 's/(.*) : 0.(.*)/\2 Server = \1/' -e '' &
done |
    sort |
    sed -E -e 's/^([[:digit:]]*) //'
