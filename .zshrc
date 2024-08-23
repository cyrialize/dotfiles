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

# Run on terminal startup:

fortune | cowsay
