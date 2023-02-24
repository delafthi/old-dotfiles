(module config.mappings
  {autoload {: util
             : which-key}})

(defn register []
  "Register keybindings"
  (let [opts {:silent true}]
    ;; Define basic keybinding structure
    (which-key.register
      {:<Leader>
        {:name "+leader"
         :c {:name "+create"}
         :d {:name "+debug"}
         :f {:name "+find"}
         :g {:name "+git"}
         :h {:name "+help"}
         :n {:name "+notes"}
         :r {:name "+rename"}
         :t {:name "+terminal"}
         :w {:name "+workspace"}}
       :<LocalLeader>
        {:name "+localleader"
         :b {:name "+beautify"}
         :c {:name "+connect"}
         :d {:name "+documentation"}
         :e {:name "+evaluate"}
         :f {:name "+find"}
         :g {:name "+goto"}
         :h {:name "+hover"}
         :l {:name "+log"}
         :r {:name "+repl"}
         :t {:name "+tests"}
         :x {:name "+error"}
         :z {:name "+zen"}}
       :<C-t>
        {:name "+tabs"}})

    ;; Add missing descriptions
    (which-key.register {:<Tab> ["Indent cursor"]})

    ;; Register keybindings
    ;; Editing
    (util.set-keymap "Merge with previous line"
      ["n"] ["K"] "mzkJ`z" opts)
    (util.set-keymap "Merge with next line"
      ["n"] ["J"] "mzJ`z" opts)
    (util.set-keymap "Yank util end of line"
      ["n"] ["Y"] "y$" opts)
    (util.set-keymap "Yank util end of line"
      ["n"] ["Y"] "y$" opts)
    (util.set-keymap "New line without inserting comment leaders"
      ["i"] ["<Cr>" "d"] "<Cr><C-o>diw" opts)
    (util.set-keymap "New line below current without inserting comment leaders"
      ["n"] ["o" "d"] "o<C-o>diw" opts)
    (util.set-keymap "New line above current without inserting comment leaders"
      ["n"] ["O" "d"] "O<C-o>diw" opts)
    (util.set-keymap "Add breakpoints when inserting a '.'"
      ["i"] ["."] ".<C-g>u" opts)
    (util.set-keymap "Add breakpoints when inserting a '::'"
      ["i"] [":" ":"] "::<C-g>u" opts)
    (util.set-keymap "Move line up"
      ["n"] ["<M-S-j>"] "<Cmd>m .+1<Cr>==" opts)
    (util.set-keymap "Move line down"
      ["n"] ["<M-S-k>"] "<Cmd>m .-2<Cr>==" opts)
    (util.set-keymap "Move lines up"
      ["i"] ["<M-S-j>"] "<C-o><Cmd>m .+1<Cr>" opts)
    (util.set-keymap "Move line down"
      ["i"] ["<M-S-k>"] "<C-o><Cmd>m .-2<Cr>" opts)
    (util.set-keymap "Move lines up"
      ["v"] ["<M-S-j>"] "<Cmd>m '>+1<Cr>gv=gv" opts)
    (util.set-keymap "Move lines down"
      ["v"] ["<M-S-k>"] "<Cmd>m '<-2<Cr>gv=gv" opts)
    (util.set-keymap "Unindent lines"
      ["v"] ["<"] "<gv" opts)
    (util.set-keymap "Indent lines"
      ["v"] [">"] ">gv" opts)
    ;; Misc
    (util.set-keymap "Clear search-hl with <Esc>"
      ["n"] ["<Esc>"] "<Cmd>noh<Cr>" opts)
    ;; Movement
    (util.set-keymap "Move up visual line"
      ["n" "v"] ["k"] "gk" opts)
    (util.set-keymap "Move down visual line"
      ["n" "v"] ["j"] "gj" opts)
    (util.set-keymap "Next search result"
      ["n" "v"] ["n"] "nzzzv" opts)
    (util.set-keymap "Previous search result"
      ["n" "v"] ["N"] "Nzzzv" opts)
    ;; Tabs (some keybindings are also set in the bufferline setup)
    (util.set-keymap "Close tab"
      ["n" "i" "t"] ["<C-t>" "d"] "<C-\\><C-n><Cmd>tabclose<Cr>" opts)
    (util.set-keymap "Create new tab"
      ["n" "i" "t"] ["<C-t>" "t"] "<C-\\><C-n><Cmd>tabnew<Cr>" opts)
    ;; Terminal
    (util.set-keymap "Exit insert mode in the terminal"
      ["t"] ["<C-x>"] "<C-\\><C-n>" opts)
    ;; Windows (keybindings to move between windows have been moved to the
    ;; navigator setup)
    (util.set-keymap "Decrease horizontal window size"
      ["n" "i"] ["<M-h>"] "<Cmd>vertical resize +2<Cr>" opts)
    (util.set-keymap "Increase horizontal window size"
      ["n" "i"] ["<M-j>"] "<Cmd>resize +2<Cr>" opts)
    (util.set-keymap "Decrease vertical window size"
      ["n" "i"] ["<M-k>"] "<Cmd>resize -2<Cr>" opts)
    (util.set-keymap "Increase vertical window size"
      ["n" "i"] ["<M-l>"] "<Cmd>vertical resize -2<Cr>" opts)
    (util.set-keymap "Decrease horizontal window size"
      ["t"] ["<M-h>"] "<C-\\><C-n><Cmd>vertical resize +2<Cr>i" opts)
    (util.set-keymap "Increase horizontal window size"
      ["t"] ["<M-j>"] "<C-\\><C-n><Cmd>resize +2<Cr>i" opts)
    (util.set-keymap "Decrease vertical window size"
      ["t"] ["<M-k>"] "<C-\\><C-n><Cmd>resize -2<Cr>i" opts)
    (util.set-keymap "Increase vertical window size"
      ["t"] ["<M-l>"] "<C-\\><C-n><Cmd>vertical resize -2<Cr>i" opts)))
