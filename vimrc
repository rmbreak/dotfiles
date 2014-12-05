set nocompatible
filetype off
set t_Co=256 " Support 256 colors

" Plugins ---------------------------- {{{
call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'godlygeek/tabular'
Plug 'reedes/vim-thematic'
Plug 'terryma/vim-multiple-cursors'
Plug 'chriskempson/base16-vim'
Plug 'wting/rust.vim'
Plug 'elzr/vim-json'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-libclang' }
Plug 'fatih/vim-go'
Plug 'kien/ctrlp.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'klen/python-mode', { 'for': 'python' }
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-session'
call plug#end()
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
set cursorline
set hlsearch
set wildmenu
set ignorecase
set smartcase
set number
set splitright
set foldlevelstart=99
set splitbelow
set smartindent
set cinoptions=g0(0
set softtabstop=4
set tabstop=4
set shiftwidth=4
set wrap
" }}}
" NERDTree --------------------------- {{{
noremap <F2> :NERDTreeToggle<cr>
" }}}
" List Toggles ---------------------- {{{
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l'
      exec "Errors"
      if len(getloclist(0)) == 0
          echohl ErrorMsg
          echo "Location List is Empty."
          return
      endif
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <f3> :call ToggleList("Location List", 'l')<cr>
nmap <silent> <f4> :call ToggleList("Quickfix List", 'c')<cr>
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
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" }}}
" Airline --------------------- {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
" }}}
" JSON ------------------------ {{{
let g:vim_json_syntax_conceal = 0
" }}}
" Pymode  ------------------------ {{{
let g:pymode_indent = 1
let g:pymode_rope = 0
" }}}
" Tagbar  ------------------------ {{{
nmap <silent> <f5> :TagbarToggle<cr>
" }}}
" YouCompleteMe  ------------------------ {{{
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" }}}
" Ultisnips  ------------------------ {{{
let g:UltiSnipsExpandTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<c-k>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"
" }}}
" Notes  ------------------------ {{{
let g:notes_directories = ['~/notes']
" }}}
" Session  ------------------------ {{{
let g:session_autosave = 'no'
let g:session_autoload = 'no'
" }}}

filetype plugin indent on
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^yg_y:execute @@<cr>:echo 'Sourced line.'<cr>

cnoremap w!! w !sudo tee > /dev/null %

set notimeout
set ttimeout
set ttimeoutlen=10

set autoread

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:¬
    au InsertLeave * :set listchars+=trail:¬
augroup END

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set background=dark
let base16colorspace=256
colorscheme base16-default

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

nnoremap <leader>hs :set hlsearch!<cr>

" Keep search matches in the middle of the window and open fold
nnoremap n nzzzv
nnoremap N Nzzzv

" Disable beeping
set t_vb=
