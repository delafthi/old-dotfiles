local M = {}

function M.config()
  require("mkdnflow").setup({
    -- Type: boolean. Create directories (recursively) if link contains a
    --     missing directory.
    -- 'false' prevents missing directories from being created
    create_dirs = true,

    -- Type: string. Navigate to links relative to the directory of the first-
    --     opened file.
    -- 'current' navigates links relative to currently open file
    links_relative_to = "current",

    -- Type: key-value pair(s). The plugin's features are enabled only when one
    -- of these filetypes is opened; otherwise, the plugin does nothing. NOTE:
    -- extensions are converted to lowercase, so any filetypes that convention-
    -- ally use uppercase characters should be provided here in lowercase.
    filetypes = { markdown = true, rmd = true },

    -- Type: boolean. When true, the createLinks() function tries to evaluate
    --     the string provided as the value of new_file_prefix.
    -- 'false' results in the value of new_file_prefix being used as a string,
    --     i.e. it is not evaluated, and the prefix will be invariant.
    evaluate_prefix = true,

    -- Type: string. Defines the prefix that should be used to create new links.
    --     This is evaluated at the time createLink() is run, which is to say
    --     that it's run whenever <CR> is pressed (under the default mappings).
    --     This makes for many interesting possibilities.
    new_file_prefix = "",

    -- Type: boolean. When true and Mkdnflow is searching for the next/previous
    --     link or heading in the file, it will wrap to the beginning of the
    -- file (if it's reached the end) or wrap to the end of the file (if it's
    -- reached the beginning during a backwards search).
    wrap_to_beginning = true,
    wrap_to_end = true,
    -- Type: string. This is the path where mkdnflow will look for a .bib file
    --     when acting upon markdown citations.
    default_bib_path = "~/Bibliography/refs.bib",
    -- Type: boolean. Use mapping table (see '❕Commands and default mappings').
    -- 'false' disables mappings and prevents user from modifying mappings via
    -- the 'mappings' table.
    use_mappings_table = true,
    -- Type: table. Keys should be the names of commands (see :h Mkdnflow-comma-
    -- nds for a list), and values should be strings indicating the key mapping.
    mappings = {
      MkdnNextLink = "]l",
      MkdnPrevLink = "[l",
      MkdnNextHeading = "]h",
      MkdnPrevHeading = "[h",
      MkdnGoBack = "<Bs>",
      MkdnFollowPath = "<Cr>",
      MkdnYankAnchorLink = "yA",
      MkdnCreateLink = "<C-c>f",
    },
  })
end

return M
