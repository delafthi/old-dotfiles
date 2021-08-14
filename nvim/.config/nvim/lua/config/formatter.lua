local M = {}
local u = require('utils')

function M.config()
  local ok, formatter = pcall(function() return require('formatter') end)

  if not ok then return end

  formatter.setup({
    logging = false,
    filetype = {
      bash = {
        function() return {exe = 'shfmt', args = {'-i', 2}, stdin = true} end
      },
      c = {function() return {exe = 'clang-format', stdin = true} end},
      cpp = {function() return {exe = 'clang-format', stdin = true} end},
      fish = {function() return {exe = 'fish_indent', stdin = true} end},
      haskell = {
        function()
          return {
            exe = 'hindent',
            args = {'--line-lengt', 80, '--indent-size', 2, '--sort-imports'},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = 'lua-format',
            args = {'--indent-width', 2, '--no-use-tab'},
            stdin = true
          }
        end
      },
      python = {function() return {exe = 'yapf', stdin = true} end}
    }
  })

  local opts = {noremap = true, silent = true}
  u.map('n', '<Leader>bf', ':Format<Cr>', opts)
end

return M
