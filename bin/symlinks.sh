#!/usr/bin/env bash

# shellcheck source=lib/functions.sh
source "$HOME"/Code/dotfiles/lib/functions.sh

# Everything symlinks to my home directory instead of using ~/.config because
# not all programs know to check in ~/.config and I want to keep everything
# consistent. I will only symlink elsewhere if that specific program
# requires it.

declare -A links
# General git settings
links["$HOME/.gitconfig"]="$HOME/Code/dotfiles/.global_gitconfig"
links["$HOME/.global_gitattributes"]="$HOME/Code/dotfiles/.global_gitattributes"
links["$HOME/Code/dotfiles/.git/hooks/pre-commit"]="$HOME/Code/dotfiles/lib/hooks/pre-commit.sh"

# My shell is ZSH, but I write my scripts in BASH
links["$HOME/.zshrc"]="$HOME/Code/dotfiles/.zshrc"
links["$HOME/.zsh_aliases"]="$HOME/Code/dotfiles/.zsh_aliases"

# Wezterm: https://github.com/wezterm/wezterm
links["$HOME/.wezterm.lua"]="$HOME/Code/dotfiles/.wezterm.lua"
links["$HOME/.config/wezterm/.wezterm.lua"]="$HOME/Code/dotfiles/.wezterm.lua"

# Shellcheck: https://github.com/koalaman/shellcheck
links["$HOME/.shellcheckrc"]="$HOME/Code/dotfiles/.shellcheckrc"

# Homebrew: https://github.com/Homebrew
links["$HOME/.brewfile"]="$HOME/Code/dotfiles/.brewfile"
links["$HOME/.brewfile.lock.json"]="$HOME/Code/dotfiles/.brewfile.lock.json"

# Chruby: https://github.com/postmodern/chruby
# This is my "main" ruby version file that I want globally, this is
# overwritten by project specific .ruby-version files
links["$HOME/.ruby-version"]="$HOME/Code/dotfiles/.ruby-version"

# Hammerspoon: https://github.com/Hammerspoon/hammerspoon
links["$HOME/.hammerspoon"]="$HOME/Code/dotfiles/.hammerspoon"

# Yabai: https://github.com/koekeishiya/yabai
links["$HOME/.yabairc"]="$HOME/Code/dotfiles/.yabairc"

# Simple hotkey daemon for MacOS: https://github.com/koekeishiya/skhd
links["$HOME/.skhdrc"]="$HOME/Code/dotfiles/.skhdrc"

for link in "${!links[@]}"; do
  lpath="${links[$link]}"

  if [[ ! -L "$link" ]]; then
    print_color "yellow" "Symlinking $lpath to $link"
    ln -s "$lpath" "$link"
  else
    print_color "blue" "Symlink from $lpath to $link exists"
  fi
done
