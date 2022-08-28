local M = {}

function M.config()
  require("mkdnflow").setup({
    filetypes = { markdown = true, rmd = true },
    create_dirs = true,
    perspective = {
      priority = "current",
      fallback = "current",
      root_tell = false,
    },
    wrap = false,
    bib = {
      default_path = "~/bibliography/refs.bib",
      find_in_root = false,
    },
    silent = false,
    use_mappings_table = false,
    mappings = {
      MkdnNextLink = { "n", "<C-n>" },
      MkdnPrevLink = { "n", "<C-p>" },
      MkdnNextHeading = { "n", "]h" },
      MkdnPrevHeading = { "n", "[h" },
      MkdnGoBack = { "n", "<Bs>" },
      MkdnGoForward = { "n", "<Del>" },
      MkdnFollowLink = { "n", "<CR>" },
      MkdnYankAnchorLink = { "n", "ya" },
      MkdnYankFileAnchorLink = { "n", "yfa" },
      MkdnIncreaseHeading = { "n", "+" },
      MkdnDecreaseHeading = { "n", "-" },
      MkdnToggleToDo = { "n", "<C-Space>" },
    },
    links = {
      style = "markdown",
      implicit_extension = nil,
      transform_implicit = false,
      transform_explicit = function(text)
        text = text:gsub(" ", "_")
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
  })
end

return M
