#!/bin/zsh

for pkg in $1/*.PKGBUILD ; do
    [[ -f "$pkg" ]] || continue

    while true; do
        bat "$pkg"

        # specific to the zsh read builtin
        read "ans?=> Edit $pkg? [y/N]: "
        # for other shells use something like
        # read -p "=> Edit $pkg? [y/N]: " ans

        case "$ans" in
            [Yy]* ) $EDITOR "$pkg"; break;;
            ''|[Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
done
