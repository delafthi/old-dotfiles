local M = {}
local u = require('utils')

function M.setup()
  vim.g.kommentary_create_default_mappings = false
end

function M.config()
  require'kommentary.config'.use_extended_mappings()
  local opts = {noremap = false, silent = true}
  u.map('n', 'gcc', '<Plug>kommentary_line_default', opts)
  u.map('n', 'gc', '<Plug>kommentary_motion_default', opts)
  u.map('v', 'gc', '<Plug>kommentary_visual_default', opts)
end

return M
