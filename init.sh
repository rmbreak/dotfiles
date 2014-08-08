#!/bin/sh

backup_and_link () {
  if [ -z "$1" ]; then
    error "Function parameter missing"
    exit 1
  fi

  if [ -e "$HOME/.$1" ]; then
    if [ -L "$HOME/.$1.bak" ] && [ -d "$HOME/.$1.bak" ]; then
      rm "$HOME/.$1.bak"
    fi
    echo "Moving $HOME/.$1 to $HOME/.$1.bak"
    mv "$HOME/.$1" "$HOME/.$1.bak"
  fi
  ln -s $(pwd)/$1 $HOME/.$1
}

git submodule update --init

# ZSH
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
for file in zsh/*; do
  if [ -f "$file" ] && [ ! -f "$HOME/.oh-my-zsh/custom/$(basename $file)" ]; then
    ln -s $(pwd)/zsh/$(basename $file) "$HOME/.oh-my-zsh/custom/$(basename $file)"
  fi
done

backup_and_link 'zshrc'

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
