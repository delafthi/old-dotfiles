local M = {}

function M.config()
  local capabilities = require("config.nvim-lspconfig").get_capabilities()
  local on_attach = require("config.nvim-lspconfig").on_attach

  -- Call the setup function
  require("clangd_extensions").setup({
    server = {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--all-scopes-completion",
        "--background-index",
        "--clang-tidy",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
      },
    },
    extensions = {
      ast = {
        role_icons = {
          type = "ﴯ",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  })
end

return M
