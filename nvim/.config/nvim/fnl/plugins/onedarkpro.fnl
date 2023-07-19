(module plugins.onedarkpro
  {autoload {: onedarkpro}})

(defn config []
  "Configure onedarkpro.nvim"
  (onedarkpro.setup
    {:options
     {:bold true
      :cursorline true
      :italic true
      :undeline true
      :undercurl true}
     :plugins
     {:all false
      :dashboard true
      :diffview true
      :gitsigns true
      :indentline true
      :nvim_cmp true
      :nvim_dap true
      :nvim_dap_ui true
      :nvim_lsp true
      :telescope true
      :toggleterm true
      :trouble true
      :which_key true}})
  (vim.cmd "colorscheme onedark"))
