local M = {}

function M.config()
  -- Call the setup function
  require("indent_blankline").setup({
    char = "│",
    use_treesitter = true,
    filetype_exclude = {
      "alpha",
      "help",
      "man",
      "markdown",
      "rmd",
      "norg",
      "packer",
    },
    buftype_exclude = {
      "terminal",
    },
  })
end

return M
