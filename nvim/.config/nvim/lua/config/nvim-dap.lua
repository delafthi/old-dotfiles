local M = {}

function M.config()
  local dap = require("dap")

  -- DAP configurations
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
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-repl",
    callback = function()
      require("dap.ext.autocompl").attach()
    end,
    group = vim.api.nvim_create_augroup("dapREPL", { clear = true }),
  })

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
end

return M
