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
    indent = {
      enable = false,
    },
    incremental_selection = {
      enable = false,
    },
    -- Treesitter Plugins
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
    },
  }
end

return M
