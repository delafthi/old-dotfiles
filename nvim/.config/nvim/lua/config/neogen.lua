local M = {}

function M.config()
	local ok, neogen = pcall(function()
		return require("neogen")
	end)

	if not ok then
		return
	end

	neogen.setup({
		enabled = true,
	})
end

return M
