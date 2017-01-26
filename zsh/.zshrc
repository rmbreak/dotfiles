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
eval $(dircolors)

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
autoload -Uz compinit
compinit

zmodload zsh/complist

bindkey -r '^[/'
bindkey '^?' backward-delete-char

zstyle '*' single-ignored show

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'rs=0' 'di=38;5;33' 'ln=38;5;51' 'mh=00' 'pi=40;38;5;11' 'so=38;5;13' 'do=38;5;5' 'bd=48;5;232;38;5;11' 'cd=48;5;232;38;5;3' 'or=48;5;232;38;5;9' 'mi=01;05;37;41' 'su=48;5;196;38;5;15' 'sg=48;5;11;38;5;16' 'ca=48;5;196;38;5;226' 'tw=48;5;10;38;5;16' 'ow=48;5;10;38;5;21' 'st=48;5;21;38;5;15' 'ex=38;5;40' '*.tar=38;5;9' '*.tgz=38;5;9' '*.arc=38;5;9' '*.arj=38;5;9' '*.taz=38;5;9' '*.lha=38;5;9' '*.lz4=38;5;9' '*.lzh=38;5;9' '*.lzma=38;5;9' '*.tlz=38;5;9' '*.txz=38;5;9' '*.tzo=38;5;9' '*.t7z=38;5;9' '*.zip=38;5;9' '*.z=38;5;9' '*.Z=38;5;9' '*.dz=38;5;9' '*.gz=38;5;9' '*.lrz=38;5;9' '*.lz=38;5;9' '*.lzo=38;5;9' '*.xz=38;5;9' '*.bz2=38;5;9' '*.bz=38;5;9' '*.tbz=38;5;9' '*.tbz2=38;5;9' '*.tz=38;5;9' '*.deb=38;5;9' '*.rpm=38;5;9' '*.jar=38;5;9' '*.war=38;5;9' '*.ear=38;5;9' '*.sar=38;5;9' '*.rar=38;5;9' '*.alz=38;5;9' '*.ace=38;5;9' '*.zoo=38;5;9' '*.cpio=38;5;9' '*.7z=38;5;9' '*.rz=38;5;9' '*.cab=38;5;9' '*.jpg=38;5;13' '*.jpeg=38;5;13' '*.gif=38;5;13' '*.bmp=38;5;13' '*.pbm=38;5;13' '*.pgm=38;5;13' '*.ppm=38;5;13' '*.tga=38;5;13' '*.xbm=38;5;13' '*.xpm=38;5;13' '*.tif=38;5;13' '*.tiff=38;5;13' '*.png=38;5;13' '*.svg=38;5;13' '*.svgz=38;5;13' '*.mng=38;5;13' '*.pcx=38;5;13' '*.mov=38;5;13' '*.mpg=38;5;13' '*.mpeg=38;5;13' '*.m2v=38;5;13' '*.mkv=38;5;13' '*.webm=38;5;13' '*.ogm=38;5;13' '*.mp4=38;5;13' '*.m4v=38;5;13' '*.mp4v=38;5;13' '*.vob=38;5;13' '*.qt=38;5;13' '*.nuv=38;5;13' '*.wmv=38;5;13' '*.asf=38;5;13' '*.rm=38;5;13' '*.rmvb=38;5;13' '*.flc=38;5;13' '*.avi=38;5;13' '*.fli=38;5;13' '*.flv=38;5;13' '*.gl=38;5;13' '*.dl=38;5;13' '*.xcf=38;5;13' '*.xwd=38;5;13' '*.yuv=38;5;13' '*.cgm=38;5;13' '*.emf=38;5;13' '*.ogv=38;5;13' '*.ogx=38;5;13' '*.aac=38;5;45' '*.au=38;5;45' '*.flac=38;5;45' '*.m4a=38;5;45' '*.mid=38;5;45' '*.midi=38;5;45' '*.mka=38;5;45' '*.mp3=38;5;45' '*.mpc=38;5;45' '*.ogg=38;5;45' '*.ra=38;5;45' '*.wav=38;5;45' '*.oga=38;5;45' '*.opus=38;5;45' '*.spx=38;5;45' '*.xspf=38;5;45' ''
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

if hash xdg-open 2>/dev/null; then
    function o open () {
        if [[ -d "$1" ]] && hash nautilus 2>/dev/null; then
            nautilus "$1"
        else
            xdg-open "$1"
        fi
    }
fi

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
alias weather='curl http://wttr.in'
command -v nvim &>/dev/null && alias vim=nvim

# Base16 shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Syntax highlighting
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
