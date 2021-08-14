local M = {}

function M.config()
  local ok, gitsigns = pcall(function()
    return require('gitsigns')
  end)

  if not ok then
    return
  end

gitsigns.setup {
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '│',
      numhl='GitSignsAddNr',
      linehl='GitSignsAddLn'
    },
    change = {
      hl = 'GitSignsChange',
      text = '│',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn'
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '_',
      numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn'
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '‾',
      numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn'
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '~',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn'
    },
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <Leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <Leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <Leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <Leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <Leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <Leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <Leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <Leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000
  },
  current_line_blame = false,
  current_line_blame_delay = 1000,
  current_line_blame_position = 'eol',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_internal_diff = true,  -- If luajit is present
}
end

return M
