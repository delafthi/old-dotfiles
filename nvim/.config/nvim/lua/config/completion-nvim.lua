local M = {}

function M.setup()
  -- Enable automatic source change.
  vim.g.completion_auto_change_source = 1
  -- Set completion chain list.
  vim.g.completion_chain_complete_list = {
    default = {
      default = {
        {complete_items = {'lsp'}},
        {complete_items = {'ts'}},
        {mode = {'file'}},
      },
      string = {
        {complete_items = {'path'}, triggered_only = {'/'}},
      },
    },
    vim = {
      default = {
        {complete_items = {'lsp'}},
        {complete_items = {'ts'}},
        {mode = {'cmd'}},
      },
    },
  }
  -- Custom lsp completion labels.
  vim.g.completion_customize_lsp_label = {
    Function = ' [function]',
    Method = ' [method]',
    Reference = ' [refrence]',
    Enum = ' [enum]',
    Field = 'ﰠ [field]',
    Keyword = ' [key]',
    Variable = ' [variable]',
    Folder = ' [folder]',
    Snippet = ' [snippet]',
    Operator = ' [operator]',
    Module = ' [module]',
    Text = 'ﮜ [text]',
    Class = ' [class]',
    Interface = ' [interface]'
  }
  -- Enable auto popups.
  vim.g.completion_enable_auto_popup = 1
  -- Disable auto hover.
  vim.g.completion_enable_auto_hover = 0
  -- Disable auto signature.
  vim.g.completion_enable_auto_signature = 0
  -- Set smart case matching.
  vim.g.completion_matching_smart_case = 1
  -- Set matching strategy.
  vim.g.completion_matching_strategy = {'exact', 'substring'}
  -- Set sorting of completion items.
  vim.g.completion_sorting = 'none'
end

function M.config()
  if not pcall(require, 'completion') then
    return
  end

  vim.api.nvim_exec([[
    augroup completion_nvim
      autocmd!
      autocmd BufEnter * lua require('completion').on_attach()
      autocmd BufEnter * let g:completion_trigger_character = ['.']
      autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::', '->']
    augroup END ]], false)
end

return M
