libs=(
fortune
cowsay
ripgrep
)

echo "Installing/Updating applications"
for lib ($libs) {
    version=$(brew ls --versions $lib)
    outdated=$(brew outdated $lib)
    if [[ -z $version ]]; then
	echo "Installing $lib..."
	brew install $lib
    elif [[ $outdated ]]; then
	echo "Updating $lib..."
	brew install $lib
    else
	echo "Already installed: $version"
    fi
}