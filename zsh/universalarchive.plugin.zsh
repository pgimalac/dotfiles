#!/bin/zsh

# mostly stolen from universalarchive plugin of oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/universalarchive
# modified to give the name of the archive as first argument

function universalarchive {
    usage=\
"Archive files and directories using a given compression algorithm.

Usage:   $0 <name>.<format> <files>
Example: $0 pkg.tbz PKGBUILD

Supported archive formats are:
7z, bz2, gz, lzma, lzo, rar, tar, tbz (tar.bz2), tgz (tar.gz),
tlz (tar.lzma), txz (tar.xz), tZ (tar.Z), xz, Z, zip, and zst.

The name must not contain dots and must not be empty."

    if [[ $# -lt 2 ]]; then
        echo "$usage" 1>&2
        exit 1
    fi

    # all text after the first dot that is not the first character
    ext=$(echo "$1" | sed -E -e 's/(\.?[^\.]*)\.(.*)/\2/')
    if [ -z "$ext" ]; then
        echo "invalid name" 1>&2
        exit 1
    fi

    input="${2:a}"
    output=$1

    shift

    if [[ ! -e "$input" ]]; then
        echo "$input not found" 1>&2
        exit 1
    fi

    case "$ext" in
        7z)           7z u                        "${output}"   "${@}" ;;
        bz2)          bzip2 -vcf                  "${@}" > "${output}" ;;
        gz)           gzip -vcf                   "${@}" > "${output}" ;;
        lzma)         lzma -vc -T0                "${@}" > "${output}" ;;
        lzo)          lzop -vc                    "${@}" > "${output}" ;;
        rar)          rar a                       "${output}"   "${@}" ;;
        tar)          tar -cvf                    "${output}"   "${@}" ;;
        tbz|tar.bz2)  tar -cvjf                   "${output}"   "${@}" ;;
        tgz|tar.gz)   tar -cvzf                   "${output}"   "${@}" ;;
        tlz|tar.lzma) XZ_OPT=-T0 tar --lzma -cvf  "${output}"   "${@}" ;;
        txz|tar.xz)   XZ_OPT=-T0 tar -cvJf        "${output}"   "${@}" ;;
        tZ|tar.Z)     tar -cvZf                   "${output}"   "${@}" ;;
        xz)           xz -vc -T0                  "${@}" > "${output}" ;;
        Z)            compress -vcf               "${@}" > "${output}" ;;
        zip)          zip -rull                   "${output}"   "${@}" ;;
        zst)          zstd -c -T0                 "${@}" > "${output}" ;;
        *) echo "$usage" 1>&2; exit 1 ;;
    esac
}
