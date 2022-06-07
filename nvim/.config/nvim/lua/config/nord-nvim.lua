local M = {}

function M.config()
  -- Call the setup function
  require("nord").setup({
    bold = true,
    italic = true,
    underline = true,
    italics = {
      comments = false,
      statements = true,
      conditionals = true,
      repeats = true,
      labels = true,
      operators = false,
      keywords = true,
      exceptions = true,
    },
    cursor_line_number_background = true,
    uniform_status_lines = true, -- does not matter, because I manually overwrite it in the galaxyline config
    bold_vertical_split_line = false,
    uniform_diff_background = true,
  })
end

return M
