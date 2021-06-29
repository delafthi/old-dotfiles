local M = {}

function M.setup()
end

function M.config()
  local ok, compe = pcall(function()
    return require('compe')
  end)

  if not ok then
    return
  end

  compe.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    resolve_timeout = 800,
    incomplete_delay = 400,
    max_abbr_sidth = 100,
    max_kind_sidth = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
      path = true,
      buffer = true,
      calc = true,
      nvim_lsp = true,
      nvim_lua = true,
      snippets = true,
    },
  }
end

return M
