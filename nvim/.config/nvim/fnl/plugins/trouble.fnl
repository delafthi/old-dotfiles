(module plugins.trouble
  {autoload {: trouble
             : util}})

(defn init []
  "Initialize nvim for trouble.nvim"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Workspace Diagnostics"
      ["n"] ["<Leader>" "q" "d"]
      "<Cmd>TroubleToggle workspace_diagnostics<Cr>" opts)
    (util.set-keymap "Document Diagnostics"
      ["n"] ["<LocalLeader>" "q" "d"]
      "<Cmd>TroubleToggle document_diagnostics<Cr>" opts)
    (util.set-keymap "Quickfix list"
      ["n"] ["<Leader>" "q" "q" ]
      "<Cmd>TroubleToggle quickfixlist<Cr>" opts)
    (util.set-keymap "Location list"
      ["n"] ["<LocalLeader>" "q" "q"]
      "<Cmd>TroubleToggle loclist" opts)
    (util.set-keymap "Symbol definitions"
      ["n"] ["<LocalLeader>" "q" "D" ]
      "<Cmd>TroubleToggle lsp_definitions" opts)
    (util.set-keymap "Symbol references"
      ["n"] ["<LocalLeader>" "q" "r"]
      "<Cmd>TroubleToggle lsp_references" opts)))

(defn config []
  "Configure trouble.nvim"
  ;; Call the setup function
  (trouble.setup {}))
