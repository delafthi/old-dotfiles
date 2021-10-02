local M = {}

function M.config()
  local ok, indent_blankline = pcall(function()
    return require("indent_blankline")
  end)

  if not ok then
    return
  end

  indent_blankline.setup({
    char = "│",
    use_treesitter = true,
    filetype_exclude = {
      "dashboard",
      "help",
      "man",
      "markdown",
      "norg",
      "packer",
      "org",
    },
    buftype_exclude = {
      "terminal",
    },
  })
end

return M
