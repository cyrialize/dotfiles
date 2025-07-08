#!/usr/bin/env bash

# shellcheck source=lib/helpers.sh
source "$HOME"/Code/dotfiles/lib/helpers.sh

# shellcheck source=lib/libs.sh
source "$HOME"/Code/dotfiles/lib/libs.sh

# Pull in and install the pure prompt
# https://github.com/sindresorhus/pure
if [[ ! -d $HOME/.zsh/pure ]]; then
    print_color "yellow" "Installing pure prompt..."
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    log_result "Installation" "$?"
else
    print_color "yellow" "Pure prompt is already installed!"
    print_color "yellow" "Updating..."
    git_attempt_update "$HOME/.zsh/pure"
fi
echo

# shellcheck disable=SC2154
print_color "yellow" "Installing/Updating ${#libs[@]} libs applications"
os=$(current_os)
for lib in "${libs[@]}"; do

    if [[ "$os" == "mac" ]]; then
	print_color "yellow" "MacOS detected! It is recommended to use brewfile instead. Proceed? (y/n):"

	read -r answer
	if [[ "$answer" == "n" || "$answer" != "y" ]]; then
	    print_color "yellow" "Exiting!"
	    exit
	fi
    fi

    if is_installed "$lib"; then
        if is_up_to_date "$lib"; then
            current_version=$(version "$lib")
            print_color "green" "$lib already installed version: $current_version"
        else
            print_color "yellow" "Updating $lib..."
            update "$lib"
            log_result "Update" "$?"
        fi
    else
        print_color "yellow" "Installing $lib..."
        install "$lib"
        log_result "Installation" "$?"
    fi
done
