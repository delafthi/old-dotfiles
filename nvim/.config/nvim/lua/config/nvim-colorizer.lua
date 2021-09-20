local M = {}

function M.config()
  local ok, colorizer = pcall(function()
    return require("colorizer")
  end)

  if not ok then
    return
  end

  colorizer.setup({
    "*",
    "!packer",
    "!dashboard",
    "!help",
    "!terminal",
    "!neogit",
  })
end

return M
