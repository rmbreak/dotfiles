# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pygmalion-custom"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gpg-agent jsontools pip web-search zsh-syntax-highlighting rust cargo gitignore)
source "$ZSH/oh-my-zsh.sh"

### User configuration
export LESS='-iFRX'
bindkey -v

if hash xdg-open 2>/dev/null; then
    function o open () {
        if [[ -d "$1" ]] && hash nautilus 2>/dev/null; then
            nautilus "$1"
        else
            xdg-open "$1"
        fi
    }
fi

alias c='clear'
alias itt='img2txt'
alias tmux='tmux -2'

alias grep="grep --color=always $GREP_OPTIONS"
unset GREP_OPTIONS

alias svim='sudo vim'

function help() {
    bash -c "help $1"
}

unalias run-help
autoload run-help

export EDITOR='vim'

# Base16 shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

function journal() {
    local year_month="$(date +%Y)/$(date +%m)"
    [[ -d "$HOME/documents/journal/$year_month/" ]] || mkdir -p "$HOME/documents/journal/$year_month/"
    ${EDITOR:-vi} "$HOME/documents/journal/$year_month/$(date +%d)"
}

function tm() {
    if [[ $# -gt 0 ]]; then
        command tmux -2 new -s "$1" -n ''
    else
        command tmux -2 new -n ''
    fi
}

function j() {
    if [[ $# -gt 0 ]]; then
        cd "$1"
        local changed_dir=true
    fi

    local file="$(fzf)"
    if [[ -n "$file" ]]; then
        cd "$(dirname "$file")"
    elif ! [[ -z "$changed_dir" ]]; then
        cd ..
    fi
}

[ -e "$HOME/.projects" ] && source "$HOME/.projects"

# alias vim to nvim if nvim exists
command -v nvim &>/dev/null && alias vim=nvim

export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$PATH:$HOME/.cargo/bin"

alias cr='cargo run'
