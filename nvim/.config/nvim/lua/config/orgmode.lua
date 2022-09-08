local M = {}

function M.config()
  local orgmode = require("orgmode")
  -- Load custom tree-sitter parser for the org filetype
  orgmode.setup_ts_grammar()

  orgmode.setup({})
end

return M
