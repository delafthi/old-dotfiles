local M = {}

function M.config()
  require("treesitter-context").setup({
    patterns = {
      -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      default = {
        "class",
        "function",
        "method",
      },
      -- Specific filetypes
    },
  })
end

return M
