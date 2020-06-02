HISTSIZE=200000
SAVEHIST=200000
HISTFILE=$HOME/.zsh_history

export EDITOR='nvim'
export LESS='-iFRX'
export PAGER='less'
export GOPATH="$HOME/.go"

export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"

typeset -U path
path+="$HOME/.cargo/bin"
path+="$HOME/.npm-global/bin"
path+="$GOPATH/bin"
path+="$HOME/.local/bin"
export PATH

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib"
export LD_LIBRARY_PATH

export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;37:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'

