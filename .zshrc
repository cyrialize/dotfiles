# My personal zshrc file

# File and dependencies to load:

# zsh
source $HOME/Code/dotfiles/.zsh_aliases

# pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_tomorrow-night-eighties

# chruby
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh

# Run on terminal startup:

fortune | cowsay