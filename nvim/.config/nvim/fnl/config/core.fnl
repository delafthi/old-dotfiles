(module config.core)

(defn setup []
  "Setup nvim"
  ;; General
  ;; ~~~~~~~

  (set vim.g.mapleader " ") ;; Set leader to space
  (set vim.g.maplocalleader ",") ;; Set local leader to comma
  (set vim.opt.termguicolors true) ;; Enable termguicolor support

  ;; Backup
  ;; ~~~~~~

  (set vim.opt.backup false) ;; Disable backups
  (set vim.opt.confirm true) ;; Prompt to save before destructive actions
  (set vim.opt.swapfile false) ;; Disable swapfiles
  (set vim.opt.undofile true) ;; Save undo history
  (when (= (vim.fn.isdirectory vim.o.undodir) 0)
    (vim.fn.mkdir vim.o.undodir "p")) ;; Create undo directory
  (set vim.opt.writebackup false) ;; Disable backups when a file is written

  ;; Buffers
  ;; ~~~~~~~

  (set vim.opt.autoread true) ;; Enable automatic reload of unchanged files
  (set vim.opt.hidden true) ;; Enable modified buffers in the background
  (set vim.opt.modeline true) ;; Don't parse modelines (google 'vim modeline vulnerability')
  (set vim.opt.scrolloff 8) ;; Keep 8 lines above or below the cursorline

  ;; Diff
  ;; ~~~~

  ;; Use blank lines in vertical diff mode to keep sides aligned; Ignore
  ;; whitespace changes
  (vim.opt.diffopt:prepend ["context:4"
                            "iwhite"
                            "vertical"
                            "hiddenoff"
                            "foldcolumn:0"
                            "indent-heuristic"
                            "algorithm:histogram"])

  ;; Display
  ;; ~~~~~~~

  (set vim.opt.colorcolumn "80") ;; Set colorcolumn to 80
  (set vim.opt.cursorline true) ;; Enable the cursorline
  (set vim.opt.guicursor ["n-v-sm:block"
                          "i-c-ci-ve:ver25"
                          "cr-o-r:hor20"])
  (vim.opt.display:prepend "lastline") ;; On wrap display the last line even if it does not fit
  (set vim.opt.errorbells false) ;; Disable annoying errors
  (set vim.opt.lazyredraw true) ;; Disables redraw when executing macros and other commands
  (set vim.opt.linebreak true) ;; Prevent wrapping between words
  (set vim.opt.list true) ;; Enable listchars
  ;; Set listchar characters
  (set vim.opt.listchars {:eol "↲"
                          :tab "»·"
                          :space " "
                          :trail ""
                          :extends "…"
                          :precedes "…"
                          :conceal "┊"
                          :nbsp "☠"})
  (set vim.opt.number true) ;; Print line numbers
  (set vim.opt.relativenumber true) ;; Set line numbers to be relative to the cursor position
  (set vim.opt.showbreak ">>> ") ;; Show wrapped lines with a prepended string
  (set vim.opt.showcmd true) ;; Show command in the command line
  (set vim.opt.showmode false) ;; Don't show mode in the command line
  (set vim.opt.signcolumn "yes") ;; Enable sign columns left of the line numbers
  (set vim.opt.synmaxcol 1024) ;; Don't syntax highlight long lines
  (set vim.opt.textwidth 80) ;; Max text length
  (set vim.g.vimsyn_embed "lPr") ;; Allow embedded syntax highlighting for lua, python, ruby
  (set vim.opt.wrap true) ;; Enable line wrapping
  (set vim.opt.visualbell false) ;; Disable annoying beeps
  (set vim.opt.shortmess "c") ;; Avoid showing extra messages when using completion

  ;; Editing
  ;; ~~~~~~~

  (set vim.opt.virtualedit "block") ;; Allow cursor to move past end of line
  (set vim.opt.autoindent true) ;; Allow filetype plugins and syntax highlighting
  (set vim.opt.expandtab true) ;; Use spaces instead of tabs
  (set vim.opt.joinspaces false) ;; No double spaces with join after a dot
  (set vim.opt.shiftround true) ;; Round indent
  (set vim.opt.shiftwidth 2) ;; Size of an indent
  (set vim.opt.smartindent true) ;; Insert indents automatically
  (set vim.opt.smarttab true) ;; Automatically tab to the next softtabstop
  (set vim.opt.softtabstop 2) ;; Number of spaces that a <Tab> counts for while performing edition operations, like inserting a <Tab> or using <BS>
  (set vim.opt.tabstop 2) ;; Number of spaces tabs count for
  (set vim.opt.formatoptions "tcroqlj") ;; Defines how text is automatically formatted

  ;; Filetypes
  ;; ~~~~~~~~~

  (set vim.g.tex_flavor "latex") ;; Set latex as the default tex flavor

  ;; Folds
  ;; ~~~~~

  (set vim.opt.foldlevelstart 10) ;; Set level of opened folds when starting vim
  (set vim.opt.foldmethod "expr") ;; The kind of folding for the current window
  (set vim.opt.foldexpr "v:lua.vim.treesitter.foldexpr()") ;; The fold expression
  (vim.opt.foldopen:append "search") ;; Open folds when something is found inside the fold
  (set vim.opt.foldtext "luaeval(\"require('util').foldtext()\")") ;; Function called to display fold line

  ;; Mouse
  ;; ~~~~~

  (set vim.opt.mouse "nvicr") ;; Enables different support modes for the mouse

  ;; Netrw
  ;; ~~~~~

  (set vim.g.netrw_banner 0) ;; Disable the banner on top of the window

  ;; Search
  ;; ~~~~~~

  (set vim.opt.hlsearch true) ;; Enable search highlighting
  (set vim.opt.incsearch true) ;; While typing a search command show where the pattern matches
  (set vim.opt.ignorecase true) ;; Ignore case when searching
  (set vim.opt.smartcase true) ;; Don't ignore case with capitals
  (set vim.opt.wrapscan true) ;; Searches wraps at the end of the file
  ;; Use faster grep alternatives if possible
  (when (> (vim.fn.executable "rg") 0)
    (set vim.opt.grepprg (.. "rg "
                            "--hidden "
                            "--glob \"!.git\" "
                            "--no-heading "
                            "--smart-case "
                            "--vimgrep "
                            "--follow"
                            "$*"))
    (vim.opt.grepformat:prepend "%f:%l:%c:%m"))

  ;; Spell checking
  ;; ~~~~~~~~~~~~~~

  ;; Set spell check languages
  (set vim.opt.spelllang ["en_us" "de_ch"])

  ;; Splits
  ;; ~~~~~~

  ;; Fill characters for the statusline and vertical separators
  (set vim.opt.fillchars {:stl " "
                          :stlnc " "
                          :vert "│"
                          :fold " "
                          :foldopen "▾"
                          :foldclose "▸"
                          :foldsep "│"
                          :diff ""
                          :msgsep "‾"
                          :eob "~"})
  (set vim.opt.splitbelow true) ;; Put new windows below the current
  (set vim.opt.splitright true) ;; Put new windows right of the current

  ;; Statusline
  ;; ~~~~~~~~~~

  (set vim.opt.laststatus 2) ;; Show only one global statusline
  ;; Timings
  ;; ~~~~~~~

  (set vim.opt.timeout true) ;; Determines with 'timeoutlen' how long nvim waits for further commands after a command is received
  (set vim.opt.timeoutlen 500) ;; Wait 500 milliseconds for further input
  (set vim.opt.ttimeoutlen 10) ;; Wait 10 milliseconds in mappings with CTRL

  ;; Title
  ;; ~~~~~

  (set vim.opt.title true) ;; Set window title by default
  (set vim.opt.titlelen 70) ;; Set maximum title length
  (set vim.opt.titleold "%{fnamemodify(getcwd(), ':t')}") ;; Set title while exiting vim
  (set vim.opt.titlestring "%t") ;; Set title string

  ;; Utils
  ;; ~~~~~

  ;; Change backspace to behave more intuitively
  (set vim.opt.backspace ["indent" "eol" "start"])
  (set vim.opt.clipboard "unnamedplus") ;; Enable copy paste into and out of nvim
  ;; Set completionopt to have a better completion experience
  (set vim.opt.completeopt ["menuone" "noselect"])
  (set vim.opt.inccommand "split") ;; Show the effect of a command incrementally as you type
  (vim.opt.path:prepend "**") ;; Searches current directory recursively

  ;; Wildmenu
  ;; ~~~~~~~~

  (set vim.opt.wildmenu false)) ;; Enable commandline autocompletion menu
