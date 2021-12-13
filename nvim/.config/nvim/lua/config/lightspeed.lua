local M = {}
local u = require("util")

function M.config()
  local ok, lightspeed = pcall(function()
    return require("lightspeed")
  end)

  if not ok then
    return
  end

  lightspeed.setup({
    grey_out_search_area = true,
    highlight_unique_chars = false,
    match_only_the_start_of_same_char_seqs = true,
    jump_on_partial_input_safety_timeout = 400,
    labels = nil,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
    limit_ft_matches = 4,
  })

  vim.cmd([[
    augroup Lightspeed_nohlsearch
      autocmd User LightspeedEnter let &hlsearch = 0
      autocmd User LightspeedLeave let &hlsearch = 1
    augroup END
  ]])

  local opts = { noremap = false, silent = true }
  u.map("v", ";", "<Plug>Lightspeed_;_sx", opts)
  u.map("v", ";", "<Plug>Lightspeed_;_ft", opts)
  u.map("v", ",", "<Plug>Ligthspeed_,_sx", opts)
  u.map("v", ",", "<Plug>Ligthspeed_,_ft", opts)
end

return M
