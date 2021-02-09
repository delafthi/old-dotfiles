local M = {}

function M.setup()
  vim.g.kommentary_create_default_mappings = false
end

function M.config()
  require'kommentary.config'.use_extended_mappings()
  local opts = {silent = true}
  vim.api.nvim_set_keymap('n', '<Leader>cc', '<Plug>kommentary_line_default', opts)
  vim.api.nvim_set_keymap('n', '<Leader>c', '<Plug>kommentary_motion_default', opts)
  vim.api.nvim_set_keymap('v', '<Leader>c', '<Plug>kommentary_visual_default', opts)
end

return M
