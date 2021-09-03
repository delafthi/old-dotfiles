local M = {}
local u = require("utils")

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
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			runInTerminal = false,
		},
	}
	dap.configurations.c = dap.configurations.cpp

	-- Visuals
	vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", {
		text = " ",
		texthl = "Ignore",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapLogPoint", { text = "ﯽ ", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", {
		text = " ",
		texthl = "DapStopped",
		linehl = "",
		numhl = "",
	})

	-- Mappings.
	local opts = { noremap = true, silent = true }
	u.map("n", "<Leader>b", '<Cmd>lua require("dap").toggle_breakpoint()<Cr>', opts)
	u.map("n", "<Leader>dx", '<Cmd>lua require("dap").continue()<Cr>', opts)
	u.map("n", "<Leader>sn", '<Cmd>lua require("dap").step_over()<Cr>', opts)
	u.map("n", "<Leader>si", '<Cmd>lua require("dap").step_into()<Cr>', opts)
	u.map("n", "<Leader>so", '<Cmd>lua require("dap").step_out()<Cr>', opts)
	u.map(
		"n",
		"<Leader>bl",
		'<Cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<Cr>',
		opts
	)
	u.map("n", "<Leader>dr", '<Cmd>lua require("dap").repl.toggle()<Cr>', opts)
	u.map("n", "<Leader>vi", '<Cmd>lua require("dap.ui.widgets").hover()<Cr>', opts)
end

return M
