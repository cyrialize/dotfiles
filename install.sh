#!/bin/zsh

source $HOME/Code/dotfiles/helpers.sh
source $HOME/Code/dotfiles/libs.sh

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

# Pull in and install the base16 shell theme
# https://github.com/base16-project/base16-shell
if [[ ! -d $HOME/.config/base16-shell ]]; then
    print_color "yellow" "Installing base16 shell themes..."
    git clone https://github.com/base16-project/base16-shell.git ~/.config/base16-shell
    log_result "Installation" "$?"
else
    print_color "yellow" "base16 shell themes are already installed!"
    print_color "yellow" "Updating..."
    git_attempt_update "$HOME/.config/base16-shell"
fi
echo

print_color "yellow" "Installing/Updating $#libs applications"
for lib in $libs; do
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
