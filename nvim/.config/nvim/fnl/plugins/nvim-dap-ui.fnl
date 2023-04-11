(module plugins.nvim-dap-ui
  {autoload {dap-ui dapui
             : dap
             nvim aniseed.nvim
             : util}})


(defn init []
  "Initialize nvim for nvim-dap-ui"
  ;; Register filetype-specific keybindings
  (let [opts {:silent true
              :buffer true}
        group (nvim.create_augroup "NvimDapUiMappings" {})]
    (nvim.create_autocmd "BufEnter"
      {:pattern ["*.c" "*.cpp" "*.rs"]
       :callback
        (fn []
          (util.set-keymap "Toggle UI"
            ["n"] ["<Leader>" "d" "u"] (fn [] (dap-ui.toggle)) opts))
       :group group})))

(defn config []
  "Configure nvim-dap-ui"

  ;; Register nvim-dap-ui
  (tset dap.listeners.after.event_initialized :dapui_config
    (fn [] (dap-ui.open {})))
  (tset dap.listeners.before.event_terminated :dapui_config
    (fn [] (dap-ui.close {})))
  (tset dap.listeners.before.event_exited :dapui_config
    (fn [] (dap-ui.close {})))

  ;; Call the setup function
  (dap-ui.setup
    {:icons
      {:exanded ""
       :collapsed ""
       :current_frame ""}}))
