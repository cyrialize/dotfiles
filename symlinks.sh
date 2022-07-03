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