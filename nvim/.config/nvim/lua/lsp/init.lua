--------------------------------------------------------------------------------
-- LSP config
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Local functions declaration
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--------------------------------------------------------------------------------
-- Setup different language servers
local lsp = require 'lspconfig'
lsp.bashls.setup{}
lsp.ccls.setup{}
lsp.dockerls.setup{}
lsp.pyls.setup{root_dir = lsp.util.root_pattern(".git", vim.fn.getcwd())}
lsp.sumneko_lua.setup{root_dir = lsp.util.root_pattern(".git", vim.fn.getcwd())}
lsp.texlab.setup{}
lsp.vimls.setup{}

--------------------------------------------------------------------------------
-- Key mappings
map('n', '<leader>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
