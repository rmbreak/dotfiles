HISTSIZE=200000
SAVEHIST=200000
HISTFILE=$HOME/.zsh_history

EDITOR='vim'
LESS='-iFRX'
PAGER='less'

export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"

typeset -U path
path+="$HOME/.cargo/bin"
path+="$HOME/.npm-global/bin"
export PATH
