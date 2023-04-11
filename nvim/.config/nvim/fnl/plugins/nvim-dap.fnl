(module plugins.nvim-dap
  {autoload {: dap
             dap-cmp dap.ext.autocompl
             nvim aniseed.nvim
             : util}})

(def- signs
  {:DapBreakpoint
    {:text " "
     :texthl "DiagnosticError"
     :linehl ""
     :numhl ""}
   :DapBreakpointRejected
    {:text " "
     :texthl "Ignore"
     :linehl ""
     :numhl ""}
   :DapLogPoint
    {:text "ﯽ "
     :texthl "DiagnosticInfo"
     :linehl ""
     :numhl ""}
   :DapStopped
    {:text " "
     :texthl "TSCharacter"
     :linehl ""
     :numhl ""}})

(def- adapters
  {:lldb
    {:name "lldb"
     :type "execuable"
     :command "/usr/bin/lldb-vscode"}})

(def- configurations
  {:c
    {:name "Launch"
     :type "lldb"
     :request "launch"
     :program (fn [] (vim.fn.input
                           "Path to executable: "
                           (.. (vim.fn.getcwd) "/")
                           "file"))
     :cwd "${workspaceFolder}"
     :stopOnEntry false
     :runInTerminal false}
   :cpp
    {:name "Launch"
     :type "lldb"
     :request "launch"
     :program (fn [] (vim.fn.input
                           "Path to executable: "
                           (.. (vim.fn.getcwd) "/")
                           "file"))
     :cwd "${workspaceFolder}"
     :stopOnEntry false
     :runInTerminal false}})

(defn init []
  "Initialize nvim for nvim-dap"
  ;; Register filetype-specific keybindings
  (let [opts {:silent true
              :buffer true}
        group (nvim.create_augroup "NvimDapMappings" {})]
    (nvim.create_autocmd "BufEnter"
      {:pattern ["*.c" "*.cpp" "*.rs"]
       :callback
        (fn []
          (util.set-keymap "Toggle breakpoint"
            ["n"] ["<Leader>" "d" "b"] (fn [] (dap.toggle_breakpoint)) opts)
          (util.set-keymap "Set Logpoint"
            ["n"] ["<Leader>" "d" "l"]
            (fn []
              (dap.set_breakpoint
                [nil nil (vim.fn.input "Log point message: ")]) opts))
          (util.set-keymap "Toggle REPL"
            ["n"] ["<Leader>" "d" "r"] (fn [] (dap.repl.toggle)) opts))
       :group group}))

  ;; Register autocompletion for the dap-repl
  (nvim.create_autocmd "FileType"
    {:pattern "dap-repl"
     :callback (fn [] (dap-cmp.attach))
     :group (nvim.create_augroup "DapRepl" {})}))

(defn config []
  "Configure nvim-dap"
  ;; Register debug adapters
  (each [adapter opts (pairs adapters)]
    (tset dap.adapters adapter opts))

  ;; Define configurations
  (each [ft opts (pairs configurations)]
    (tset dap.configurations ft opts))

  ;; Set dap signcolumn signs
  (each [sign opts (pairs signs)]
    (vim.fn.sign_define sign opts)))
