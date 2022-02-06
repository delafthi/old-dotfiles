local M = {}

function M.config()
  local ok, commented = pcall(function()
    return require("commented")
  end)

  if not ok then
    return
  end

  commented.setup({
    comment_padding = " ",
    keybindings = { n = "<Leader>c", v = "<Leader>c", nl = "<Leader>cc" },
    prefer_block_comment = false,
    set_keybindings = true,
    ex_mode_cmd = "Comment",
    hooks = {
      before_comment = require("ts_context_commentstring.internal").update_commentstring,
    },
  })
end

return M
