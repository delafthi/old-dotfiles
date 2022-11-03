local M = {}

function M.config()
  -- Call the setup function
  require("headlines").setup({
    markdown = {
      fat_headlines = false,
    },
    rmd = {
      fat_headlines = false,
    },
    norg = {
      fat_headlines = false,
    },
    org = {
      fat_headlines = false,
    },
  })
end

return M
