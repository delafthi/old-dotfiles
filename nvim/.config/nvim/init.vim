""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim config file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " be iMproved, required
filetype off " required
let g:polyglot_disabled = ['markdown.plugin']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins managed by Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" File management
    Plug 'vifm/vifm.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Productivity
    Plug 'junegunn/goyo.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'tpope/vim-surround'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'preservim/nerdcommenter'
    Plug 'godlygeek/tabular'
    Plug 'ludovicchabant/vim-gutentags'
" Syntax Highlighting and Colors
    Plug 'luochen1990/rainbow'
    Plug 'ap/vim-css-color'
    Plug 'sheerun/vim-polyglot'
" Themes
    Plug 'itchyny/lightline.vim'
    Plug 'sonph/onehalf', { 'rtp': 'vim' }

call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
"                     :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"                     auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set window title by default.
set title
" Don't display the intro message on starting Vim.
set shortmess+=I
" Searches current directory recursiveliy
set path+=**
" Needed to keep multiple buffers open
set hidden
" No auto backups
set nobackup
" No swap files
set noswapfile
" If terminal supports truecolor
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " Set 24bit color support
  set termguicolors
else
    " Else set 256 color mode
    set t_Co=256
endif
" Display line numbers
set number relativenumber
" Copy/paste between vim and other programs
set clipboard=unnamedplus
" Enable better theme colors
let g:rehash256 = 1
" Reload unchanged files automatically.
set autoread
" Auto reload if file was changed somewhere else (for autoread)
au CursorHold * checktime
" Disable annoying error and beeps
set noerrorbells
set visualbell
" Don't parse modelines (google "vim modeline vulnerability").
set nomodeline
" Search upwards for tags file instead only locally
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif
" Fix issues with fish shell
" https://github.com/tpope/vim-sensible/issues/50
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

" Autocomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display all matches when tab complete
set wildmenu
" Set autocomplete mode
set wildmode=longest,full
" Remove popup menu for autocompletion
set wildoptions-=pum

" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incremental search
set incsearch
" Enable search highlighting.
set hlsearch
" Ignore case when searching.
set ignorecase
" Don't ignore case when search has capital letter
" (although also don't ignore case by default).
set smartcase
" Use dash as word separator.
set iskeyword+=-

" Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highligt cursorline
set cursorline
" Keep 8 lines above or below t
set scrolloff=8
" Set textwidth to 80 columns
set textwidth=80
" Prevents word wrapping in between words
set wrap linebreak
" String to put at the start of the line if the line has been wrapped
let &showbreak='>>> '
" On 'wrap' display the last line even if it does not fit
set display +=lastline
" Set options of automatic formating
set formatoptions=tcqj
" Set spell check languages
set spelllang=en_us,de_ch
" Enable syntax highlighting
syntax on
" Use spaces instead of tabs.
set expandtab
" Be smart using tabs ;)
set smarttab
" One tab == four spaces.
set shiftwidth=4
" One tab == four spaces.
set tabstop=4

" Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable corolscheme onehalfdark
colorscheme onehalfdark
" Set column 80 to be highlighted
set colorcolumn=80

" Splits and Tabbed Files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The new window is is displayed on the right or below
set splitbelow splitright
" Fill the vertical separator with |
set fillchars+=vert:\|
" Fill the horizontal separator with -
set fillchars+=stlnc:-

" Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap ESC to ii
inoremap ii <Esc>
" Remap hjkl keys to navigate also the wrapped lines
vmap j gj
vmap k gk
nmap j gj
nmap k gk
" Remap Leader key to SPACE
let mapleader = "\<Space>"
" Open terminal inside Vim
noremap <Leader>tt :new term://bash<cr>
" Remap splits navigation to just CTRL + hjkl
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Make adjusting split sizes a bit more friendly
tnoremap <silent> <C-Left> <C-\><C-N> :vertical resize +2<cr>
tnoremap <silent> <C-Up> <C-\><C-N> :resize +2<cr>
tnoremap <silent> <C-Down> <C-\><C-N> :resize -2<cr>
tnoremap <silent> <C-Right> <C-\><C-N> :vertical resize -2<cr>
inoremap <silent> <C-Left> :vertical resize +2<cr>
inoremap <silent> <C-Up> :resize +2<cr>
inoremap <silent> <C-Down> :resize -2<cr>
inoremap <silent> <C-Right> :vertical resize -2<cr>
nnoremap <silent> <C-Left> :vertical resize +2<cr>
nnoremap <silent> <C-Up> :resize +2<cr>
nnoremap <silent> <C-Down> :resize -2<cr>
nnoremap <silent> <C-Right> :vertical resize -2<cr>
" Change 2 split windows from vert to horiz or horiz to vert
nnoremap <Leader>th <C-w>t<C-w>H
nnoremap <Leader>tk <C-w>t<C-w>K
" Show current buffer and change to buffer
nnoremap <Leader>bb :ls<CR>:b<Space>
" Kill specified buffer
nnoremap <Leader>bk :ls<CR>:bd<Space>
" Open files located in the same dir in with the current file is edited
nnoremap <leader>ff :e<Space>
" Enable/Disable spell checker
map <Leader>o :setlocal spell!<CR>
" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Mouse settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets the current mouse mode as normal, visual , insert and
set mouse=nvicr

" Gui options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"remove menu bar
set guioptions-=m
"remove toolbar
set guioptions-=T
"remove right-hand scroll bar
set guioptions-=r
"remove left-hand scroll bar
set guioptions-=L

" File types
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
au! BufRead,BufNewFile,BufFilePre *.markdown set filetype=mkd
au! BufRead,BufNewFile,BufFilePre *.md set filetype=mkd

" Other functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically deletes all trailing whitespace and newlines at end of file on
" save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Rainbow
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable rainbow brackets
let g:rainbow_active = 1
" Set colors for rainbow brackets
let g:rainbow_conf = {
\	'guifgs': ['#61afef', '#c678dd', '#e06c75', '#e5c07b'],
\	'ctermfgs': ['blue', 'magenta', 'red', 'yellow'],
\}


" Goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>gg :Goyo<cr>

" Fuzzy Finder
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" LightLine
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set nord as the lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ }
" Always show the statusline
set laststatus=2
" Uncomment to prevent non-normal modes showing in powerline
set noshowmode

" Vifm
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>vv :Vifm<cr>
nnoremap <Leader>vs :VsplitVifm<cr>
nnoremap <Leader>sp :SplitVifm<cr>
nnoremap <Leader>dv :DiffVifm<cr>
nnoremap <Leader>tv :TabVifm<cr>

" VimWiki
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable rainbow mode in vimwiki
autocmd FileType vimwiki :RainbowToggleOff
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'auto_tags': 1, 'auto_toc': 1}]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_use_mouse = 1
let g:vimwiki_auto_chdir = 1

" Markdown-Preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If set to 1 markdown preview is only refreshed, when the buffer is saved or
" insert mode is exited
let g:mkdp_refresh_slow = 0
" Browser to open the preview
let g:mkdp_browser = 'brave'
" Define title of the browser page
let g:mkdp_page_tittle = '${name}'
" Set keybinging to launch the markdown preview
autocmd Filetype mkd,vimwiki nmap <Leader>mp <Plug>MarkdownPreviewToggle
