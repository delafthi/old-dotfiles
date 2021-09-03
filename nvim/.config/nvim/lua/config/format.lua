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
  function! TrimTrailingLines()
    let lastLine = line('$')
    let lastNonblankLine = prevnonblank(lastLine)
    if lastLine > 0 && lastNonblankLine != lastLine
      silent! execute lastNonblankLine + 1 . ',$delete _'
    endif
  endfunction
  augroup remove_trailing_whitespaces_and_lines
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritepre * call TrimTrailingLines()
  augroup END
  ]])
end

return M
