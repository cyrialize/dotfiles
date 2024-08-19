#!/usr/bin/env bash

source $HOME/Code/dotfiles/lib/functions.sh

declare -A links
links["$HOME/.zshrc"]="$HOME/Code/dotfiles/.zshrc"
links["$HOME/.gitconfig"]="$HOME/Code/dotfiles/.global_gitconfig"
links["$HOME/.zsh_aliases"]="$HOME/Code/dotfiles/.zsh_aliases"

for link in "${!links[@]}"; do
  lpath="${links[$link]}"

  if [[ ! -L "$link" ]]; then
    print_color "yellow" "Symlinking $lpath to $link"
    ln -s "$lpath" "$link"
  else
    print_color "blue" "Symlink from $lpath to $link exists"
  fi
done
