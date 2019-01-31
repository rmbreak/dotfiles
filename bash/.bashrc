# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User defined functions and aliases
export LESS='-iFRX'
alias la='ls -al'
alias c='clear'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
