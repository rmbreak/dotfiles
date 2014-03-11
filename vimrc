filetype off
filetype plugin indent on
set nocompatible
set t_Co=256 " Support 256 colors

" Bundles ---------------------------- {{{
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'git@github.com:Lokaltog/powerline.git', {'rtp': 'powerline/bindings/vim/'}
Bundle 'git@github.com:godlygeek/tabular.git'
Bundle 'git@github.com:kien/ctrlp.vim.git'
Bundle 'git@github.com:kien/rainbow_parentheses.vim.git'
Bundle 'git@github.com:mileszs/ack.vim.git'
Bundle 'git@github.com:scrooloose/nerdtree.git'
Bundle 'git@github.com:scrooloose/syntastic.git'
Bundle 'git@github.com:tpope/vim-fugitive.git'
Bundle 'git@github.com:tpope/vim-surround.git'
Bundle 'git@github.com:zeis/vim-kolor.git'
" }}}
" Leader ---------------------------- {{{
let mapleader = ","
let maplocalleader = "\\"
" }}}
" Basic options ---------------------------- {{{
syntax on
set encoding=utf-8
set expandtab
set clipboard+=unnamed
set list
set listchars=tab:▸\ 
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
" Error Toggles ---------------------- {{{
command! ErrorsToggle call ErrorsToggle()
function! ErrorsToggle()
    if exists("w:is_error_window")
        unlet w:is_error_window
        exec "q"
    else
        exec "Errors"
        lopen
        let w:is_error_window = 1
    endif
endfunction

command! -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction

nmap <silent> <f3> :ErrorsToggle<cr>
nmap <silent> <f4> :QFixToggle<cr>
" }}}
" Rainbow Parens --------------------- {{{
augroup rainbow_parens
    au!
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
augroup END

noremap <leader>R :RainbowParenthesesToggle<cr>
" }}}
" Syntastic --------------------- {{{
let g:syntastic_check_on_open=1
" }}}

set notimeout
set ttimeout
set ttimeoutlen=10

augroup reload_vimrc
    au!
    au BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

colorscheme kolor

" Resize splits when window is resized
au VimResized * :wincmd =

nnoremap <F1> <nop>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ef :execute ":vsplit " . $HOME . "/.vim/ftplugin/" . &filetype . ".vim"<cr>
nnoremap <leader>es :execute ":vsplit " . $HOME . "/.zshrc"<cr>

" j and k within a wrap
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy buffer navigation
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" Close all but this window
nnoremap <leader>tw :on<cr>

" Keep search matches in the middle of the window and open fold
nnoremap n nzzzv
nnoremap N Nzzzv

" Disable beeping
set t_vb=
