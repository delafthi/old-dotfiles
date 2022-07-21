local M = {}

function M.config()
  -- Call the setup function
  require("nord").setup({
    bold = {
      enabled = true,
    },
    italic = {
      enabled = true,
      comment = false,
      boolean = true,
      statement = true,
      conditional = true,
      ["repeat"] = true,
      label = true,
      operator = false,
      keyword = true,
      exception = true,
    },
    underline = {
      enabled = true,
    },
    undercurl = {
      enabled = true,
    },
    cursor_line_number_background = true,
    uniform_status_lines = true, -- does not matter, because I manually overwrite it in the galaxyline config
    bold_vertical_split_line = false,
    uniform_diff_background = true,
  })
end

return M
