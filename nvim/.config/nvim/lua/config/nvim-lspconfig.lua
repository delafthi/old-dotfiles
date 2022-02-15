local M = {}
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local keymap = vim.keymap

function M.get_capabilities()
  -- Set language-server capabilities
  local capabilities = lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = false
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport =
    true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport =
    true
  capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = { 1 },
  }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  return capabilities
end

function M.on_attach(client, bufnr)
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Define keybindings
  local opts = { silent = true, buffer = bufnr }
  keymap.set("n", "gD", lsp.buf.declaration, opts)
  keymap.set("n", "gd", lsp.buf.definition, opts)
  keymap.set("n", "gr", lsp.buf.references, opts)
  keymap.set("n", "K", lsp.buf.hover, opts)
  keymap.set("n", "[d", diagnostic.goto_prev, opts)
  keymap.set("n", "]d", diagnostic.goto_next, opts)
  keymap.set("n", "gi", lsp.buf.implementation, opts)
  keymap.set({ "n", "i" }, "<C-s>", lsp.buf.signature_help, opts)
  keymap.set("n", "<Leader>wa", lsp.buf.add_workspace_folder, opts)
  keymap.set("n", "<Leader>wr", lsp.buf.remove_workspace_folder, opts)
  keymap.set("n", "<Leader>wl", function()
    print(vim.inspect(lsp.buf.list_workspace_folders()))
  end, opts)
  keymap.set("n", "<Leader>D", lsp.buf.type_definition, opts)
  keymap.set("n", "<Leader>rn", lsp.buf.rename, opts)
  keymap.set("n", "<Leader>e", function()
    diagnostic.open_float({ severity_sort = true })
  end, opts)
  keymap.set("n", "<Leader>q", lsp.util.set_loclist, opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    keymap.set("n", "<Leader>bf", lsp.buf.formatting, opts)
  elseif client.resolved_capabilities.document_range_formatting then
    keymap.set("v", "<Leader>bf", lsp.buf.ranger_formatting, opts)
  end
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup end
      ]],
      false
    )
  end
end

function M.config()
  local lspconfig = require("lspconfig")

  -- Visual
  -- Customize how diagnosics are displayed
  lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
    lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
    }
  )

  -- Sign Character customization
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Customize virtual text prefix
  lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(
    lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = { prefix = "" } }
  )

  -- Add custom server configs
  local configs = require("lspconfig.configs")
  local util = require("lspconfig.util")

  if not configs["rust_ls"] then
    configs["rust_ls"] = {
      default_config = {
        cmd = { "vhdl_ls" },
        filetypes = { "vhdl" },
        root_dir = function(fname)
          return util.root_pattern({ ".vhdl_ls.toml", "vhdl_ls.toml" })(fname)
            or util.find_git_ancestor(fname)
        end,
        settings = {},
        docs = {
          description = [[
https://github.com/VHDL-LS/rust_hdl

A collection of HDL related tools

`rust_hdl` can be built with cargo
`git clone https://github.com/VHDL-LS/rust_hdl ~/.cache/nvim/rust_ls`
`cd ~/.cache/nvim/rust_ls`
`cargo build --release`
`ln -s ~/.cache/nvim/rust_ls/target/release/vhdl_ls ~/.local/bin/vhdl_ls`
          ]],
        },
      },
    }
  end

  -- Setup language servers
  -- bash-language-server
  lspconfig.bashls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
  -- cmake-language server
  lspconfig.cmake.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
  -- c-language-server moved to clangd_extensions
  -- dockerfile-language-server
  lspconfig.dockerls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
  -- haskell-language-server
  lspconfig.hls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    root_dir = util.root_pattern(
      "*.cabal",
      "stack.yaml",
      "cabal.project",
      "package.yaml",
      "hie.yaml"
    ),
  })
  lspconfig.rust_ls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
  -- sumneko lua-language-server
  lspconfig.sumneko_lua.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    cmd = {
      "/usr/bin/lua-language-server",
      "-E",
      "/usr/share/lua-language-server/main.lua",
    },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
        },
        diagnostics = {
          enable = true,
          -- Get the language server to recognize the vim and awesome globals
          globals = { "vim", "awesome", "client", "root", "screen" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
  })
  -- python-language-server
  lspconfig.pylsp.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    settings = {
      configurationSources = { "flake8" },
      plugins = {
        flake8 = { enabled = true },
        pydocstyle = { enabled = true },
      },
    },
  })
  -- (La)Tex-language-server
  lspconfig.texlab.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
  -- vim-language-server
  lspconfig.vimls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })

  -- Activate codelens
  vim.cmd([[
  augroup codelens
    autocmd!
    autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
  augroup END
  ]])
end

return M
