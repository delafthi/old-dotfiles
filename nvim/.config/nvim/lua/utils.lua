local M = {}
local fn = vim.fn
local api = vim.api

-- Set global keymappings
function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set buffer specific key mappings
function M.bufmap(bufnr, mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

return M
