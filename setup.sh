#!/usr/bin/env bash

# Setup script for setting up my dotfiles
# Meant for MacOS or Linux

# shellcheck source=lib/helpers.sh
source "$HOME"/Code/dotfiles/lib/helpers.sh

help=$(cat <<EOF
Setup script for setting up my dotfiles. Intended for MacOS. Linux
support planned in the future.

Checks for OS support prior to running anything.

Usage:
-a Run all flags.
-i Run install.sh to install/update libs and pure
-e Make files in bin, and lib/hooks executable
-l Connect symlinks.
-h See this message.
EOF
)

install=1
all=1
link=1
executable=1

while getopts 'alieh' OPTION; do
    case "$OPTION" in
    a)
        all=0
        ;;
    l)
        link=0
        ;;
    i)
        install=0
        ;;
    e)
        executable=0
        ;;
    h)
        echo "$help"
        exit 0
        ;;
    ?)
        echo "$help"
        exit 1
        ;;
    esac
done

if [ "$OPTIND" -eq 1 ]; then
    echo "$help"
    exit 0
fi

if [[ "$(current_os)" == "mac" ]]; then
    print_color "yellow" "MacOS detected! Continuing..."
    which -s brew
    if ! which -s brew; then
      print_color "red" "Homebrew is not installed, install it first!"
      exit 1
    fi

    if is_installed "bash"; then
      if ! is_up_to_date "bash"; then
        print_color "yellow" "Updating bash"
        update "bash"
        log_result "Update" "$?"
      else
        print_color "yellow" "Bash is installed and up to date!"
      fi
    else
      print_color "yellow" "Installing bash"
      install "bash"
      log_result "Installation" "$?"
    fi
fi

if [[ $executable -eq 0 || $all -eq 0 ]]; then
  executableDirs=("bin" "lib/hooks")
  for dir in "${executableDirs[@]}"; do
    for script in "$dir"/*; do
      if [ -x "$script" ]; then
        print_color "blue" "$script is executable"
      else
        print_color "blue" "$script is not executable, will make it executable..."
        chmod a+x "$script"
        log_result "Ran chmod a+x"
      fi
    done
  done
fi

if [[ $link -eq 0 || $all -eq 0 ]]; then
    source "$HOME"/Code/dotfiles/bin/symlinks.sh
fi

if [[ $install -eq 0 || $all -eq 0 ]]; then
    source "$HOME"/Code/dotfiles/bin/install.sh
fi
