#!/bin/zsh

# mostly stolen from transfer plugin of oh-my-zsh
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/transfer
# modified to copy the link in the X clipboard

# transfer.sh Easy file sharing from the command line
# transfer Plugin
# Usage Example :
# > transfer file.txt
# > transfer directory/

transfer() {
    # check arguments
    if [ $# -eq 0 ]; then
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi

    # upload stdin or file
    file=$1

    if tty -s; then
        basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g')

        if [ ! -e $file ]; then
            echo "File $file doesn't exists."
            return 1
        fi

        if [ -d $file ]; then
            echo $file
            # tar directory and transfer
            tarfile=$( mktemp -t transferXXX.tar.gz )
            cd $(dirname $file) && tar -czf $tarfile $(basename $file)
            curl --progress-bar --upload-file "$tarfile" "https://transfer.sh/$basefile.tar.gz" | copy && paste
            rm -f $tarfile
        else
            # transfer file
            curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" | copy && paste
        fi
    else
        # transfer pipe
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file" | copy && paste
    fi
}
