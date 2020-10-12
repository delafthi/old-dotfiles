""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim config file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins managed by Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

"{{ The Basics }}
    Plug 'itchyny/lightline.vim'                        " Lightline statusbar
    Plug 'luochen1990/rainbow'			                " More colors in vim
"{{ File management }}
    Plug 'vifm/vifm.vim'                                " Vifm
    Plug 'scrooloose/nerdtree'                          " Nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " Highlighting Nerdtree
    Plug 'ryanoasis/vim-devicons'                       " Icons for Nerdtree
"{{ Productivity }}
    Plug 'vimwiki/vimwiki'                              " VimWiki 
    Plug 'https://github.com/alok/notational-fzf-vim'   " Better searching for 
                                                        " notes
    Plug 'michal-h21/vim-zettel'                        " A Zettelkasten Plugin 
                                                        " for Vim and Vim-Wiki
    Plug 'jreybert/vimagit'                             " Magit-like plugin for 
                                                        " vim
    Plug 'tpope/vim-surround'                           " Change surrounding
                                                        " marks
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } 
                                                        " Markdown preview
    Plug 'godlygeek/tabular'                            " tabular plugin is used
                                                        " to format tables
"{{ Syntax Highlighting and Colors }} Plug 'ap/vim-css-color'                             " Color previews for CSS
    Plug 'sheerun/vim-polyglot'                         " Syntax highlighting
                                                        " for various languages
                                                       
"{{ Junegunn Choi Plugins }}
    Plug 'junegunn/goyo.vim'                            " Distraction-free 
                                                        " viewing
    Plug 'junegunn/limelight.vim'                       " Hyperfocus on a range
    Plug 'junegunn/fzf'                                 " A Finder Plugin
    Plug 'junegunn/fzf.vim'                             " Vim implementation of
                                                        " fzf
    Plug 'junegunn/vim-emoji'                           " Vim needs emojis!
"{{ Themes }}
    Plug 'joshdick/onedark.vim'                         " One dark theme

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
set path+=**            					" Searches current directory 
                                            " recursively.
set wildmenu		            			" Display all matches when tab 
                                            " complete.
set wildmode=longest:full,full              " Set autocompletion mode
set wildoptions-=pum                        " Remove popup menu for 
                                            " autocompletion
set incsearch          		                " Incremental search
set hidden                     		        " Needed to keep multiple buffers
                                            " open
set nobackup                   		        " No auto backups
set noswapfile              		        " No swap
if (match($COLORTERM, "truecolor") != -1)   " If terminal supports truecolor
    set termguicolors                       " Set 24bit color support
else                                        " Else
    set t_Co=256               		        " Set 256 color mode
endif
set number relativenumber 	                " Display line numbers
set clipboard=unnamedplus         	        " Copy/paste between vim and other
                                            " programs.
set cursorline                              " Highligt cursorline
set textwidth=80                            " Set textwidth to 80 columns
set wrap linebreak                          " Prevents word wrapping in between
                                            " words
set formatoptions=tcqj                      " Set options of automatic formating
set spelllang=en_us,de_ch                   " Set spell check languages
syntax on
filetype plugin on
let g:rehash256 = 1

" Splits and Tabbed Files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright   " The new window is is displayed on the right or 
                            " below
set fillchars+=vert:\|      " Fill the vertical separator with |
set fillchars+=stlnc:-      " Fill the horizontal separator with -

" Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap ESC to ii
inoremap ii <Esc>
" Remap Leader key to SPACE
let mapleader = " "
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

" Mouse settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=nvicr " Sets the current mouse mode as normal, visual , insert and 

" Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=4                " One tab == four spaces.
set tabstop=4                   " One tab == four spaces.

" Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nord theme settings (must be set before colorscheme)
colorscheme onedark 

set colorcolumn=80                                
highlight ColorColumns ctermbg=1 guibg=#3b4252

" Gui options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" File types
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
au! BufRead,BufNewFile,BufFilePre *.markdown set filetype=mkd
au! BufRead,BufNewFile,BufFilePre *.md set filetype=mkd

" Other functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Rainbow
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1    " Enable rainbow brackets
" Set colors for rainbow brackets
let g:rainbow_conf = {
\	'guifgs': ['#61afef', '#d19a66', '#56b6c2', '#c678dd'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\}


" Goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>gg :Goyo<cr>

" LightLine
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set nord as the lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

set laststatus=2    " Always show the statusline
set noshowmode      " Uncomment to prevent non-normal modes showing in powerline

" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap Ctrl-n to toggle the nerdtree
nnoremap <C-n> :NERDTreeToggle<cr>
" Visual nerd tree settings
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

" Vifm
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>vv :Vifm<cr>
nnoremap <Leader>vs :VsplitVifm<cr>
nnoremap <Leader>sp :SplitVifm<cr>
nnoremap <Leader>dv :DiffVifm<cr>
nnoremap <Leader>tv :TabVifm<cr>

" VimWiki
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType vimwiki :RainbowToggleOff  " Disable rainbow mode in vimwiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'auto_tags': 1, 'auto_toc': 1}]
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_use_mouse = 1
let g:vimwiki_auto_chdir = 1

" Zettelkasten
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nv_search_paths = ['~/Documents/vimwiki/']
let g:zettel_options = [{"front_matter" : [["tags", ""], ["type", "note",]],
                        \ "template" :  "~/Templates/zettel.tpl"}]
let g:zettel_format = '%Y%m%d%H%M%S'
let g:zettel_default_mappings = 1
   augroup filetype_vimwiki
     autocmd!
     autocmd FileType vimwiki inoremap <silent> [[ [[<esc><Plug>ZettelSearchMap
     autocmd FileType vimwiki nnoremap T <Plug>ZettelYankNameMap
     autocmd FileType vimwiki xnoremap z <Plug>ZettelNewSelectedMap
     autocmd FileType vimwiki nnoremap gZ <Plug>ZettelReplaceFileWithLink
   augroup END

" Python-syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1

" Markdown-Preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If set to 1 markdown preview is only refreshed, when the buffer is saved or
" insert mode is exited
let g:mkdp_refresh_slow = 0
" Browser to open the preview
let g:mkdp_browser = 'firefox'
let g:mkdp_page_tittle = '${name}'

autocmd Filetype mkd,vimwiki nmap <Leader>mp <Plug>MarkdownPreviewToggle
