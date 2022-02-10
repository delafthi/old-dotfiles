local M = {}

function M.config()
  -- Call the setup function
  require("indent_blankline").setup({
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
