#!/bin/zsh
#
# Setup script for setting up my dotfiles
# Meant for MacOS or Linux

if command sw_vers > /dev/null; then
    echo "On MacOS!"
else
    echo "Other OS's aren't supported!"
    exit 1
fi

# Set up the symlink to my file
# For everything else, I just use `source`
if [[ ! -L $HOME/.zshrc ]]; then
    echo "Symlinking $HOME/Code/dotfiles/.zshrc to $HOME/.zshrc"
    ln -s $HOME/Code/dotfiles/.zshrc $HOME/.zshrc
else
    echo "Symlink $HOME/Code/dotfiles/.zshrc to $HOME/.zshrc exists"
fi

if [[ ! -f $HOME/.gitconfig ]]; then
    echo "Symlinking $HOME/Code/dotfiles/.global_gitconfig to $HOME/.gitconfig"
    ln -s $HOME/Code/dotfiles/.global_gitconfig $HOME/.gitconfig
else
    echo "Symlink $HOME/Code/dotfiles/.global_gitconfig to $HOME/.gitconfig exists"
fi

# Pull in and install the pure prompt
# https://github.com/sindresorhus/pure
if [[ ! -d $HOME/.zsh/pure ]]; then
    echo "Installing pure prompt"
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
else
    echo "Pure prompt is already installed!"
    echo "Updating..."
    git -C $HOME/.zsh/pure pull
fi

# Pull in and install the base16 shell theme
# https://github.com/base16-project/base16-shell
if [[ ! -d $HOME/.config/base16-shell ]]; then
    echo "Installing base16 shell themes"
    git clone https://github.com/base16-project/base16-shell.git ~/.config/base16-shell
else
    echo "base16 shell themes are already installed!"
    echo "Updating..."
    git -C $HOME/.config/base16-shell pull
fi

source $HOME/Code/dotfiles/install.sh