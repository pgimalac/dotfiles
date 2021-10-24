#!/bin/false

PATH=
source /etc/zsh/zprofile
PATH=$PATH:/usr/bin:/bin:/opt/comelec/bin:$HOME/.cargo/bin:$HOME/.opam/default/bin:$HOME/.local/bin:$HOME/go/bin

# manual patch in the completion script to fix bat completion
# put zfunc at the start of fpath to override the official completion file
# might need to update the script if bat is updated...
export fpath=($HOME/.zfunc /usr/share/zsh/**/)

# langage environment variables
export LANG="fr_FR.UTF-8"
export LC_ALL="$LANG"
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
export LC_MESSAGES="$LANG"
export LC_TIME="$LANG"
export TORBROWSER_PKGLANG="fr"

# cause bugs in some builds, not even sure it is correct
# export ARCHFLAGS="-arch x86_64"

# ocaml
export OCAMLRUNPARAM="b1"

# go
export GOPATH="$HOME/.go"

# Xilinx Vivado
export LD_LIBRARY_PATH=/usr/lib:/lib:/opt/intel/mkl/lib/:/opt/Xilinx/Vivado/2017.2/lib/lnx64.o/:/opt/Xilinx/SDK/2017.2/lib/lnx64.o/:/opt/Xilinx/Vivado_HLS/2017.2/lnx64/tools/clang-3.9/lib
export PATH=$PATH:/opt/Xilinx
