local M = {}
local u = require('utils')

function M.config()
  local ok, formatter = pcall(function()
    return require('format')
  end)

  if not ok then
    return
  end

  formatter.setup({
    ['*'] = {
      { cmd = { "sed -i 's/[ \t]*$//'" } }, -- remove trailing whitespace
    },
    c = {
      { cmd = { 'clang-format' } },
    },
    cpp = {
      { cmd = { 'clang-format' } },
    },
    fish = {
      { cmd = { 'fish_indent' } },
    },
    haskell = {
      {
        cmd = {
          'hindent',
          '--line-lenght',
          80,
          '--indent-size',
          2,
          '--sort-imports',
        },
      },
    },
    lua = {
      {
        cmd = {
          'stylua',
          '--stdin-filepath',
          vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
          '-',
        },
      },
    },
    markdown = {
      { cmd = { 'prettier -w' } },
      {
        cmd = { 'yapf' },
        start_pattern = '^```python$',
        end_pattern = '^```python$',
        target = 'current',
      },
    },
    python = {
      { cmd = { 'yapf' } },
    },
    shell = {
      cmd = {
        'shfmt', '-ln', 'posix', '-i', 2, '-ci', '-sr', '-kp', '-fn'
      },
    },
    vim = {
      {
        cmd = {
          'stylua',
          '--stdin-filepath',
          vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
          '-',
        },
        start_pattern = '^lua << EOF$',
        end_pattern = '^EOF$',
      },
    },
  })

  local opts = { noremap = true, silent = true }
  u.map('n', '<Leader>bf', ':Format<Cr>', opts)

  -- Automatically deletes all trailing whitespace and newlines at end of file on
  -- save.
  vim.cmd([[
  augroup format_text
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
  ]])
end

return M
