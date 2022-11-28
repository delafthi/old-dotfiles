(module plugins.trouble
  {autoload {: trouble
             : util}})

(defn setup []
  "Setup nvim for trouble.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Workspace Trouble"
      ["n"] ["<Leader>" "w" "x"]
      "<Cmd>TroubleToggle workspace_diagnostics<Cr>" opts)
    (util.set-keymap "Document Trouble"
      ["n"] ["<LocalLeader>" "x" "d"]
      "<Cmd>TroubleToggle document_diagnostics<Cr>" opts)
    (util.set-keymap "Quickfixlist"
      ["n"] ["<LocalLeader>" "x" "q" ]
      "<Cmd>TroubleToggle quickfixlist<Cr>" opts)
    (util.set-keymap "Trouble"
      ["n"] ["<LocalLeader>" "x" "x"] "<Cmd>TroubleToggle<Cr>" opts)))

(defn config []
  "Configure trouble.nvim"
  ;; Call the setup function
  (trouble.setup {}))
