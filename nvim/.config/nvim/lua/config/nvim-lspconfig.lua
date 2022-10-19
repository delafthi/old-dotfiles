local M = {}
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local keymap = vim.keymap

-- Sign Character customization
M.signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

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
  local wk = require("which-key")

  local opts = { silent = true, buffer = bufnr }
  -- Define keybindings
  keymap.set({ "n", "i", "v" }, "<C-f>", function()
    diagnostic.open_float({ severity_sort = true })
  end, opts)
  wk.register({
    ["<C-f>"] = { "Show diagnostics info" },
  })

  wk.register({
    ["<C-g>"] = {
      name = "+goto/get",
      d = {
        lsp.buf.declaration,
        "Go to declaration",
        buffer = bufnr,
      },
      D = {
        lsp.buf.definition,
        "Go to definition",
        buffer = bufnr,
      },
      h = { lsp.buf.hover, "Get hover", buffer = bufnr },
      i = {
        lsp.buf.implementation,
        "Go to implementation",
        buffer = bufnr,
      },
      n = {
        name = "+next",
        d = {
          diagnostic.goto_next,
          "Go to next diagnostic",
          buffer = bufnr,
        },
      },
      p = {
        name = "+previous",
        d = {
          diagnostic.goto_prev,
          "Go to previous diagnostic",
          buffer = bufnr,
        },
      },
      q = {
        lsp.util.set_loclist,
        "Get local quickfixlist",
        buffer = bufnr,
      },
      r = {
        lsp.buf.references,
        "Go to references",
        buffer = bufnr,
      },
      t = {
        lsp.buf.type_definition,
        "Get type definition",
        buffer = bufnr,
      },
      s = {
        lsp.buf.signature_help,
        "Get signature help",
        buffer = bufnr,
      },
    },
    ["<Leader>"] = {
      w = {
        l = {
          name = "+lsp",
          a = {
            lsp.buf.add_workspace_folders,
            "Add workspace folders",
            buffer = bufnr,
          },
          d = {
            lsp.buf.remove_workspace_folders,
            "Remove workspace folders",
            buffer = bufnr,
          },
          l = {
            lsp.buf.list_workspace_folders,
            "List workspace folders",
            buffer = bufnr,
          },
          r = { lsp.buf.rename, "Rename", buffer = bufnr },
          s = {
            function()
              require("telescope.builtin").lsp_workspace_symbols()
            end,
            "List workspace symbols",
            buffer = bufnr,
          },
        },
      },
    },
  })

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    wk.register({
      ["<Leader>"] = {
        b = {
          name = "+buffer",
          f = { lsp.buf.formatting, "Format the buffer", buffer = bufnr },
        },
      },
    })
  elseif client.server_capabilities.document_range_formatting then
    wk.register({
      ["<Leader>"] = {
        b = {
          name = "+buffer",
          f = {
            lsp.buf.ranger_formatting,
            "Format the selection",
            mode = "v",
            buffer = bufnr,
          },
        },
      },
    })
  end
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    local lspDocumentHighlight =
      vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      group = lspDocumentHighlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      group = lspDocumentHighlight,
    })
  end
end

function M.config()
  local lspconfig = require("lspconfig")

  -- Visual
  -- Customize how diagnosics are displayed
  lsp.handlers["textDocument/publishDiagnostics"] =
    lsp.with(lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
    })

  for type, icon in pairs(M.signs) do
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

  if not configs["vhdlls"] then
    configs["vhdlls"] = {
      default_config = {
        cmd = { "vhdl_ls" },
        filetypes = { "vhdl" },
        root_dir = function(fname)
          return util.root_pattern("vhdl_ls.toml")(fname)
            or util.find_git_ancestor(fname)
        end,
        settings = {},
        docs = {
          description = [[
https://github.com/VHDL-LS/rust_hdl

A collection of HDL related tools
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
  -- rls (rust-language-server)
  lspconfig.rls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    settings = {
      rust = {
        unstable_features = true,
        build_on_save = false,
        all_features = true,
      },
    },
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
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
  })
  -- (La)Tex-language-server
  lspconfig.texlab.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
  -- VHDL lsp
  lspconfig.vhdlls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })
  -- vim-language-server
  lspconfig.vimls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
  })

  -- Activate codelens
  vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    pattern = "<buffer>",
    callback = function()
      vim.lsp.codelens.refresh()
    end,
    group = vim.api.nvim_create_augroup("LspCodelens", { clear = true }),
  })
end

return M
