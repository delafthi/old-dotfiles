local M = {}

function M.config()
  local ok, nord = pcall(function()
    return require("nord")
  end)

  if not ok then
    return
  end

  nord.setup({
    bold = true,
    italic = true,
    underline = true,
    italic_comments = false,
    cursor_line_number_background = true,
    uniform_status_lines = true, -- does not matter, because I manually overwrite it in the galaxyline config
    bold_vertical_split_line = false,
    uniform_diff_background = true,
  })
end

return M
