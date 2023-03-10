(module plugins.nvim-cmp
  {autoload {a aniseed.core
             autopairs-cmp nvim-autopairs.completion.cmp
             : cmp
             lsp-kind plugins.lsp.kind
             : luasnip
             : neogen
             nvim aniseed.nvim}})

(defn- has-words-before []
  "Check if there are words before the cursor"
  (let [(line col) (unpack (nvim.win_get_cursor 0))]
    (and (~= col 0))
         (a.nil? (string.match
                   (string.sub
                     (. (nvim.buf_get_lines 0 (- line 1) line true) 1) col col)
                   "%s"))))

(def- shorts
  {:buffer "[Bufr]"
   :calc "[Calc]"
   :luasnip "[Snip]"
   :nvim_lsp "[LSP]"
   :nvim_lsp_signature_help "[Sig]"
   :nvim_lsp_document_symbol "[Sym]"
   :nvim_lua "[API]"
   :neorg "[Norg]"
   :path "[Path]"
   :spell "[Spell]"
   :cmp_git "[Git]"})

(defn config []
  "Configure nvim-cmp"
  ;; Call the setup function
  (cmp.setup
    {:snippet
      {:expand (fn [args] (luasnip.lsp_expand args.body))}
     :window
      {:documentation
        {:border [ "" "" "" " " "" "" "" " " ]
         :winhighlight "Normal:CmpDocumentation,FloatBorder:CmpDocumentation"}}
     :formatting
      {:format (fn [entry item] (lsp-kind.cmp-format entry item shorts))}
     :mapping
      {:<C-y> (cmp.mapping.confirm
                    {:behavior cmp.ConfirmBehavior.Insert
                     :select true} ["c" "i" "s"])
       :<C-e> (cmp.mapping.abort ["c" "i" "s"])
       :<C-n> (cmp.mapping (fn [fallback]
                             (if (cmp.visible)
                                 (cmp.select_next_item)
                                 (neogen.jumpable)
                                 (neogen.jump.next)
                                 (luasnip.expand_or_jumpable)
                                 (luasnip.expand_or_jump)
                                 (has-words-before)
                                 (cmp.complete)
                                 (falback)))
                           ["c" "i" "s"])
       :<C-p> (cmp.mapping (fn [fallback]
                             (if (cmp.visible)
                                 (cmp.select_prev_item)
                                 (neogen.jumpable -1)
                                 (neogen.jump_prev)
                                 (luasnip.jumpable -1)
                                 (luasnip.jump -1)
                                 (fallback)))
                           ["c" "i" "s"])
       :<C-d> (cmp.mapping (cmp.mapping.scroll_docs -4 ["i" "c"]))
       :<C-u> (cmp.mapping (cmp.mapping.scroll_docs 4 ["i" "c"]))}
     :sources (cmp.config.sources
                [{:name "nvim_lsp_signature_help"
                  :max_item_count 10}]
                [{:name "luasnip"
                  :max_item_count 10}]
                [{:name "nvim_lsp"
                  :max_item_count 10}
                 {:name "conjure"
                  :max_item_count 10}
                 {:name "nvim_lua"
                  :max_item_count 10}]
                [{:name "neorg"
                  :max_item_count 10}
                 {:name "git"
                  :max_item_count 10}
                 {:name "path"
                  :max_item_count 10}]
                [{:name "buffer"
                  :keyword_length 5
                  :max_item_count 10}])
     :experimental {:ghost_text {:hl_group "Comment"}}})

  ;; Set completion sources for command mode
  (cmp.setup.cmdline ":"
    {:sources (cmp.config.sources
                [{:name "path"
                  :max_item_count 10}]
                [{:name "cmdline"
                  :max_item_count 10}])})

  ;; Set completion sources for search mode
  (cmp.setup.cmdline "/"
    {:sources (cmp.config.sources
                [{:name "nvim_lsp_document_symbol"
                  :max_item_count 10}]
                [{:name "buffre"
                  :keyword_length 5
                  :max_item_count 10}])})

  ;; Play nice with nvim-autopairs
  (cmp.event:on "confirm_done"
    (autopairs-cmp.on_confirm_done
      {:map_char {:tex ""}})))
