HISTSIZE=200000
SAVEHIST=200000
HISTFILE=$HOME/.zsh_history

export EDITOR='vim'
export LESS='-iFRX'
export PAGER='less'

export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
export RLS_ROOT="$HOME/.rls"

typeset -U path
path+="$HOME/.cargo/bin"
path+="$HOME/.npm-global/bin"
export PATH

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib"
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib"
export LD_LIBRARY_PATH

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
