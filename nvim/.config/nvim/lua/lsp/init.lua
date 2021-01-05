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
-- bash-language-server
lsp.bashls.setup{}
-- c-language-server
lsp.ccls.setup{}
-- dockerfile-language-server
lsp.dockerls.setup{}
-- python-language-server
lsp.pyls.setup{root_dir = lsp.util.root_pattern(".git", vim.fn.getcwd())}
-- sumneko lua-language-server
local sumneko_lua_root_path = vim.fn.stdpath('cache') .. '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_lua_binary = sumneko_lua_root_path .. "/bin/Linux/lua-language-server"
lsp.sumneko_lua.setup{
    cmd = {sumneko_lua_binary, "-E", sumneko_lua_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}
-- (La)Tex-language-server
lsp.texlab.setup{}
-- vim-language-server
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

--------------------------------------------------------------------------------
-- Sign Character customization
local sign_chars = vim.api.nvim_exec(
    [[
    sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
    sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
    sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
    sign define LspDiagnosticsSignHint text=ﯦ texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
    ]],
    true
)
