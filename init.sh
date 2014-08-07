#!/bin/sh

backup_and_link () {
  if [ -z "$1" ]; then
    error "Function parameter missing"
    exit 1
  fi

  if [ -e "$HOME/.$1" ]; then
    echo "Moving $HOME/.$1 to $HOME/.$1.bak"
    mv "$HOME/.$1" "$HOME/.$1.bak"
  fi
  ln -s $(pwd)/$1 $HOME/.$1
}

# ZSH
backup_and_link 'zsh'
if [ -f "$HOME/.zshrc" ]; then
  echo -e '\n' >> $HOME/.zshrc
  echo '# Source other ZSH files' >> $HOME/.zshrc
  echo 'for file in ~/.zsh/*.sh; do' >> $HOME/.zshrc
  echo '  if [ -f "$file" ]; then' >> $HOME/.zshrc
  echo '    source "$file"' >> $HOME/.zshrc
  echo '  fi' >> $HOME/.zshrc
  echo 'done' >> $HOME/.zshrc
fi

# Xresources
backup_and_link 'Xresources'

# gitconfig
backup_and_link 'gitconfig'

# tmux.conf
backup_and_link 'tmux.conf'

# vim
backup_and_link 'vim'
backup_and_link 'vimrc'
vim +PluginInstall +qall
