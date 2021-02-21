" Plugins managed by Vim-Plug {{{1

set nocompatible " required
filetype off " required

" Install vimplug
if ! filereadable(expand('~/.vim/autoload/plug.vim'))
  echo 'Downloading junegunn/vim-plug to manage plugins...'
  silent !mkdir -p ~/.vim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.vim/autoload/plug.vim
  augroup plug
    au!
    au VimEnter * PlugInstall
  augroup END
endif

" Plugins
call plug#begin('~/.vim/plugged')
  " Colors
  Plug 'delafthi/onedarkvim',
  " Comment
  Plug 'tpope/vim-commentary'
  " File manager
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  " Movement
  Plug 'unblevable/quick-scope'
  " Note taking
  Plug 'vimwiki/vimwiki'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  " Start screen
  Plug 'mhinz/vim-startify'
  " Syntax highlighting
  Plug 'lilydjwg/colorizer'
  Plug 'sheerun/vim-polyglot'
  " Text editing
  Plug 'tpope/vim-surround'
  Plug 'godlygeek/tabular'
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

" Backup {{{1
set nobackup " Disable backups.
set confirm " Prompt to save before destructive actions.
set noswapfile " Disable swapfiles.
set undofile " Save undo history.
" Create undo directory.
if isdirectory(&undodir) == 0
  call mkdir(&undodir, 'p')
endif
set nowritebackup " Disable backups, when a file is written.

" Buffers {{{1
set autoread " Enable automatic reload of unchanged files.
autocmd CursorHold * checktime " Auto reload file, when changes where made somewhere else (for autoreload)
set hidden " Enable modified buffers in the background.
set modeline " Don't parse modelines (google 'vim modeline vulnerability').
" Automatically deletes all trailing whitespace and newlines at end of file on
" save.
function! TrimTrailingLines()
  let lastLine = line('$')
  let lastNonblankLine = prevnonblank(lastLine)
  if lastLine > 0 && lastNonblankLine != lastLine
    silent! execute lastNonblankLine + 1 . ',$delete _'
  endif
endfunction
augroup remove
  au!
  au BufWritePre * %s/\s\+$//e
  au BufWritepre * call TrimTrailingLines()
augroup END

" Colorscheme {{{1
let g:rehash256=1
set termguicolors " Enable termguicolor support.
colorscheme onedark

" Diff {{{1
let  &g:diffopt = 'vertical,iwhite,hiddenoff,foldcolumn:0,context:4,algorithm:histogram,indent-heuristic'

" Display {{{1
set colorcolumn=80 " Set colorcolumn to 80
set cursorline " Enable the cursorline.
set display+=lastline " On wrap display the last line even if it does not fit
set noerrorbells " Disable annoying errors
set lazyredraw " Disables redraw when executing macros and other commands.
set linebreak " Prevent wrapping between words.
set list " Enable listchars.
let &g:listchars = 'eol:↲,tab:»·,space: ,trail:,extends:…,precedes:…,conceal:┊,nbsp:☠' " Set listchar characters.
set number " Print line numbers.
set relativenumber " Set line numbers to be relative to the cursor position.
set scrolloff=8 " Keep 8 lines above or below the cursorline
let &g:showbreak = '>>> ' " Show wrapped lines with a prepended string.
set showcmd "Show command in the command line.
set noshowmode " Don't show mode in the command line.
set signcolumn=yes " Enable sign columns left of the line numbers.
set synmaxcol=1024 " Don't syntax highlight long lines.
set textwidth=80 " Max text length.
let g:vimsyn_embed = 'lPr' " Allow embedded syntax highlighting for lua, python, ruby.
set wrap " Enable line wrapping.
set virtualedit=block " Allow cursor to move past end of line.
set novisualbell " Disable annoying beeps

" Folds {{{1
set foldlevelstart=10 " Set level of opened folds, when starting vim. set foldmethod=marker " The kind of folding for the current window.
set foldmethod=marker " The kind of folding for the current window.
set foldopen+=search " Open folds, when something is found inside the fold.

" Indentation {{{1
set autoindent " Allow filetype plugins and syntax highlighting
set expandtab " Use spaces instead of tabs
set nojoinspaces " No double spaces with join after a dot
set shiftround " Round indent
set shiftwidth=2 " Size of an indent
set smartindent " Insert indents automatically
set smarttab " Automatically tab to the next softtabstop
set softtabstop=2 " Number of spaces that a <Tab> counts for while performing edition operations, like inserting a <Tab> or using <BS>
set tabstop=2 " Number of spaces tabs count for

