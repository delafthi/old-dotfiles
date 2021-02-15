local M = {}
local u = require('utils')

function M.setup()
  vim.g.mkdp_autoclose = 0 -- Disable auto close, when changing to a different buffer.
  vim.g.mkdp_browser = 'brave' -- Set default browser.
  vim.gmkdp_filetypes = {'markdown', 'vimwiki'} -- Set compatible filetypes.
  vim.g.mkdp_page_title = '${name}' -- Set page title.
  vim.g.mkdp_refresh_slow = 0 -- Turn on faust auto refresh.
end

function M.config()
  local opts = {noremap = false, silent = true}
  u.map('n', '<Leader>mp', '<Plug>MarkdownPreviewToggle', opts) -- Set keymap to toggle preview.
end

return M
