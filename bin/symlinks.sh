#!/usr/bin/env bash

# shellcheck source=lib/functions.sh
source "$HOME"/Code/dotfiles/lib/functions.sh

declare -A links
links["$HOME/.zshrc"]="$HOME/Code/dotfiles/.zshrc"
links["$HOME/.gitconfig"]="$HOME/Code/dotfiles/.global_gitconfig"
links["$HOME/.zsh_aliases"]="$HOME/Code/dotfiles/.zsh_aliases"
links["$HOME/.global_gitattributes"]="$HOME/Code/dotfiles/.global_gitattributes"
links["$HOME/.wezterm.lua"]="$HOME/Code/dotfiles/.wezterm.lua"
links["$HOME/.config/wezterm/.wezterm.lua"]="$HOME/Code/dotfiles/.wezterm.lua"
links["$HOME/Code/dotfiles/.git/hooks/pre-commit"]="$HOME/Code/dotfiles/lib/hooks/pre-commit.sh"
links["$HOME/.shellcheckrc"]="$HOME/Code/dotfiles/.shellcheckrc"
links["$HOME/.brewfile"]="$HOME/Code/dotfiles/.brewfile"
links["$HOME/.brewfile.lock.json"]="$HOME/Code/dotfiles/.brewfile.lock.json"
links["$HOME/.ruby-version"]="$HOME/Code/dotfiles/.ruby-version"
links["$HOME/.hammerspoon"]="$HOME/Code/dotfiles/.hammerspoon"

for link in "${!links[@]}"; do
  lpath="${links[$link]}"

  if [[ ! -L "$link" ]]; then
    print_color "yellow" "Symlinking $lpath to $link"
    ln -s "$lpath" "$link"
  else
    print_color "blue" "Symlink from $lpath to $link exists"
  fi
done
