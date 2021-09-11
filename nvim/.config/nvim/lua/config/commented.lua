local M = {}

function M.config()
  local ok, commented = pcall(function()
    return require("commented")
  end)

  local ok_context_commentstring, context_commentstring = pcall(function()
    return require("ts_context_commentstring.internal")
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
      before_comment = function()
        if ok_context_commentstring then
          return context_commentstring.update_commentstring
        end
      end,
    },
  })
end

return M
