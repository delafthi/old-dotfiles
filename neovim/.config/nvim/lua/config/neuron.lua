local M = {}
local u = require('utils')

M.neuron_dir = vim.fn.expand('~/Zettelkasten')

function M.config()
  local ok, neuron = pcall(function()
    return require('neuron')
  end)

  if not ok then
    return
  end


  neuron.setup {
    neuron_dir = M.neuron_dir,
    mappings = false,
    virtual_titles = true,
    run = nil,
    leader = '<Leader>n',
    gen_cache_on_write = true,
    virt_text_highlight = 'Comment',
  }

  local opts = {noremap = true, silent = true}
  -- u.bufmap(0, 'n', '<Cr>', '<Cmd> lua require("neuron").enter_link()<Cr>', opts)
  u.bufmap(0, 'n', '<Leader>nn', '<Cmd> lua require("neuron.cmd").new_edit(require("config.neuron").neuron_dir)<Cr>', opts)
  u.bufmap(0, 'n', '<Leader>nf', '<Cmd> lua require("neuron.telescope").find_zettels()<Cr>', opts)
  u.bufmap(0, 'n', '<Leader>nF', '<Cmd> lua require("neuron.telescope").find_zettels {insert = true}<Cr>', opts)
  u.bufmap(0, 'n', '<Leader>nb', '<Cmd> lua require("neuron.telescope").find_backlinks()<Cr>', opts)
  u.bufmap(0, 'n', '<Leader>nB', '<Cmd> lua require("neuron.telescope").find_backlinks {insert = true}<Cr>', opts)
  u.bufmap(0, 'n', '<Leader>nt', '<Cmd> lua require("neuron.telescope").find_tags()<Cr>', opts)
  u.bufmap(0, 'n', '<Leader>ns', '<Cmd> lua require("neuron").rib {address = "127.0.0.0.1:8080", verbose = true}<Cr>', opts)
  -- u.bufmap(0, 'n', '<Tab>', '<Cmd> lua require("neuron").goto_next_extmark()<Cr>', opts)
  -- u.bufmap(0, 'n', '<S-Tab>', '<Cmd> lua require("neuron").goto_prev_extmark()<Cr>', opts)
end

return M
