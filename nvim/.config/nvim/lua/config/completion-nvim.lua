vim.g.completion_chain_complete_list = {
  default = {
    default = {
      {complete_items = {'ts', 'lsp', 'snippet'}},
    },
    string = {
      {compete_items = {'path'}, triggered_only = {'/'}}
    },
  },
  vim = {
    default = {
      {complete_items = {'ts', 'lsp', 'snippet'}},
      {mode = {'cmd'}},
    },
  },
}
-- Enable auto popups.
vim.g.completion_enable_auto_popup = 1
-- Disable auto hover.
vim.g.completion_enable_auto_hover =0
-- Disable auto signature.
vim.g.completion_enable_auto_signature = 0
-- Set sortin of completion items.
vim.g.completion_sorting = 'none'
-- Set matching strategy.
vim.g.completion_matchin_strategy = 'exact'
