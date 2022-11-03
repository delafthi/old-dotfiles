local M = {}

function M.config()
  -- Call the setup function
  require("twilight").setup({
    dimming = {
      color = { "Normal", "#d8dee9" },
    },
    context = 10, -- amount of lines we will try to show around the current line
  })
end

return M
