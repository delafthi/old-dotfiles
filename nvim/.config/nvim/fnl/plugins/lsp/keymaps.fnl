(module plugins.lsp.keymaps
  {autoload {lsp-formatting plugins.lsp.formatting
             telescope-builtin telescope.builtin
             : util}})

(defn setup [client bufnr]
  "Setup LSP keymaps"
  ;; Register buffer-local keybindings
  (let [opts {:silent true
              :buffer bufnr}]
    ;; Workspace lsp features
    (util.set-keymap "Add worksapace folders"
      ["n"] ["<Leader>" "p" "a"] (fn [] (vim.lsp.buf.add_workspace_folders)) opts)
    (util.set-keymap "Remove workspace folders"
      ["n"] ["<Leader>" "p" "d"] (fn [] (vim.lsp.buf.remove_workspace_folders)) opts)
    (util.set-keymap "List workspace folders"
      ["n"] ["<Leader>" "p" "l"]
      (fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
      opts)

    ;; Workspace lsp features dependent on server capabilities
    (when client.server_capabilities.codeActionProvider
          (util.set-keymap "Code actions"
            ["n"] ["<LocalLeader>" "a"] (fn [] (vim.lsp.buf.code_action)) opts))
    (when client.server_capabilities.declarationProvider
          (util.set-keymap "Go to declaration"
            ["n"] ["g" "d"] (fn [] (vim.lsp.buf.declaration)) opts))
    (when client.server_capabilities.definitionProvider
          (util.set-keymap "Go to definition"
            ["n"] ["g" "D"] (fn [] (telescope-builtin.lsp_definitions)) opts))
    (when client.server_capabilities.implementationsProvider
          (util.set-keymap "Find implementation"
            ["n"] ["g" "I"]
            (fn [] (telescope-builtin.lsp_implementations)) opts))
    (when client.server_capabilities.referencesProvider
          (util.set-keymap "Find reference"
            ["n"] ["g" "r"] (fn [] (telescope-builtin.lsp_references)) opts)
          (util.set-keymap "Find reference"
            ["n"] ["g" "r"] "<Cmd>TroubleToggle lsp_references<Cr>" opts))
    (when client.server_capabilities.typeDefinitionProvider
          (util.set-keymap "Find type definition"
            ["n"] ["g" "t"]
            (fn [] (telescope-builtin.lsp_type_definitions)) opts))
    (when client.server_capabilities.workspaceSymbolProvider
          (util.set-keymap "Find workspace symbols"
            ["n"] ["<Leader>" "f" "s"]
            (fn [] (telescope-builtin.lsp_workspace_symbols)) opts))
    (when client.server_capabilities.renameProvider
          (util.set-keymap "Rename variables"
            ["n"] ["<Leader>" "r"] (fn [] (vim.lsp.buf.rename)) opts))

    ;; Buffer diagnostics
    (util.set-keymap "Next diagnostic"
      ["n" "v"] ["]" "d"] (fn [] (vim.diagnostic.goto_next)) opts)
    (util.set-keymap "Previous vim.diagnostic"
      ["n" "v"] ["[" "d"] (fn [] (vim.diagnostic.goto_prev)) opts)
    (util.set-keymap "Previous vim.diagnostic"
      ["n" "v"] ["[" "d"] (fn [] (vim.diagnostic.goto_prev)) opts)
    (util.set-keymap "Show diagnostics info"
      ["n" "i" "v"] ["<C-f>"]
      (fn [] (vim.diagnostic.open_float {:severity_sort true})) opts)
    (util.set-keymap "Generate local quickfixlist"
      ["n"] ["<LocalLeader>" "g" "q"] (fn [] (vim.diagnostic.setloclist)) opts)

    ;; Buffer lsp features dependent on server capabilities
    (when client.server_capabilities.signatureHelpProvider
          (util.set-keymap "Get signature help"
            ["n" "i"] ["<C-s>"] (fn [] (vim.lsp.buf.signature_help)) opts))
    (when client.server_capabilities.documentFormattingProvider
          (util.set-keymap "Toggle autoformatting"
            ["n"] ["<LocalLeader>" "b" "a"] (fn [] (lsp-formatting.toggle))
            opts)
          (util.set-keymap "Beautify buffer"
            ["n"] ["<LocalLeader>" "b" "b"] (fn [] (vim.lsp.buf.format)) opts))
    (when client.server_capabilities.documentRangeFormattingProvider
          (util.set-keymap "Beautify selection"
            ["v"] ["<LocalLeader>" "b" "b"] (fn [] (vim.lsp.buf.format)) opts))
    (when client.server_capabilities.documentSymbolProvider
          (util.set-keymap "Find document symbol"
            ["n"] ["<LocalLeader>" "f" "s"]
            (fn [] (telescope-builtin.lsp_document_symbol
                        ["Class"
                          "Function"
                          "Method"
                          "Constructor"
                          "Interface"
                          "Module"])) opts))
    (when client.server_capabilities.hoverProvider
          (util.set-keymap "Show hover"
            ["n"] ["<LocalLeader>" "l"] (fn [] (vim.lsp.buf.hover)) opts))))
