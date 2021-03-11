local M = {}

function M.config()
  local ts = require('nvim-treesitter.configs')
  ts.setup{
    ensure_installed = 'maintained',
    highlight = {
      enable = true,
    }
  }
end

return M
