local M = {}

function M.config()
  local ok, npairs = pcall(function()
    return require("nvim-autopairs")
  end)

  if not ok then
    return
  end

  npairs.setup({
    check_ts = true,
  })
end

return M
