set nocompatible

" wondering where an unexpected option or marker was set? check ':verbose set
"
" textwidth?' as an example.

" Basic Options ---------------------------- {{{
""" to get more information about these options,
""" type :help '<option>' where <option> is a
""" set option.
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 12"
set t_vb= " Disable beeping
set t_Co=256 " Support 256 colors
set encoding=utf-8
set expandtab
set clipboard+=unnamed
set list
set mouse=a
set listchars=trail:¬,tab:▸\ 
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
" always display the statusline in all windows
set laststatus=2
" hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode
let mapleader = ","
let maplocalleader = "\\"
" }}}
" Plugins ---------------------------- {{{
"   Init ---------------------------- {{{
call plug#begin('~/.vim/plugged')

""" Source: christoomey/vim-tmux-navigator
"" seamlessly move between tmux panes and vim windows
Plug 'rmbreak/vim-tmux-navigator'

""" Source: vim-airline/vim-airline
Plug 'rmbreak/vim-airline'

""" Source: vim-airline/vim-airline-themes
Plug 'rmbreak/vim-airline-themes'

""" Source: godlygeek/tabular
Plug 'rmbreak/tabular'

""" Source: pearofducks/ansible-vim
Plug 'rmbreak/ansible-vim'

""" Source: reedes/vim-thematic
Plug 'rmbreak/vim-thematic'

""" Source: terryma/vim-multiple-cursors
Plug 'rmbreak/vim-multiple-cursors'

""" Source: chriskempson/base16-vim
Plug 'rmbreak/base16-vim'

""" Source: wting/rust.vim
Plug 'rmbreak/rust.vim'

""" Source: elzr/vim-json
Plug 'rmbreak/vim-json'

""" Source: kchmck/vim-coffee-script
Plug 'rmbreak/vim-coffee-script'

""" Source: fatih/vim-go
Plug 'rmbreak/vim-go'

""" Source: ctrlpvim/ctrlp.vim
Plug 'rmbreak/ctrlp.vim'

""" Source: kien/rainbow_parentheses.vim
Plug 'rmbreak/rainbow_parentheses.vim'

""" Source: klen/python-mode
Plug 'rmbreak/python-mode', { 'for': 'python' }

""" Source: mileszs/ack.vim
Plug 'rmbreak/ack.vim', { 'on': 'Ack' }

""" Source: scrooloose/nerdtree
Plug 'rmbreak/nerdtree', { 'on': 'NERDTreeToggle' }

""" Source: scrooloose/syntastic
Plug 'rmbreak/syntastic'

""" Source: suan/vim-instant-markdown
Plug 'rmbreak/vim-instant-markdown'

""" Source: tpope/vim-fugitive
Plug 'rmbreak/vim-fugitive'

""" Source: tpope/vim-repeat
Plug 'rmbreak/vim-repeat'

""" Source: tpope/vim-surround
Plug 'rmbreak/vim-surround'

""" Source: tpope/vim-speeddating
Plug 'rmbreak/vim-speeddating'

""" Source: tpope/vim-commentary
Plug 'rmbreak/vim-commentary'

""" Source: mustache/vim-mustache-handlebars
Plug 'rmbreak/vim-mustache-handlebars'

""" Source: honza/vim-snippets
Plug 'rmbreak/vim-snippets'

""" Source: majutsushi/tagbar
Plug 'rmbreak/tagbar'

""" Source: pangloss/vim-javascript
Plug 'rmbreak/vim-javascript', { 'for': 'javascript' }

""" Source: plasticboy/vim-markdown
Plug 'rmbreak/vim-markdown', { 'for': 'markdown' }

""" Neovim only plugins
if has("nvim")
    """ Source: Shougo/deoplete.nvim
    Plug 'rmbreak/deoplete.nvim'
endif

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
" Plugin: Deoplete  ------------------------ {{{
let g:deoplete#enable_at_startup = 1
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
augroup window_resize
    au!
    au VimResized * :wincmd =
augroup END
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
