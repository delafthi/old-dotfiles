local M = {}

function M.config()
  local ok, ts = pcall(function()
    return require('nvim-treesitter.configs')
  end)

  if not ok then
    return
  end

  ts.setup{
    ensure_installed = 'maintained',
    highlight = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
    },
  }
end

return M
