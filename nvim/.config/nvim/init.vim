""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim config file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible " be iMproved, required
filetype off " required
let g:polyglot_disabled = ['markdown.plugin'] " Needs to be defined before loading polyglot

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins managed by Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" File management
    Plug 'vifm/vifm.vim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
" Productivity
    Plug 'junegunn/goyo.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'tpope/vim-surround'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'preservim/nerdcommenter'
    Plug 'godlygeek/tabular'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/deoplete-lsp'
    Plug 'tjdevries/cyclist.vim',
" Syntax Highlighting and language support
    Plug 'ap/vim-css-color'
    Plug 'sheerun/vim-polyglot'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Themes
    Plug 'delafthi/onehalf', { 'rtp': 'vim' }

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

" Load lua lsp config
lua require('lsp')
" Load lua treesitter config
lua require('treesitter')
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete

" Display all matches when tab complete
set wildmenu
" Set autocomplete mode
set wildmode=longest,full
" Remove popup menu for autocompletion
set wildoptions-=pum

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme

"Enable corolscheme onehalfdark
colorscheme onehalfdark
" Set column 80 to be highlighted
set colorcolumn=80
" Highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits and Tabbed Files

" The new window is is displayed on the right or below
set splitbelow splitright
" Fill the vertical separator with |
set fillchars+=vert:\|
" Fill the horizontal separator with -
set fillchars+=stlnc:-

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings

" Remap ESC to ii
inoremap ii <Esc>
" Remap Leader key to SPACE
let mapleader = "\<Space>"
" Remap hjkl keys to navigate also the wrapped lines
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> k gk
" Open terminal inside Vim
nmap <silent> <Leader>tt :new term://fish<cr>
" Remap splits navigation to just CTRL + hjkl
tnoremap <silent> <C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-l> <C-\><C-n><C-w>l
inoremap <silent> <C-h> <C-\><C-n><C-w>h
inoremap <silent> <C-j> <C-\><C-n><C-w>j
inoremap <silent> <C-k> <C-\><C-n><C-w>k
inoremap <silent> <C-l> <C-\><C-n><C-w>l
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" Make adjusting split sizes a bit more friendly
tnoremap <silent> <C-Left> <C-\><C-n> :vertical resize +2<cr>
tnoremap <silent> <C-Up> <C-\><C-n> :resize +2<cr>
tnoremap <silent> <C-Down> <C-\><C-n> :resize -2<cr>
tnoremap <silent> <C-Right> <C-\><C-n> :vertical resize -2<cr>
inoremap <silent> <C-Left> :vertical resize +2<cr>
inoremap <silent> <C-Up> :resize +2<cr>
inoremap <silent> <C-Down> :resize -2<cr>
inoremap <silent> <C-Right> :vertical resize -2<cr>
nnoremap <silent> <C-Left> :vertical resize +2<cr>
nnoremap <silent> <C-Up> :resize +2<cr>
nnoremap <silent> <C-Down> :resize -2<cr>
nnoremap <silent> <C-Right> :vertical resize -2<cr>
" Change 2 split windows from vert to horiz or horiz to vert
nnoremap <silent> <leader>lv <C-w>t<C-w>H
nnoremap <silent> <leader>lh <C-w>t<C-w>K
" Show current buffer and change to buffer
nmap <silent> <leader>fb <cmd>Telescope buffers<cr>
" Kill specified buffer
nmap <silent> <leader>bk :ls<cr>:bd<Space>
" Search for files located in the same in recursive dirs
nmap <silent> <leader>ff <cmd>Telescope find_files<cr>
" global grep in project files
nmap <silent> <leader>fg <cmd>Telescope live_grep<cr>
" Enable/Disable spell checker
map <silent> <leader>o :setlocal spell!<cr>
" Save file as sudo on files that require root permission
cmap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse settings

" Sets the current mouse mode as normal, visual , insert and
set mouse=nvicr

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gui options

"remove menu bar
set guioptions-=m
"remove toolbar
set guioptions-=T
"remove right-hand scroll bar
set guioptions-=r
"remove left-hand scroll bar
set guioptions-=L

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types

" Markdown
au! BufRead,BufNewFile,BufFilePre *.markdown set filetype=mkd
au! BufRead,BufNewFile,BufFilePre *.md set filetype=mkd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other functions

" Automatically deletes all trailing whitespace and newlines at end of file on
" save.
autocmd BufWritePre * mark m | %s/\s\+$//e | 'm
autocmd BufWritepre * mark m | %s/\n\+\%$//e | 'm

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete
let g:deoplete#enable_at_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo
"
nmap <silent> <Leader>gg :Goyo<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cyclist

" Cycle through the differenc cyclist configurations
nmap <silent> <leader>ln <plug>CyclistNext
nmap <silent> <leader>lp <plug>CyclistPrev

call cyclist#add_listchar_option_set('all', {
            \ 'eol': '↲',
            \ 'tab': '»·',
            \ 'space': '␣',
            \ 'trail': '-',
            \ 'extends': '☛',
            \ 'precedes': '☚',
            \ 'conceal': '┊',
            \ 'nbsp': '☠',
            \ })

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vifm

nmap <silent> <leader>vv :Vifm<cr>
nmap <silent> <leader>vs :VsplitVifm<cr>
nmap <silent> <leader>sp :SplitVifm<cr>
nmap <silent> <leader>dv :DiffVifm<cr>
nmap <silent> <leader>tv :TabVifm<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimWiki

" Disable rainbow mode in vimwiki
let g:vimwiki_list = [{
            \ 'path': '~/Vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md',
            \ 'auto_tags': 1, 'auto_toc': 1,
            \ }]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_use_mouse = 1
let g:vimwiki_auto_chdir = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown-Preview

" If set to 1 markdown preview is only refreshed, when the buffer is saved or
" insert mode is exited
let g:mkdp_refresh_slow = 0
" Browser to open the preview
let g:mkdp_browser = 'brave'
" Define title of the browser page
let g:mkdp_page_tittle = '${name}'
" Set keybinging to launch the markdown preview
autocmd Filetype mkd,vimwiki nmap <silent> <Leader>mp <Plug>MarkdownPreviewToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDCommenter

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
            \ 'c': { 'left': '/**','right': '*/' },
            \ 'python': { 'left': '#','right': '' },
            \ }
