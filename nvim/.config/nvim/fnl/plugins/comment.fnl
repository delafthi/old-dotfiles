(module plugins.comment
  {autoload {comment-nvim Comment
             ts-integrations-comment ts_context_commentstring.integrations.comment_nvim}})

(defn config []
  "Configure Comment.nvim"
  ;; Call the setup function
  (comment-nvim.setup
    {:pre_hook (ts-integrations-comment.create_pre_hook)}))
