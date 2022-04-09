local M = {}

function M.config()
  require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.3
      end
    end,
    open_mapping = nil,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    highlights = {
      Normal = {
        link = "Normal",
      },
      NormalFloat = {
        link = "Normal",
      },
      FloatBorder = {
        link = "Comment",
      },
      SignColumn = {
        link = "Normal",
      },
    },
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction = "vertical",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "single",
      winblend = 3,
    },
  })
end

return M
