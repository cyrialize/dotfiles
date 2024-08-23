#!/usr/bin/env bash

# shellcheck source=colors.sh
source $HOME/Code/dotfiles/lib/colors.sh

# General functions used in a variety of my scripts and shell.

# Detects the current operating system and returns a string
# representation of the OS. Only supported OS strings are returned.
#
# If an unsupported OS is detected, we exit. Only MacOS is supported.
#
# return: "mac"
current_os() {
    if command sw_vers > /dev/null; then
        echo "mac";
    else
        echo "Only Mac OS is currently supported! Exiting..."
        exit 1
    fi
}

# Print out messages in a color format.
#
# $1: color
# $2: message
#
# Ex: print_color "YELLOW" "Installing pure prompt"
print_color() {
    local color=""
    color=$(echo "$1" | tr '[:lower:]' '[:upper:]')
    local string="$2"

    echo -e "${!color}${string}${NOCOLOR}"
}

# Prints out a message a successful message in green if the command
# was a success (equals 0), or a failed message in red if the command
# was not a success (not equal to 0).
#
# $1: Action shown in message
# $2: Result from action, usually passed in via $?
#
# Ex:
# do_thing
# log_result "Thing" "$?"
# >> "Thing succeeded!"
log_result() {
    local action="$1"
    local result="$2"

    if [[ "$result" -eq 0 ]]; then
        print_color "green" "$action succeeded!"
    else
        print_color "red" "$action failed!"
    fi
}
