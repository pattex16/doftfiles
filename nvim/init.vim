"          _                     _
" ___  ___| |____     _ ____   _(_)_ __ ___
"/ __|/ _ \ |_  /____| '_ \ \ / / | '_ ` _ \
"\__ \  __/ |/ /_____| | | \ V /| | | | | | |
"|___/\___|_/___|    |_| |_|\_/ |_|_| |_| |_|
"
set mouse=a
set clipboard+=unnamedplus
set number "relativenumber
set expandtab
set smarttab
set wrap
set linebreak
set shiftwidth=2
set tabstop=2
set ignorecase
set splitbelow splitright
set shortmess=at
set signcolumn=no
syntax on
filetype plugin on
" set spell
set spelllang=en,it





set undofile
set undodir=~/.cache/neovim/

"bracket completion
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

map <Nul> <c-space>
map! <Nul> <c-space>
inoremap <c-space> <c-n>

"standard remasps
noremap } $
noremap { _
noremap + <C-a>
noremap _ <C-x>
noremap x "_x
noremap g/ :noh<CR>
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap l <Space>
noremap h <Backspace>
noremap <Down> gj
noremap <Up> gk
noremap <Right> <Space>
noremap <Left> <Backspace>
noremap ; :
noremap <C-;> q:
noremap H b
noremap L w
" noremap J <C-d>
" noremap K <C-u>
" map J j
" map K k
map Q gq


if exists('g:vscode')

if len($TMUX) > 1
autocmd VimEnter,BufWrite,BufNewFile,BufRead,BufReadPost,FileReadPost,BufNewFile * call system("tmux set-window-option window-status-current-style 'fg=black bg=yellow';tmux set-window-option window-status-style 'fg=yellow'")
autocmd VimEnter,BufWrite,BufNewFile,BufRead,BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
endif
" autocmd BufRead,BufNewFile *.txt silent! setlocal spell

else
"plugin remaps
"
call plug#begin('$HOME/.local/share/nvim/site/autoload/plug.nvim')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'Chiel92/vim-autoformat'
Plug 'jreybert/vimagit'
Plug 'itchyny/lightline.vim'
Plug 'gmarmstrong/vim-muse'
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mbbill/undotree'
Plug 'tpope/vim-abolish'
" Plug 'raimondi/delimitmate'
call plug#end()

noremap <C-o> :NERDTreeToggle<CR>
noremap <C-u> :UndotreeToggle<CR>
noremap <C-F> :Autoformat<CR>
inoremap <C-/> :Commentary<CR>
noremap <C-/> :Commentary<CR>

"tmux remaps
" autocmd VimEnter,VimLeave * :silent !tmux set status
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>

let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

let g:autoformat_autoindent = 2
let g:autoformat_retab = 2
let g:autoformat_remove_trailing_spaces = 0

inoremap <silent><expr> <c-space> coc#refresh()
"let g:coc

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

endif

nnoremap <C-b> :call ToggleBar()<CR>

command W w! !sudo tee %
command Q q!

command P !out=$(echo %); tmux split-window "zsh -c 'python3 $out; echo ; echo $out finished ; read'"
command J !out=$(echo %); tmux split-window "zsh -c 'node $out; echo ; echo $out finished ; read'"
command H !xdg-open ./index.html

command Code !code %

"autocmd
autocmd VimLeave *.js,*.js,*.css,*.c,*.cpp,*.h,*.html,*.xml,*.java,*.js,*.json,*.go,*.py Autoformat



autocmd FileType * RainbowParentheses

"simple user functions

function! HideBar()
  let s:Hidden = 1
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
endfunction

function! ShowBar()
  let s:Hidden = 0
  set noshowmode
  set noruler
  set laststatus=2
  set noshowcmd
endfunction

function! ToggleBar()
  if s:Hidden  == 0
    : call HideBar()
  else
    : call ShowBar()
  endif
endfunction

:call HideBar()

autocmd Filetype python noremap M :w<CR>:silent P<CR>
autocmd Filetype javascript noremap M :w<CR>:silent J<CR>
autocmd Filetype html noremap M :w<CR>:silent !xdg-open %<CR>
autocmd Filetype c noremap M :w<CR>:!make<CR>
