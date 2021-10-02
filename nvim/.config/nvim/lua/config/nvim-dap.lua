local M = {}
local u = require("util")

function M.config()
  local ok, dap = pcall(function()
    return require("dap")
  end)

  if not ok then
    return
  end

  -- Configurations
  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input(
          "Path to executable: ",
          vim.fn.getcwd() .. "/",
          "file"
        )
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
  dap.configurations.c = dap.configurations.cpp

  -- Autocompletion
  vim.cmd([[
    augroup dap-repl
      autocmd!
      autocmd FileType dap-repl lua require("dap.ext.autocompl").attach()
    augroup END
  ]])

  -- Visuals
  vim.fn.sign_define(
    "DapBreakpoint",
    { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" }
  )
  vim.fn.sign_define("DapBreakpointRejected", {
    text = " ",
    texthl = "Ignore",
    linehl = "",
    numhl = "",
  })
  vim.fn.sign_define(
    "DapLogPoint",
    { text = "ﯽ ", texthl = "DiagnosticInfo", linehl = "", numhl = "" }
  )
  vim.fn.sign_define("DapStopped", {
    text = " ",
    texthl = "TSCharacter",
    linehl = "",
    numhl = "",
  })

  -- Mappings.
  local opts = { noremap = true, silent = true }
  u.map(
    "n",
    "<Leader>b",
    "<Cmd>lua require('dap').toggle_breakpoint()<Cr>",
    opts
  )
  u.map(
    "n",
    "<Leader>bl",
    "<Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<Cr>",
    opts
  )
  u.map("n", "<Leader>dr", "<Cmd>lua require('dap').repl.toggle()<Cr>", opts)
end

return M
