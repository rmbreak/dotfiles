#!/usr/bin/env bash

backup_and_link () {
  if [[ -z "$1" ]]; then
    echo "Function parameter missing" >&2
    exit 1
  fi

  if [[ -L "$HOME/.$1" ]]; then
    rm "$HOME/.$1"
  fi

  if [[ -e "$HOME/.$1" ]]; then
    echo "Moving $HOME/.$1 to $HOME/.$1.bak"
    mv "$HOME/.$1" "$HOME/.$1.bak"
  fi
  ln -s "$(pwd)/$1" "$HOME/.$1"
}

read -p "Install packages to system (y/N)? "
if [[ "$REPLY" = [yY] ]]; then
   sudo ./scripts/install_packages.py

   mkdir pacaur
   wget -P pacaur "https://aur.archlinux.org/packages/pa/pacaur/PKGBUILD"
   cd pacaur && makepkg --noconfirm --install --clean && cd ..
   rm -rf ./pacaur

   # for YCM vim plugin
   pacaur --noconfirm --noedit -S libtinfo
fi

git submodule update --init

# ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
fi

(
cd "$HOME/.oh-my-zsh/custom/plugins" &&
  git clone --depth 1 git@github.com:zsh-users/zsh-syntax-highlighting.git
)

for file in zsh/*; do
  [[ -e "$file" ]] || continue

  if [[ -L "$HOME/.oh-my-zsh/custom/$(basename "$file")" ]]; then
    rm "$HOME/.oh-my-zsh/custom/$(basename "$file")"
  fi

  if [[ -f "$file" && ! -f "$HOME/.oh-my-zsh/custom/$(basename "$file")" ]]; then
    ln -s "$(pwd)/zsh/$(basename "$file")" "$HOME/.oh-my-zsh/custom/$(basename "$file")"
  fi
done

backup_and_link 'zshrc'
backup_and_link 'xprofile'
backup_and_link 'Xresources'
backup_and_link 'inputrc'
backup_and_link 'gitconfig'
backup_and_link 'tmux.conf'
backup_and_link 'vim'
backup_and_link 'vimrc'

mkdir -p "vim/autoload"
curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -o "./vim/autoload/plug.vim"
vimrc_plugins=$(sed -n '/set nocompatible/,/call plug#end/p' vimrc)
vim -u <(echo -n "$vimrc_plugins") +PlugUpgrade +qall # update plug.vim
vim -u <(echo -n "$vimrc_plugins") +PlugInstall +qall # install plugs

# fonts
mkdir -p "$HOME/.fonts"
cp .fonts/*.otf "$HOME/.fonts/"
fc-cache -f -v
