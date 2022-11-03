local M = {}

function M.config()
  -- Call the setup function
  require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.3
      end
    end,
    open_mapping = nil,
    highlights = {
      Normal = {
        link = "NormalAlt",
      },
      NormalFloat = {
        link = "NormalAlt",
      },
      FloatBorder = {
        link = "Comment",
      },
      SignColumn = {
        link = "NormalAlt",
      },
    },
    shade_terminals = false,
  })
end

return M
