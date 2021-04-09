local M = {}

function M.config()
  require('nvim-treesitter.configs').setup {
    rainbow = {
      enable = true,
      extended_mode = true,
    }
  }
end

return M
