local M = {}
local u = require("utils")

function M.config()
	local ok, lspconfig = pcall(function()
		return require("lspconfig")
	end)

	if not ok then
		return
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = false

	local on_attach = function(client, bufnr)
		vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Mappings.
		local opts = { noremap = true, silent = true }
		u.bufmap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<Cr>", opts)
		u.bufmap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<Cr>", opts)
		u.bufmap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<Cr>", opts)
		u.bufmap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<Cr>", opts)
		u.bufmap(bufnr, "n", "gp", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<Cr>", opts)
		u.bufmap(bufnr, "n", "gn", "<Cmd>lua vim.lsp.diagnostic.goto_next()<Cr>", opts)
		u.bufmap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<Cr>", opts)
		u.bufmap(bufnr, "n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<Cr>", opts)
		u.bufmap(bufnr, "i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<Cr>", opts)
		u.bufmap(bufnr, "n", "<Leader>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>", opts)
		u.bufmap(bufnr, "n", "<Leader>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>", opts)
		u.bufmap(
			bufnr,
			"n",
			"<Leader>wl",
			"<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<Cr>",
			opts
		)
		u.bufmap(bufnr, "n", "<Leader>D", "<Cmd>lua vim.lsp.buf.type_definition()<Cr>", opts)
		u.bufmap(bufnr, "n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<Cr>", opts)
		u.bufmap(bufnr, "n", "<Leader>ld", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<Cr>", opts)
		u.bufmap(bufnr, "n", "<Leader>q", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<Cr>", opts)

		-- Set some keybinds conditional on server capabilities
		if client.resolved_capabilities.document_formatting then
			u.bufmap(bufnr, "n", "<Leader>bf", "<Cmd>lua vim.lsp.buf.formatting()<Cr>", opts)
		elseif client.resolved_capabilities.document_range_formatting then
			u.bufmap(bufnr, "v", "<Leader>bf", "<Cmd>lua vim.lsp.buf.ranger_formatting()<Cr>", opts)
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

	-- Sign Character customization
	vim.api.nvim_exec(
		[[
  sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
  sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
  sign define LspDiagnosticsSignHint text=ﯦ texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
  ]],
		true
	)

	-- Customize virtual text prefix
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ virtual_text = { prefix = "" } }
	)

	-- Setup different language servers
	-- bash-language-server
	lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })
	-- cmake-language server
	lspconfig.cmake.setup({ capabilities = capabilities, on_attach = on_attach })
	-- c-language-server
	lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })
	-- dockerfile-language-server
	lspconfig.dockerls.setup({ capabilities = capabilities, on_attach = on_attach })
	-- haskell-language-server
	lspconfig.hls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = lspconfig.util.root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"),
	})
	-- sumneko lua-language-server
	lspconfig.sumneko_lua.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "lua-language-server" },
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					enable = true,
					-- Get the language server to recognize the vim and awesome globals
					globals = { "vim", "awesome", "client", "root", "screen" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
				telemetry = { enable = false },
			},
		},
	})
	-- python-language-server
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
		settings = { python = { venvPath = vim.fn.expand("$HOME/.pyenv/versions") } },
	})
	-- (La)Tex-language-server
	lspconfig.texlab.setup({ capabilities = capabilities, on_attach = on_attach })
	-- vim-language-server
	lspconfig.vimls.setup({ capabilities = capabilities, on_attach = on_attach })
end

return M
