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

-- Add values to a list of settings
function M.add(value, str, sep)
  sep = sep or ','
  str = str or ''
  value = type(value) == 'table' and table.concat(value, sep) or value
  return str ~= '' and table.concat({value, str}, sep) or value
end

-- Set vim options
local opts_info = vim.api.nvim_get_all_options_info()
M.opt = setmetatable({}, {
  __newindex = function(_, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == "win" then
      vim.wo[key] = value
    elseif scope == "buf" then
       vim.bo[key] = value
    end
  end
})

return M
