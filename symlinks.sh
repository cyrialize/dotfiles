links=(
    $HOME/Code/dotfiles/.zshrc $HOME/.zshrc
    $HOME/Code/dotfiles/.global_gitconfig $HOME/.gitconfig
)

# Don't use $path, or you'll mess with ZSH
for lpath link (${(kv)links}) {
    if [[ ! -L $link ]]; then
	echo "Symlinking $lpath to $link"
	ln -s "$lpath" "$link"
    else
	echo "Symlink $lpath to $link exists"
    fi
}