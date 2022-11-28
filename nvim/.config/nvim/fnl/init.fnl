(module init
  {autoload {core config.core
             commands config.commands
             mappings config.mappings
             plugins plugins.init}})

(core.setup)
(plugins.setup)
(commands.register)
;; Do not load keybindings during the bootstrap phase, since we require
;; which-key
(when (not _G.PACKER_BOOTSTRAP)
  (mappings.register))
