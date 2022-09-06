local M = {}

function M.config()
  require("mkdnflow").setup({
    modules = {
      bib = true,
      buffers = true,
      conceal = true,
      cursor = true,
      folds = true,
      links = true,
      lists = true,
      maps = true,
      paths = true,
      tables = true,
    },
    filetypes = { markdown = true, rmd = true },
    create_dirs = true,
    perspective = {
      priority = "current",
      fallback = "current",
      root_tell = false,
      nvim_wd_heel = true,
    },
    wrap = false,
    bib = {
      default_path = "~/bibliography/refs.bib",
      find_in_root = false,
    },
    silent = false,
    links = {
      style = "markdown",
      conceal = false,
      implicit_extension = nil,
      transform_implicit = false,
      transform_explicit = function(text)
        text = text:gsub(" ", "-")
        text = text:lower()
        return text
      end,
    },
    to_do = {
      symbols = { " ", "-", "X" },
      update_parents = true,
      not_started = " ",
      in_progress = "-",
      complete = "X",
    },
    tables = {
      trim_whitespace = true,
      format_on_move = true,
      auto_extend_rows = false,
      auto_extend_cols = false,
    },
    mappings = {
      MkdnEnter = { { "n", "v" }, "<CR>" },
      MkdnTab = { "i", "<Tab>" },
      MkdnSTab = { "i", "<S-Tab>" },
      MkdnNextLink = { "n", "<Tab>" },
      MkdnPrevLink = { "n", "<S-Tab>" },
      MkdnNextHeading = { "n", "]h" },
      MkdnPrevHeading = { "n", "[h" },
      MkdnGoBack = { "n", "<BS>" },
      MkdnGoForward = { "n", "<Del>" },
      MkdnFollowLink = false, -- see MkdnEnter
      MkdnDestroyLink = { "n", "<M-CR>" },
      MkdnTagSpan = { "v", "<M-CR>" },
      MkdnMoveSource = false,
      MkdnYankAnchorLink = { "n", "ya" },
      MkdnYankFileAnchorLink = { "n", "yfa" },
      MkdnIncreaseHeading = { "n", "+" },
      MkdnDecreaseHeading = { "n", "-" },
      MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
      MkdnNewListItem = false,
      MkdnNewListItemBelowInsert = { "n", "o" },
      MkdnNewListItemAboveInsert = { "n", "O" },
      MkdnExtendList = false,
      MkdnUpdateNumbering = false,
      MkdnTableNextCell = false,
      MkdnTablePrevCell = false,
      MkdnTableNextRow = false,
      MkdnTablePrevRow = false,
      MkdnTableNewRowBelow = false,
      MkdnTableNewRowAbove = false,
      MkdnTableNewColAfter = false,
      MkdnTableNewColBefore = false,
      MkdnFoldSection = false,
      MkdnUnfoldSection = false,
    },
  })
end

return M
