# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User defined functions and aliases
export LESS='-iFRX'
alias la='ls -al'
alias c='clear'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

source /home/mack/.config/broot/launcher/bash/br
