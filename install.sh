source $HOME/Code/dotfiles/libs.sh

echo "Installing/Updating $#libs applications"
for lib ($libs) {
    version=$(brew ls --versions $lib)
    outdated=$(brew outdated $lib)
    info=$(brew info $lib)
    echo "----------"
    if [[ -z $version && -z $info ]]; then
	echo "Installing $lib..."
	brew install $lib
    elif [[ $outdated ]]; then
	echo "Updating $lib..."
	brew install $lib
    else
	echo "Already installed: $lib"
	if [[ $version ]]; then
	    echo "Version: $version"
        fi
    fi
}
echo "----------\n"
