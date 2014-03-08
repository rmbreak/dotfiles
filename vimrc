set nocompatible
filetype plugin indent on
set t_Co=256 " Support 256 colors

" Bundles ---------------------------- {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'git@github.com:godlygeek/tabular.git'
Bundle 'git@github.com:scrooloose/nerdtree.git'
Bundle 'git@github.com:scrooloose/syntastic.git'
Bundle 'git@github.com:tpope/vim-fugitive.git'
" }}}
" Leader ---------------------------- {{{
let mapleader = ","
let maplocalleader = "\\"
" }}}
" Basic options ---------------------------- {{{
syntax on
set encoding=utf-8
set expandtab
set list
set listchars=eol:¬
set number
set splitright
set splitbelow
set smartindent
set ts=4
set sw=4
set wrap
" }}}
" NERDTree --------------------------- {{{
noremap <F2> :NERDTreeToggle<cr>
" }}}

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

let $PYTHONPATH="/usr/lib/python3.3/site-packages"
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

colorscheme jellybean

" Resize splits when window is resized
au VimResized * :wincmd =

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ef :execute ":vsplit " . $HOME . "/.vim/ftplugin/" . &filetype . ".vim"<cr>
nnoremap <leader>es :execute ":vsplit " . $HOME . "/.zshrc"<cr>

" j and k within a wrap
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Keep search matches in the middle of the window and open fold
nnoremap n nzzzv
nnoremap N Nzzzv

" Disable beeping
set t_vb=
