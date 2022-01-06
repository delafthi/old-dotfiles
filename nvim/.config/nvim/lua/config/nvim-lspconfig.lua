local M = {}
local u = require("util")

function M.config()
  local ok, lspconfig = pcall(function()
    return require("lspconfig")
  end)

  if not ok then
    return
  end

  -- Mappings.
  ------------------------------------------------------------------------------
  local on_attach = function(client, bufnr)
    vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { noremap = true, silent = true }
    u.bufmap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<Cr>", opts)
    u.bufmap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<Cr>", opts)
    u.bufmap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<Cr>", opts)
    u.bufmap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<Cr>", opts)
    u.bufmap(bufnr, "n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<Cr>", opts)
    u.bufmap(bufnr, "n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<Cr>", opts)
    u.bufmap(
      bufnr,
      "n",
      "gi",
      "<Cmd>lua vim.lsp.buf.implementation()<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<C-s>",
      "<Cmd>lua vim.lsp.buf.signature_help()<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "i",
      "<C-s>",
      "<Cmd>lua vim.lsp.buf.signature_help()<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<Leader>wa",
      "<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<Leader>wr",
      "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<Leader>wl",
      "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<Leader>D",
      "<Cmd>lua vim.lsp.buf.type_definition()<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<Leader>rn",
      "<Cmd>lua vim.lsp.buf.rename()<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<Leader>e",
      "<Cmd>lua vim.diagnostic.open_float({severity_sort = true})<Cr>",
      opts
    )
    u.bufmap(
      bufnr,
      "n",
      "<Leader>q",
      "<Cmd>lua vim.diagnostic.set_loclist()<Cr>",
      opts
    )

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      u.bufmap(
        bufnr,
        "n",
        "<Leader>bf",
        "<Cmd>lua vim.lsp.buf.formatting()<Cr>",
        opts
      )
    elseif client.resolved_capabilities.document_range_formatting then
      u.bufmap(
        bufnr,
        "v",
        "<Leader>bf",
        "<Cmd>lua vim.lsp.buf.ranger_formatting()<Cr>",
        opts
      )
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

  -- Visual
  ------------------------------------------------------------------------------
  -- Customize how diagnosics are displayed
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
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
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = { prefix = "" } }
  )

  -- Setup language servers
  ------------------------------------------------------------------------------

  -- Set language-server capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
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

  -- bash-language-server
  lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
  -- cmake-language server
  lspconfig.cmake.setup({ capabilities = capabilities, on_attach = on_attach })
  -- c-language-server
  lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
      "/usr/bin/clangd",
      "--all-scopes-completion",
      "--background-index",
      "--clang-tidy",
      "--cross-file-rename",
      "--header-insertion=iwyu",
      "--header-insertion-decorators",
    },
  })
  -- dockerfile-language-server
  lspconfig.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
  -- haskell-language-server
  lspconfig.hls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern(
      "*.cabal",
      "stack.yaml",
      "cabal.project",
      "package.yaml",
      "hie.yaml"
    ),
  })
  -- sumneko lua-language-server
  lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      configurationSources = { "flake8" },
      plugins = {
        flake8 = { enabled = true },
        pydocstyle = { enabled = true },
      },
    },
  })
  -- systemverilog language-server
  lspconfig.svls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
  -- (La)Tex-language-server
  lspconfig.texlab.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
  -- vim-language-server
  lspconfig.vimls.setup({ capabilities = capabilities, on_attach = on_attach })

  -- Activate codelens
  vim.cmd([[
  augroup codelens
    autocmd!
    autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
  augroup END
  ]])
end

return M
