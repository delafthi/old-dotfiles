local M = {}

function M.config()
  local ok, orgmode = pcall(function()
    return require("orgmode")
  end)

  if not ok then
    return
  end

  orgmode.setup({
    org_agenda_files = { "~/org/*" },
    org_default_notes_file = "~/org/notes.org",
  })
end

return M
