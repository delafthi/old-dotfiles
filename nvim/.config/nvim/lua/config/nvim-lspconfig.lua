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
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  return capabilities
end

function M.on_attach(client, bufnr)
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
  local wk = require("which-key")

  local opts = { silent = true, buffer = bufnr }
  -- Define keybindings
  wk.register({
    ["<C-g>"] = {
      name = "+goto/get",
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
        diagnostic.setloclist,
        "Get local quickfixlist",
        buffer = bufnr,
      },
    },
    ["<Leader>"] = {
      l = {
        name = "+lsp",
        w = {
          name = "+workspace",
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
            function()
              print(vim.inspect(lsp.buf.list_workspace_folders()))
            end,
            "List workspace folders",
            buffer = bufnr,
          },
        },
      },
    },
  })

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.codeActionProvider then
    wk.register({
      ["<Leader>"] = {
        l = {
          name = "+lsp",
          a = { lsp.buf.code_action, "Code actions", buffer = bufnr },
        }
      }
    })
  end
  if client.server_capabilities.declarationProvider then
    wk.register({
      ["<C-g>"] = {
        name = "+goto/get",
        d = {
          lsp.buf.declaration,
          "Go to declaration",
          buffer = bufnr,
        },
      }
    })
  end
  if client.server_capabilities.definitionProvider then
    wk.register({
      ["<C-g>"] = {
        name = "+goto/get",
        D = {
          lsp.buf.definition,
          "Go to definition",
          buffer = bufnr,
        },
      }
    })
  end
  if client.server_capabilities.documentFormattingProvider then
    wk.register({
      ["<Leader>"] = {
        b = {
          name = "+buffer",
          f = { lsp.buf.format, "Format the buffer", buffer = bufnr },
        },
      },
    })
  end
  if client.server_capabilities.documentRangeFormattingProvider then
    wk.register({
      ["<Leader>"] = {
        b = {
          name = "+buffer",
          f = {
            lsp.buf.range_formattting,
            "Format the selection",
            mode = "v",
            buffer = bufnr,
          },
        },
      },
    })
  end
  if client.server_capabilities.hoverProvider then
    keymap.set({ "n", "i", "v" }, "<C-f>", function()
      diagnostic.open_float({ severity_sort = true })
    end, opts)
    wk.register({
      ["<C-f>"] = { "Show diagnostics info" },
      ["<C-g>"] = {
        name = "+goto/get",
        h = { lsp.buf.hover, "Get hover", buffer = bufnr },
      },
    })
  end
  if client.server_capabilities.implementationsProvider then
    wk.register({
      ["<C-g>"] = {
        name = "+goto/get",
        i = {
          lsp.buf.implementation,
          "Go to implementation",
          buffer = bufnr,
        },
      }
    })
  end
  if client.server_capabilities.referencesProvider then
    wk.register({
      ["<C-g>"] = {
        name = "+goto/get",
        r = {
          lsp.buf.references,
          "Go to references",
          buffer = bufnr,
        },
      }
    })
  end
  if client.server_capabilities.renameProvider then
    wk.register({
      ["<Leader>"] = {
        l = {
          name = "+lsp",
          r = { lsp.buf.rename, "Rename", buffer = bufnr },
        }
      }
    })
  end
  if client.server_capabilities.signatureHelpProvider then
    wk.register({
      ["<C-g>"] = {
        name = "+goto/get",

        s = {
          lsp.buf.signature_help,
          "Get signature help",
          buffer = bufnr,
        },
      }
    })
  end
  if client.server_capabilities.typeDefinitionProvider then
    wk.register({
      ["<C-g>"] = {
        name = "+goto/get",

        t = {
          lsp.buf.type_definition,
          "Get type definition",
          buffer = bufnr,
        },
      }
    })
  end
  if client.server_capabilities.workspaceSymbolProvider then
    wk.register({
      ["<Leader>"] = {
        l = {
          name = "+lsp",

          s = {
            function()
              require("telescope.builtin").lsp_workspace_symbols()
            end,
            "List workspace symbols",
            buffer = bufnr,
          },
        }
      }
    })
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
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
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
  })
  -- c-language-server moved to clangd_extensions
  -- cmake-language server
  lspconfig.cmake.setup({
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
  })
  -- dockerfile-language-server
  lspconfig.dockerls.setup({
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
  })
  -- ltex-language server
  lspconfig.ltex.setup({
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
    settings = {
      ltex = {
        disabledRules = {
          ["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
          ["de-CH"] = { "MORFOLOGIK_RULE_DE_CH" },
          ["fr"] = { "MORFOLOGIK_RULE_FR" },
        },
        additionalRules = {
          languageModel = "~/.local/share/language-tool/ngrams/",
          motherTongue = "de-CH",
        },
      },
    },
  })
  -- python-language-server
  lspconfig.pylsp.setup({
    capabilities = M.get_capabilities(),
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
    capabilities = M.get_capabilities(),
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
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
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
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
  })
  -- VHDL lsp
  lspconfig.vhdlls.setup({
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
  })
  -- vim-language-server
  lspconfig.vimls.setup({
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
  })
end

return M
