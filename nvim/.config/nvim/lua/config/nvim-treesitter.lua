local M = {}

function M.setup()
  local ts = require 'nvim-treesitter.configs'
  ts.setup{ensure_installed = 'all', highlight = {enable = true}}
end

return M
