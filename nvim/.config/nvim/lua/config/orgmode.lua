local M = {}

function M.config()
  -- Call the setup function
  require("orgmode").setup({
    org_agenda_files = { "~/org/*" },
    org_default_notes_file = "~/org/notes.org",
  })
end

return M
