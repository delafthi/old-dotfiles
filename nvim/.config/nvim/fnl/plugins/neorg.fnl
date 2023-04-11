(module plugins.neorg
  {autoload {: neorg
             nvim aniseed.nvim
             : util}})

(defn init []
  "Initialize Neorg"
  ;; Register global keybindings
  (let [opts {:silent true}]
    (util.set-keymap "Open bible notes"
      ["n"] ["<Leader>" "n" "b"] "<Cmd>Neorg workspace bible<Cr>" opts)
    (util.set-keymap "Open general notes"
      ["n"] ["<Leader>" "n" "n"] "<Cmd>Neorg workspace notes<Cr>" opts)
    (util.set-keymap "Open school notes"
      ["n"] ["<Leader>" "n" "s"] "<Cmd>Neorg workspace school<Cr>" opts)
    (util.set-keymap "Open todos"
      ["n"] ["<Leader>" "n" "t"] "<Cmd>Neorg workspace gtd<Cr>" opts))

  ;; Register filetype-specific keybindings
  (let [opts {:silent true
              :buffer true}
        group (nvim.create_augroup "NeorgBufferMappings" {})]
    (nvim.create_autocmd "BufEnter"
      {:pattern "*.norg"
       :callback
        (fn []
          (util.set-keymap "Inject file header"
            ["n"] ["<Leader>" "n" "i"] "<Cmd>Neorg inject-metadata<Cr>" opts)
          (util.set-keymap "Add a task"
            ["n"] ["<Leader>" "n" "t" "a"] "<Cmd>Neorg gtd capture<Cr>" opts)
          (util.set-keymap "View the tasks"
            ["n"] ["<Leader>" "n" "t" "t"] "<Cmd>Neorg gtd views<Cr>" opts))
       :group group})))

(defn config []
  "Configure Neorg"
  ;; Call the setup function
  (neorg.setup
    {:load
      {:core.defaults {}
       :core.keybinds
        {:config
          {:default_keybinds true
           :leader "<LocalLeader"}}
       :core.gtd.base
        {:config {:workspace "gtd"}}
       :core.presenter
        {:config {:slide_count {:position "bottom"}
                  :zen_mode "zen-mode"}}
       :core.norg.concealer
        {:config {:icon_preset "diamond"}}
       :core.norg.dirman
        {:config {:workspaces {:default (vim.fn.getcwd)
                               :notes "~/notes"
                               :school "~/notes/school"
                               :bible "~/notes/bible"
                               :gtd   "~/notes/gtd"}
                  :autochdir false
                  :index "index.norg"
                  :last_workspace (.. (vim.fn.stdpath "cache")
                                      "/neorg_last_workspace.txt")}}
       :core.norg.completion {:config {:engine "nvim-cmp"}}}}))
