local M = {}

function M.config()
  require("nordic").colorscheme({
    -- Underline style used for spelling
    -- Options: 'none', 'underline', 'undercurl'
    underline_option = "undercurl",

    -- Italics for certain keywords such as constructors, functions,
    -- labels and namespaces
    italic = true,

    -- Italic styled comments
    italic_comments = false,

    -- Minimal mode: different choice of colors for Tabs and StatusLine
    minimal_mode = false,

    -- Darker backgrounds for certain sidebars, popups, etc.
    -- Options: true, false, or a table of explicit names
    -- Supported: terminal, qf, vista_kind, packer, nvim-tree, telescope, whichkey
    alternate_backgrounds = false,

    -- Callback function to define custom color groups
    -- See 'lua/nordic/colors/example.lua' for example defitions
    custom_colors = function(c, s, cs)
      return {
        -- nvim-ts-rainbow
        { "rainbowcol1", c.intense_blue },
        { "rainbowcol2", c.purple },
        { "rainbowcol3", c.blue },
        { "rainbowcol4", c.green },
        { "rainbowcol5", c.light_cyan },
        { "rainbowcol6", c.yellow },
        -- Dashboard
        { "DashboardShortCut", c.blue },
        { "DashboardHeader", c.purple },
        { "DashboardCenter", c.dark_white },
        { "DashboardFooter", c.gray, c.none, s.italic },
      }
    end,
  })
end

return M
