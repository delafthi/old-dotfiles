local M = {}

function M.config()
  -- Call the setup function
  require("lightspeed").setup({
    match_only_the_start_of_same_char_seqs = true,
    jump_to_unique_chars = {
      highlight_unique_chars = false,
      safety_timeout = 400,
    },
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
end

return M
