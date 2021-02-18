local M = {}
local u = require('utils')

function M.setup()
  require'telescope'.setup{
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
      },
      prompt_position = 'bottom',
      prompt_prefix = '>>',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'descending',
      layout_strategy = 'vertical',
      layout_defaults = {
      },
      file_sorter =  require'telescope.sorters'.get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      shorten_path = true,
      winblend = 0,
      width = 0.75,
      preview_cutoff = 120,
      results_height = 1,
      results_width = 0.8,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' },
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
  }
end

function M.config()
  -- Show Telescope buffers.
  u.map('n', '<Leader>fb', '<Cmd>lua require("telescope.builtin").buffers()<Cr>', opts)
  -- Search recursively for file in current project directory.
  u.map('n', '<Leader>ff', '<Cmd>lua require("telescope.builtin").find_files({find_command = {"rg","--ignore","--hidden","--files"}})<Cr>', opts)
  -- Grep in project directory.
  u.map('n', '<Leader>fg', '<Cmd>lua require("telescope.builtin").live_grep()<Cr>', opts)
end
return M
