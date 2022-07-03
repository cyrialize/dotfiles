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

source $HOME/Code/dotfiles/libs.sh

echo "Installing/Updating $#libs applications"
for lib ($libs) {
    echo "----------"
    if ! brew info $lib &>/dev/null; then
	echo "Installing $lib..."
	brew install $lib
    else
        version=$(brew ls --versions $lib)
        outdated=$(brew outdated $lib)
	if [[ $outdated ]]; then
	    echo "Updatting $lib..."
	    brew install $lib
	else
	    echo "Already installed: $lib"
	    if [[ $version ]]; then
		echo $version
	    fi
	fi
    fi
}
echo "----------\n"
