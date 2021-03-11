local M = {}

function M.config()
  require('gitsigns').setup {
    signs = {
      add = {
        hl = 'SignifySignAdd',
        text = '+',
        numhl = 'SignifySignAdd'
      },
      change = {
        hl = 'SignifySignChange',
        text = '~',
        numhl = 'SignifySignChange'},
      delete = {
        hl = 'SignifySignDelete',
        text = '-',
        show_count = true,
        numhl = 'SignifySignDelete'
      },
      topdelete = {
        hl = 'SignifySignDelete',
        text = 'ﬠ',
        show_count = true,
        numhl = 'SignifySignDelete'
      },
      changedelete = {
        hl = 'SignifySignChange',
        text = '~',
        show_count = true,
        numhl = 'SignifySignChange'
      }
    },
    count_chars = {
      [1] = '',
      [2] = '₂',
      [3] = '₃',
      [4] = '₄',
      [5] = '₅',
      [6] = '₆',
      [7] = '₇',
      [8] = '₈',
      [9] = '₉',
      ['+'] = '₊'
    },
    numhl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
      ['n ]c'] = {
        expr = true,
        "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<Cr>'"
      },
      ['n [c'] = {
        expr = true,
        "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<Cr>'"
      },
      ['n <Leader>hs'] = '<Cmd>lua require"gitsigns".stage_hunk()<Cr>',
      ['n <Leader>hu'] = '<Cmd>lua require"gitsigns".undo_stage_hunk()<Cr>',
      ['n <Leader>hr'] = '<Cmd>lua require"gitsigns".reset_hunk()<Cr>',
      ['n <Leader>hp'] = '<Cmd>lua require"gitsigns".preview_hunk()<Cr>',
      ['n <Leader>hb'] = '<Cmd>lua require"gitsigns".blame_line()<Cr>'
    },
    watch_index = {interval = 1000},
    sign_priority = 6,
    status_formatter = nil -- Use default
  }
end

return M
