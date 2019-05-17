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
set backupcopy=yes
set wildmenu
set ignorecase
set smartcase
set shortmess+=I
set relativenumber
set number
set splitright
set foldlevelstart=99
set splitbelow
set smartindent
set cinoptions=g0(0:0
set softtabstop=4
set tabstop=4
set shiftwidth=4
set wrap
set notimeout
set ttimeout
set ttimeoutlen=10
set autoread
set hidden
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

Plug 'christoomey/vim-tmux-navigator'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'

Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Completion plugins
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-go'
Plug 'wellle/tmux-complete.vim'

" tmux-complete
let g:tmuxcomplete#asyncomplete_source_options = {
            \ 'name':      'tmuxcomplete',
            \ 'config': {
            \     'splitmode':      'ilines,words'
            \     }
            \ }

Plug 'rust-lang/rust.vim'
Plug 'mattn/webapi-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'

" TODO: explore
" Plug 'reedes/vim-thematic'
Plug 'benmills/vimux'
" Plug 'matze/vim-move'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Plug 'pearofducks/ansible-vim'
" Plug 'wting/rust.vim'
" Plug 'elzr/vim-json'
" Plug 'kchmck/vim-coffee-script'
" Plug 'klen/python-mode', { 'for': 'python' }
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'majutsushi/tagbar'
" Plug 'isRuslan/vim-es6', { 'for': 'javascript' }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" Plug 'leafgarland/typescript-vim'

call plug#end()
"   }}}
" Plugin: vim-easy-align --------------------------- {{{
xmap <Enter> <Plug>(EasyAlign)
"   }}}
" Plugin: NERDTree --------------------------- {{{
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeMapOpenSplit = 'x'
noremap <F1> :NERDTreeToggle<cr>
"   }}}
" Plugin: Airline --------------------- {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
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
" Plugin: Typescript  ------------------------ {{{
let g:typescript_compiler_options = '--jsx react'
" }}}
" Plugin: Move  ------------------------ {{{
" let g:move_key_modifier = ''
" }}}
" Plugin: Javascript  ------------------------ {{{
" }}}
" }}}
" General Mappings ---------------------- {{{
" disable f1 opening help pages
inoremap <F1> <nop>

" disable going into ex mode by accident
nnoremap Q <nop>

" unjoin at cursor
" nnoremap K i<cr><esc>k:s/\s\+$//<cr>j

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

" easier buffer sizing
noremap <s-left> :vertical resize -5<cr>
noremap <s-right> :vertical resize +5<cr>
noremap <s-down> :resize -5<cr>
noremap <s-up> :resize +5<cr>

" easier buffer switching
nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>

nnoremap <leader>f <c-i>
nnoremap <leader>b <c-o>

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
" nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" shortcuts for opening splits of files
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>ef :execute ":vsplit " . $HOME . "/.config/nvim/ftplugin/" . split(&filetype, '\.')[-1] . ".vim"<cr>
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
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  set termguicolors
  source ~/.vimrc_background
endif
hi Normal ctermbg=none

hi clear CursorLine
hi CursorLineNR cterm=bold gui=bold ctermfg=10 guifg=#A1B56C
augroup cusorline_color
    au!
    au ColorScheme * hi clear CursorLine
    au ColorScheme * hi CursorLineNR cterm=bold gui=bold ctermfg=10 guifg=#A1B56C
augroup END
" }}}



if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~30%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>= reformats current tange
nnoremap <leader>= :'<,'>RustFmtRange<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" M to make
noremap M :!make -k -j4<cr>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Linter
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0

noremap <C-q> :confirm qall<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" language server protocol
let g:LanguageClient_settingsPath = "/home/mack/.config/nvim/settings.json"
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rls'],
            \ 'python': ['pyls'],
            \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Set tab complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Don't hijack enter key
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<CR>"):"\<CR>")

"""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quick-save
nmap <leader>w :w<CR>

set tags=.git/tags

" nmap <silent> L <Plug>(ale_lint)
nmap <silent> L <Plug>(ale_lint)

if has('nvim')
    runtime! plugin/python_setup.vim
endif

