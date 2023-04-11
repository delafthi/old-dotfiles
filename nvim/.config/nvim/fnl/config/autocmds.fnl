(module config.autocmds
  {autoload {nvim aniseed.nvim
             : util}})


(defn setup []
  "Setup autocommands"

  ;; Buffers
  ;; ~~~~~~~~

  ;; Auto reload file when changes where made somewhere else (for autoreload)
  (nvim.create_autocmd "CursorHold"
    {:command "checktime"
     :group (nvim.create_augroup "AutoreloadFiles" {})})

  ;; Remove trailling lines and whitespace
  (let [group (nvim.create_augroup "RemoveTrailingWhitespacesAndLines" {})]
    (nvim.create_autocmd "BufWritePre"
      {:callback (fn []
                  (util.exec-and-restore-view "keepj keepp silent! %s/\\s*$//e"))
       :group group})
    (nvim.create_autocmd "BufWritePre"
      {:callback (fn []
                   (util.exec-and-restore-view
                     "keepj keepp silent! 0;/^\\%(\\_s*\\S\\)\\@!/,$d"))
       :group group}))

  ;; Filetypes
  ;; ~~~~~~~~~

  ;; Assign filetypes to unknown suffixes

  (let [group (nvim.create_augroup "AddAdditionalFiletypes"  {})]
    (nvim.create_autocmd ["BufNewFile" "BufRead"]
      {:pattern "*.cl"
       :command "set filetype=cpp"
       :group group})
    (nvim.create_autocmd ["BufNewFile" "BufRead"]
      {:pattern "*.bb"
       :command "set filetype=sh"
       :group group})
    (nvim.create_autocmd ["BufNewFile" "BufRead"]
      {:pattern "*.bbappend"
       :command "set filetype=sh"
       :group group}))

  ;; Terminal
  ;; ~~~~~~~~

  ;; Automatically go to insert mode when changing to the terminal window
  (nvim.create_autocmd ["BufWinEnter" "WinEnter"]
    {:pattern "term://*"
     :command "startinsert"
     :group (nvim.create_augroup "TerminalStartInsert" {})})
  ;; Visuals
  ;; ~~~~~~~

  ;; Enable highlight on yank
  (nvim.create_autocmd "TextYankPost"
    {:callback (fn [] (vim.highlight.on_yank))
     :group (nvim.create_augroup "HighlightOnYank" {})}))
