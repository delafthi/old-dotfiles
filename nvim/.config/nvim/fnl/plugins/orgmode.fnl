(module config.orgmode
  {autoload {: orgmode}})

(defn config []
  "Configure orgmode.nvim"
  ;; Load custom treesitter parser for org files
  (orgmode.setup_ts_grammar)

  ;; Call the setup function
  (orgmode.setup {}))
