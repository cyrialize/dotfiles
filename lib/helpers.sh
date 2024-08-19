#!/usr/bin/env bash

source $HOME/Code/dotfiles/lib/functions.sh

# --------------------------------
# GENERAL HELPER INSTALL FUNCTIONS
# --------------------------------
#
# Helper functions used for generating logs, performing installations,
# etc. for installing packages.
#
# The general version of a function should always be called. Each
# general function determines the current operating system and calls
# the corresponding implementation of the action needed.

# Returns a 0 if the package is installed, 1 otherwise
#
# Ex: is_installed "lib"
is_installed() {
    local lib="$1"

    os=$(current_os)
    if [[ "$os" == "mac" ]]; then
        mac_is_installed "$lib";
    fi
}

# Installs given package
#
# $1: Name of the package
#
# Ex: install "lib"
install() {
    local lib="$1"

    os=$(current_os)
    if [[ "$os" == "mac" ]]; then
        mac_install "$lib"
    fi
}

# Updates given package
#
# $1: Name of the package
#
# Ex: update "lib"
update() {
    local lib="$1"

    os=$(current_os)
    if [[ "$os" == "mac" ]]; then
        mac_update "$lib"
    fi
}

# Returns the current version of the package
#
# $1: Name of the package
# return: String of version of package
#
# Ex: version "lib"
version() {
    local lib="$1"

    os=$(current_os)
    if [[ "$os" == "mac" ]]; then
        mac_lib_version "$lib";
    fi
}

# Checks if a package is up to date
#
# $1: Name of the package
# return: 0 if the package is up to date, 1 otherwise
#
# Ex: is_up_to_date "lib"
is_up_to_date() {
    local lib="$1"

    os=$(current_os)
    if [[ "$os" == "mac" ]]; then
        mac_is_up_to_date "$lib";
    fi
}

# ------------------------------------
# MAC INSTALL FUNCTION IMPLEMENTATIONS
# ------------------------------------
#
# Specific implementations of the general functions above for MacOS.
# Currently only implements homebrew commands. If there is ever a need
# to move away from homebrew, then I'll change these.

# $1: Name of the package
# return: 0 if package is installed, 1 otherwise
#
# Ex: mac_is_installed "lib"
mac_is_installed() {
    brew_info_output=$(brew info "$1" 2>/dev/null)
    [[ $brew_info_output != *"Not installed"* ]]
}

# $1: Name of the package
# return: 0 if package is up to date, 1 otherwise
#
# Ex: mac_is_outdated "lib"
mac_is_up_to_date() {
    brew outdated "$1" > /dev/null 2>&1
    [[ $? -eq 0 ]]
}


# $1: Name of the package
# Ex: mac_install "lib"
mac_install() {
    brew install "$1"
}

# $1: Name of the package
# Ex: mac_update "lib"
mac_update() {
    brew upgrade "$1"
}

# $1: Name of the package
# return: String of the package version
#
# Ex: mac_lib_version "lib"
mac_lib_version() {
    echo "$(brew ls --version "$1")"
}

# ----------------------------
# GIT INSTALL HELPER FUNCTIONS
# ----------------------------
#
# Helper functions separate from the general install functions.
# Specifically used for git related operations.


# Attempts to update the given git repo URL
#
# $1: Repo of the URL
# returns: 0 if update was a success, 1 if the update failed,
#          2 if the package was already up to date
git_attempt_update() {
    local update_output=$(git -C "$1" pull)

    if [[ $update_output == *"Already up to date"* ]]; then
        print_color "yellow" "Already up to date!"
        return 2
    elif [[ $? -eq 0 ]]; then
        print_color "green" "Git pull succeeded!"
        return 0
    else
        print_color "red" "Git pull failed!"
        return 1
    fi
}
