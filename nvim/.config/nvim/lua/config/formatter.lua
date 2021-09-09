local M = {}
local u = require("utils")

function M.config()
	local ok, formatter = pcall(function()
		return require("formatter")
	end)

	if not ok then
		return
	end

	formatter.setup({
		filetype = {
			c = {
				function()
					return {
						exe = "clang-format",
						args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
						stdin = true,
						cwd = vim.fn.expand("%:p:h"),
					}
				end,
			},
			cpp = {
				function()
					return {
						exe = "clang-format",
						args = {
							"--assume-filename",
							vim.api.nvim_buf_get_name(0),
						},
						stdin = true,
						cwd = vim.fn.expand("%:p:h"),
					}
				end,
			},
			fish = {
				function()
					return {
						exe = "fish_indent",
						stdin = true,
					}
				end,
			},
			haskell = {
				function()
					return {
						exe = "hindent",
						args = {
							"--line-lenght",
							80,
							"--indent-size",
							2,
							"--sort-imports",
						},
						stdin = true,
					}
				end,
			},
			lua = {
				function()
					return {
						exe = "stylua",
						args = {
							"--stdin-filepath",
							vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
							"-",
						},
						stdin = true,
					}
				end,
			},
			markdown = {
				function()
					return {
						exe = "prettier",
						args = { "-w" },
						stdin = true,
					}
				end,
			},
			python = {
				function()
					return {
						exe = "yapf",
					}
				end,
			},
			shell = {
				function()
					return {
						exe = "shfmt",
						args = {
							"-ln",
							"posix",
							"-i",
							2,
							"-ci",
							"-sr",
							"-kp",
							"-fn",
						},
						stdin = true,
					}
				end,
			},
		},
	})

	local opts = { noremap = true, silent = true }
	u.map("n", "<Leader>bf", ":Format<Cr>", opts)

	-- Automatically formats filetypes on save.
	vim.cmd([[
  augroup format_text
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
  ]])
end

return M
