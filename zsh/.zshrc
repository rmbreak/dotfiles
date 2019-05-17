bindkey -v

setopt autocd
setopt autopushd
setopt completeinword
setopt extendedglob
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histverify
setopt interactivecomments
setopt longlistjobs
setopt nobeep
setopt noflowcontrol
setopt promptsubst
setopt pushdignoredups
setopt sharehistory
setopt vi

autoload -Uz colors
colors

autoload -Uz run-help
autoload -Uz run-help-git
unalias_run-help() {
    local its_type="$(whence -w run-help)"
    if [[ ${its_type##* } == 'alias' ]]; then
        unalias run-help
    fi
}; unalias_run-help; unset -f unalias_run-help
alias help='run-help'

##### COMPLETION #####
fpath+=~/.zfunc

autoload -Uz compinit
compinit

zmodload zsh/complist

bindkey -r '^[/'
bindkey '^?' backward-delete-char

zstyle '*' single-ignored show

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ":completion:*:commands" rehash true

# ignore internal zsh functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# process completion shows all processes with colors
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' command 'ps -A -o pid,user,cmd'
zstyle ':completion:*:*:*:*:processes' list-colors "=(#b) #([0-9]#)*=0=${color[green]}"
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'
##### END COMPLETION #####

##### PROMPT #####
source $HOME/.zsh/zsh-git-prompt/zshrc.sh

prompt_setup_pygmalion() {
  base_prompt='%{$fg[magenta]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[yellow]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_super_status)'
  post_prompt='%{$fg[cyan]%}⇒%{$reset_color%}  '

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_pygmalion_precmd)
}

prompt_pygmalion_precmd() {
  local nl=""
  nl=$'\n%{\r%}';

  PROMPT="$base_prompt$gitinfo$nl$post_prompt"
}

prompt_setup_pygmalion
##### END PROMPT #####

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

if hash xdg-open 2>/dev/null; then
    function o open () {
        if [[ -d "$1" ]] && hash nautilus 2>/dev/null; then
            nautilus "$1"
        else
            xdg-open "$1"
        fi
    }
fi

function gi() {
    local langs=

    for arg in "$@"; do
        langs="$arg,$langs"
    done
    langs=${langs//%,/}

    curl -s "https://www.gitignore.io/api/$langs"
}

function compress() {
    setopt ksh_glob

    function usage() {
        echo "usage: compress <path>"
    }

    if [[ $# -ne 1 ]]; then
        usage
        return -1
    fi

    local file=${1/%+(\/)}
    if [[ -f $file ]]; then
        xz --threads=0 --keep "$file" > "${file##*/}.xz"
    elif [[ -d $file ]]; then
        tar -cf - "$file" | xz --threads=0 > "${file##*/}.tar.xz"
    else
        usage
        return -1
    fi

    unsetopt ksh_glob
}

alias history='fc -l 1'
alias c='clear'
alias itt='img2txt'
alias tmux='tmux -2'
alias grep='grep --color=always'
alias ls='ls --color=auto'
alias cr='cargo run'
alias l='ls -lh'
alias la='ls -alh'
alias time='command time'
alias weather='curl -s http://wttr.in'
command -v nvim &>/dev/null && alias vim=nvim

# Base16 shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Syntax highlighting
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias nvim_pluginstallall='nvim +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins'

function search() {
    selected_line=$(sk --ansi -i -c 'rg --line-number --color=always "{}"')
    split_lines=("${(@s/:/)selected_line}")
    if [[ ${#split_lines} > 1 ]]; then
        vim +${split_lines[2]} "${split_lines[1]}"
    fi
}

function searchi() {
    selected_line=$(sk --ansi -i -c 'rg -i --line-number --color=always "{}"')
    split_lines=("${(@s/:/)selected_line}")
    if [[ ${#split_lines} > 1 ]]; then
        vim +${split_lines[2]} "${split_lines[1]}"
    fi
}

[ -f /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias docker_postgres='docker run -e POSTGRES_USER=mack -e POSTGRES_PASSWORD='' -p 5432:5432 -d postgres'
