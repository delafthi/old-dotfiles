local M = {}

function M.config()
  local autopairs = require("nvim-autopairs")

  -- Call the setup function
  autopairs.setup({
    check_ts = true,
  })

  -- Custom rules
  autopairs.get_rule("'")[1].not_filetypes = {"lisp", "scheme", "scheme.guile"}
end

return M
