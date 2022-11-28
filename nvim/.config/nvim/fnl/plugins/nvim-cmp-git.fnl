(module plugins.nvim-cmp-git
  {autoload {cmp-git cmp_git}})

(defn config []
  "Configure cmp-git"
  ;; Call the setup function
  (cmp-git.setup
    {:filetypes ["gitcommit"
                 "octo"
                 "NeogitCommitMessage"]}))
