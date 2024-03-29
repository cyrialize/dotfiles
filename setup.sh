#!/bin/zsh
#
# Setup script for setting up my dotfiles
# Meant for MacOS or Linux

source $HOME/Code/dotfiles/helpers.sh

help=$(cat <<EOF
Setup script for setting up my dotfiles. Intended for MacOS. Linux
support planned in the future.

Checks for OS support prior to running anything.

Usage:
--a Run all flags.
--i Run install.sh to install/update libs, pure, and base16-shell.
--l Connect symlinks.
--h See this message.
EOF
)
install=1
all=1
link=1
while getopts 'alih' OPTION; do
    case "$OPTION" in
    a)
        all=0
        ;;
    l)
        link=0
        ;;
    i)
        install=0
        ;;
    h)
        echo $help
        exit 0
        ;;
    ?)
        echo $help
        exit 1
        ;;
    esac
done

if [[ -z $OPTION ]]; then
    echo $help
    exit 0
fi

if [[ "$(current_os)" == "mac" ]]; then
    print_color "yellow" "MacOS detected! Continuing..."
fi

if [[ $link -eq 0 || $all -eq 0 ]]; then
    source $HOME/Code/dotfiles/symlinks.sh
fi

if [[ $install -eq 0 || $all -eq 0 ]]; then
    source $HOME/Code/dotfiles/install.sh
fi