" Key mappings {{{1
let g:mapleader = ' ' " Remap Leader key to space
" Remap ESC to ii
inoremap ii <Esc>
" Remap hjkl keys to navigate also the wrapped lines
nnoremap <silent> k gk
nnoremap <silent> j gj
vnoremap <silent> k gk
vnoremap <silent> j gj
" Open terminal inside Vim
nnoremap <silent> <Leader>tt :new term://fish<Cr>
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
tnoremap <silent> <C-Left> <C-\><C-n>:vertical resize +2<Cr>
tnoremap <silent> <C-Up> <C-\><C-n>:resize +2<Cr>
tnoremap <silent> <C-Down> <C-\><C-n>:resize -2<Cr>
tnoremap <silent> <C-Right> <C-\><C-n>:vertical resize -2<Cr>
inoremap <silent> <C-Left>:vertical resize +2<Cr>
inoremap <silent> <C-Up>:resize +2<Cr>
inoremap <silent> <C-Down>:resize -2<Cr>
inoremap <silent> <C-Right>:vertical resize -2<Cr>
nnoremap <silent> <C-Left>:vertical resize +2<Cr>
nnoremap <silent> <C-Up>:resize +2<Cr>
nnoremap <silent> <C-Down>:resize -2<Cr>
nnoremap <silent> <C-Right>:vertical resize -2<Cr>
" Change 2 split windows from vert to horiz or horiz to vert
nnoremap <silent> <Leader>lv <C-w>t<C-w>H
nnoremap <silent> <Leader>lh <C-w>t<C-w>K
" Kill specified buffer
nnoremap <silent> <Leader>bk :ls<Cr>:bd<Space>
" Enable/Disable spell checker
nnoremap <silent> <Leader>o :setlocal spell!<Cr>
" " Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Save file as sudo on files that require root permission
ca w!! w !sudo tee >/dev/null "%"

" Mouse {{{1
set mouse=nvicr " Enables different support modes for the mouse

" Netrw {{{1
let g:netrw_banner=0 " Disable banner on top of the window.

" Search {{{1
set hlsearch " Enable search highlighting.
set incsearch " While typing a search command, show where the pattern, as it was typed so far, matches.
set ignorecase " Ignore case when searching.
set smartcase " Don't ignore case with capitals.
set wrapscan " Searches wraps at the end of the file.
" Use faster grep alternatives if possible
if executable('rg')
  let &g:grepprg='rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*'
  set grepformat+=%f:%l:%c:%m
end

" Spell checking {{{1
set spelllang=en_us,de_ch " Set spell check languages.

" Splits {{{1
let &g:fillchars = 'stl: ,stlnc:_,vert:│,fold: ,diff:,msgsep:‾,eob:~' " Fill characters for the statusline and vertical separators
set splitbelow " Put new windows below the current.
set splitright " Put new windows right of the current.

" Statusline {{{1
set laststatus=2 " Always show the statusline
call statusline#setup()

" Timings {{{1
set timeout " Determines with 'timeoutlen' how long nvim waits for further commands after a command is received.
set timeoutlen=500 " Wait 500 milliseconds for further input.
set ttimeoutlen=10 " Wait 10 milliseconds in mappings with CTRL.

" Title {{{1
set title " Set window title by default.
set titlelen=70 " Set maximum title length.
let &g:titleold = '%{fnamemodify(getcwd(), ":t")}' " Set title, while exiting the vim.
let &g:titlestring = '%t' " Set title string.

" Utils {{{1
let  &g:backspace = 'indent,eol,start' " Change backspace to behave more intuitively.
set clipboard=unnamedplus " Enable copy paste into and out of nvim.
let &g:completeopt = 'menu,noinsert,noselect,longest' " Set completeopt to have a better completion experience.
set path+=** " Searches current directory recursively

" Wildmenu {{{1
set wildmenu " Enable commandline autocompletion menu.
set wildmode=full " Select completion mode.
set wildignorecase " Ignores case when completing.

" Plugin Settings {{{1
"
" Vimwiki {{{2
let g:vimwiki_list = [{
            \ 'path': '~/Vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md',
            \ }]
let g:vimwiki_use_mouse = 1
let g:vimwiki_auto_chdir = 1

" Markdown-Preview {{{2
let g:mkdp_refresh_slow = 0 " If set to 1 markdown preview is only refreshed, when the buffer is saved or insert mode is exited
let g:mkdp_browser = 'brave' " Browser to open the preview
let g:mkdp_page_tittle = '${name}' " Define title of the browser page
" Set keybinging to launch the markdown preview
autocmd Filetype mkd,vimwiki nmap <Silent> <Leader>mp <Plug>MarkdownPreviewToggle

" Nerdtree {{{2
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowHidden = 1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
nnoremap <C-n> :NERDTreeToggle<Cr>

" Quick-scope
let g:qs_buftype_blacklist = ['terminal', 'nofile', 'nerdtree', 'help']

" }}}2
"
" }}}1
