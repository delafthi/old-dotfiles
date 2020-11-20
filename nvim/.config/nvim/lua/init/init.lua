--------------------------------------------------------------------------------
-- Vim init.lua
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- LSP server settings
-- bashls
require'lspconfig'.bashls.setup{}
-- dockerls
require'lspconfig'.dockerls.setup{}
-- vimls
require'lspconfig'.vimls.setup{}
-- texlab
require'lspconfig'.texlab.setup{}
-- pyls
require'lspconfig'.pyls.setup{}
