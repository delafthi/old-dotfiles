local M = {}
local u = require('utils')

function M.config()
  local ok, snippets = pcall(function()
    return require('snippets')
  end)

  if not ok then
    return
  end

  snippets.use_suggested_mappings()

  local opts = {noremap=true}
  u.map('i', '<C-Space>', '<Cmd>lua require("snippets").expand_or_advance(1)<Cr>',
    opts)
  u.map('i', '<C-b>', '<Cmd>lua require("snippets").advance_snippet(-1)<Cr>',
    opts)

  local U = require('snippets.utils')
  snippets.snippets = {
    _global = {
    },
    vimwiki = {
      ['$$'] = U.match_indentation([[
\$\$
\\begin{array}{rcl}
$0
\\end{array}
\$\$]]),
    },
  }
end

return M
