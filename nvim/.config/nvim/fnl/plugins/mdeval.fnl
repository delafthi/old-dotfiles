(module plugins.mdeval
  {autoload {: mdeval
             nvim aniseed.nvim
             : util}})

(defn init []
  "Initialize nvim for mdeval.nvim"
  ;; Register filetype-specific keybindings
  (let [opts {:silent true
              :buffer true}
        group (nvim.create_augroup "MdEvalBufferMappings" {})]
    (nvim.create_autocmd "BufEnter"
      {:pattern ["*.norg" "*.md" "*.rmd"]
       :callback
        (fn []
          (util.set-keymap "Evaluate code block"
            ["n"] ["<LocalLeader>" "e" "b"]
            (fn [] (mdeval.eval_code_block)) opts))
      :group group})))

(defn config []
  "Configure mdeval.nvim"
  ;; Call the setup function
  (mdeval.setup
    {:require_confirmation true
     :eval_options
      {:cpp
        {:command ["clangd++" "-std=c++20" "-O0"]
         :default_header (.. "#include <iostream>\n"
                             "#include <vector>\n")}}}))
