(module init
  {autoload {a aniseed.core
             nvim aniseed.nvim
             core config.core
             autocmds config.autocmds
             keymaps config.keymaps
             : plugins}})

(core.setup)
(plugins.setup)
(autocmds.setup)
(keymaps.setup)
