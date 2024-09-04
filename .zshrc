# My personal zshrc file

# File and dependencies to load:

# zsh
source $HOME/Code/dotfiles/.zsh_aliases

# pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# chruby
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh

# clamscan
export PATH=/usr/local/clamav/bin:/usr/local/clamav/sbin:$PATH

# brew
export HOMEBREW_BUNDLE_FILE_GLOBAL=$HOME/.brewfile

# Run on terminal startup:

fortune | cowsay -f small
