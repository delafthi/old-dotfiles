local M = {}

function M.setup()
  vim.g.indentLine_char = "│"
  vim.g.indent_blankline_filetype_exclude = {
    "dashboard",
    "help",
    "man",
    "markdown",
    "norg",
    "packer",
    "terminal",
    "org",
  }
end

return M
