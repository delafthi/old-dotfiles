local M = {}

function M.config()
	local ok, lspkind = pcall(function()
		return require("lspkind")
	end)

	if not ok then
		return
	end

	lspkind.init({
		with_text = true,
		preset = "default",
		symbol_map = {
			Text = "",
			Method = "ƒ",
			Function = "",
			Constructor = "",
			Variable = "",
			Class = "",
			Interface = "ﰮ",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "了",
			Keyword = "",
			Snippet = "﬌",
			Color = "",
			File = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
		},
	})
end

return M
