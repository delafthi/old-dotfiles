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
      enable = true
    },
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
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
