(module plugins.nvim-treesitter
  {autoload {a aniseed.core
             ts-configs nvim-treesitter.configs
             ts-parsers nvim-treesitter.parsers}})

(def- vhdl-config
  {:install_info
    {:url "https://github.com/alemuller/tree-sitter-vhdl"
     :files ["src/parser.c"]
     :branch "main"}
   :filetype ["vhdl"]})

(defn- add-ts-config [name config]
  "Add a custom tree-sitter configuration"
  (let [parser-configs (ts-parsers.get_parser_configs)]
    (when (a.nil? (. parser-configs name))
          (tset parser-configs name config))))

(defn config []
  "Configure nvim-treesitter"
  ;; Add custom tree-sitter configuration
  (add-ts-config :vhdl vhdl-config)

  ;; Call the setup function
  (ts-configs.setup
    {:ensure_installed "all"
     :highlight
     {:enable true
      :additional_vim_regex_highlighting false}
     :indent {:enable true}
     :incremental_selection
      {:enable true
       :keymaps
        {:init_selection "gnn"
         :node_incremental "grn"
         :scope_incremental "grc"
         :node_decremental "grp"}}

     ;; Tree-sitter plugins
     :context_commentstring {:enable true}
     :rainbow
      {:enable true
       :extended_mode true
       :max_file_lines nil}
     :textobjects
      {:select
        {:enable true
         :lookahead true
         :keymaps
          {:af "@function.outer"
           :ac "@class.outer"
           :if "@function.inner"
           :ic "@class.inner"}}
       :swap
        {:enable true
         :swap_next {:<M-S-l> "@parameter.inner"}
         :swap_previous {:<M-S-h> "@parameter.inner"}}
       :move
        {:enable true
         :set_jumps true
         :goto_next_start
          {"]m" {:desc "Next function start" :query "@function.outer" }
           "]]" {:query "Next class start" :query "@class.outer"}}
         :goto_next_end
          {"]M" {:desc "Next function end" :query "@function.outer" }
           "][" {:query "Next class end" :query "@class.outer"}}
         :goto_previous_start
          {"[m" {:desc "Previous function start" :query "@function.outer" }
           "[[" {:query "Previous class start" :query "@class.outer"}}
         :goto_previous_end
          {"[M" {:desc "Previous function end" :query "@function.outer" }
           "[]" {:query "Previous class end" :query "@class.outer"}}}
       :lsp_interop
        {:enable true
         :border "none"
         :peek_definition_code
          {:<Leader>fF "@function.outer"
           :<Leader>fC "@class.outer"}}}}))
