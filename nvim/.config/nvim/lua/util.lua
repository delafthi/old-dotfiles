local util = {}
local api = vim.api

-- Set global keymappings
function util.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set buffer specific key mappings
function util.bufmap(bufnr, mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

return util
