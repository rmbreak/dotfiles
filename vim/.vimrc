set nocompatible

" Basic Options ---------------------------- {{{
""" To get more information about these options,
""" type :help '<option>' where <option> is a
""" set option.
"""
""" Example: :help 'expandtab'
"""
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 12"
set t_vb= " Disable beeping
set t_Co=256 " Support 256 colors
set encoding=utf-8
set expandtab
set clipboard+=unnamed
set list
set mouse=a
set listchars=tab:▸\ 
set cursorline
set hlsearch
set wildmenu
set ignorecase
set smartcase
set shortmess+=I
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
set notimeout
set ttimeout
set ttimeoutlen=10
set autoread
set laststatus=2 " always display the statusline in all windows
set noshowmode " hide the default mode text (e.g. -- INSERT -- below the statusline)
let mapleader = ","
let maplocalleader = "\\"
" }}}
" Plugins ---------------------------- {{{
"   Init ---------------------------- {{{
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'pearofducks/ansible-vim'
Plug 'reedes/vim-thematic'
Plug 'terryma/vim-multiple-cursors'
Plug 'chriskempson/base16-vim'
Plug 'wting/rust.vim'
Plug 'elzr/vim-json'
Plug 'kchmck/vim-coffee-script'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-libclang' }
Plug 'fatih/vim-go'
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'mustache/vim-mustache-handlebars'
if !has("nvim")
    Plug 'SirVer/ultisnips'
endif
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
call plug#end()
"   }}}
" Plugin: NERDTree --------------------------- {{{
noremap <F2> :NERDTreeToggle<cr>
"   }}}
" Plugin: Rainbow Parens --------------------- {{{
augroup rainbow_parens
    au!
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
augroup END

noremap <leader>R :RainbowParenthesesToggle<cr>
" }}}
" Plugin: Syntastic --------------------- {{{
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" }}}
" Plugin: Airline --------------------- {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
" }}}
" Plugin: JSON ------------------------ {{{
let g:vim_json_syntax_conceal = 0
" }}}
" Plugin: Pymode  ------------------------ {{{
let g:pymode_indent = 1
let g:pymode_rope = 0
let g:pymode_lint_write = 0
" }}}
" Plugin: Tagbar  ------------------------ {{{
nmap <silent> <f5> :TagbarToggle<cr>
" }}}
" Plugin: YouCompleteMe  ------------------------ {{{
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" }}}
" Plugin: Ultisnips  ------------------------ {{{
let g:UltiSnipsExpandTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<c-k>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"
" }}}
" }}}
" General Mappings ---------------------- {{{
"disable f1 opening help pages
nnoremap <F1> <nop>
inoremap <F1> <nop>

" j and k within a wrap
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" easier buffer navigation
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" Keep search matches in the middle of the window and open fold
nnoremap n nzzzv
nnoremap N Nzzzv

" removes all windows except (t)his (w)indow
nnoremap <leader>tw :on<cr>

" toggle search highlighting
nnoremap <leader>hs :set hlsearch!<cr>

" source current line and selection
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^yg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" save file using sudo
cnoremap w!! w !sudo tee % > /dev/null

" clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" shortcuts for opening splits of files
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ef :execute ":vsplit " . $HOME . "/.vim/ftplugin/" . split(&filetype, '\.')[-1] . ".vim"<cr>
nnoremap <leader>es :execute ":vsplit " . $HOME . "/.zshrc"<cr>
" }}}
" Functions ---------------------- {{{
"   List Toggles ---------------------- {{{
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
" }}}
" Autocmds ---------------------- {{{
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:¬
    au InsertLeave * :set listchars+=trail:¬
augroup END

" resize splits when window is resized
au VimResized * :wincmd =
" }}}
" Colors ---------------------------- {{{
set background=dark
let base16colorspace=256
colorscheme base16-default
hi Normal ctermbg=none

hi clear CursorLine
hi CursorLineNR cterm=bold gui=bold ctermfg=10 guifg=#A1B56C
augroup cusorline_color
    au!
    au ColorScheme * hi clear CursorLine
    au ColorScheme * hi CursorLineNR cterm=bold gui=bold ctermfg=10 guifg=#A1B56C
augroup END
" }}}
