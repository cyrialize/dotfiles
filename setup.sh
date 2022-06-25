# Setup script for setting up my dotfiles
# Meant for MacOS or Linux

# Set up the symlink to my file
# For everything else, I just use `source``
if [[ ! -L $HOME/.zshrc ]]; then
    ln -s $HOME/Code/dotfiles/.zshrc $HOME/.zshrc
fi

# Pull in and install the pure prompt
# https://github.com/sindresorhus/pure
if [[ ! -d $HOME/.zsh/pure ]]; then
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# Pull in and install the base16 shell theme
# https://github.com/base16-project/base16-shell
if [[ ! -d $HOME/.config/base16-shell ]]; then
    git clone https://github.com/base16-project/base16-shell.git ~/.config/base16-shell
fi

if [[ ! -f $HOME/.gitconfig ]]; then
    ln -s $HOME/Code/dotfiles/.global_gitconfig $HOME/.gitconfig
fi

source $HOME/Code/dotfiles/install.sh