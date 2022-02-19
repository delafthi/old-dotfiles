local M = {}

function M.config()
  -- Call the setup function
  require("harpoon").setup({
    global_settings = {
      save_on_toggle = false,
      save_on_change = true,
      enter_on_sendcmd = false,
    },
  })
end

return M
