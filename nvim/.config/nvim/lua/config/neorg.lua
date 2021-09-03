local M = {}

function M.config()
  local ok, neorg = pcall(function()
    return require('neorg')
  end)

  if not ok then
    return
  end

  neorg.setup({
    load = {
      ['core.defaults'] = {},
      ['core.keybinds'] = {},
      ['core.norg.concealer'] = {
        config = {
          icons = {
            todo = {
              enabled = true, -- Conceal TODO items
              done = {
                enabled = true, -- Conceal whenever an item is marked as done
                icon = ' ',
              },
              pending = {
                enabled = true, -- Conceal whenever an item is marked as pending
                icon = ' ',
              },
              undone = {
                enabled = true, -- Conceal whenever an item is marked as undone
                icon = ' ',
              },
            },
            quote = {
              enabled = true, -- Conceal quotes
              icon = '∣',
            },
            heading = {
              enabled = true, -- Enable beautified headings

              -- Define icons for all the different heading levels
              level_1 = { enabled = true, icon = '綠' },
              level_2 = { enabled = true, icon = '祿' },
              level_3 = { enabled = true, icon = '雷' },
              level_4 = { enabled = true, icon = '• ' },
            },
            marker = {
              enabled = true, -- Enable the beautification of markers
              icon = '',
            },
          },
        },
      },
      ['core.integrations.treesitter'] = {
        config = {
          highlights = {
            tag = {
              -- The + tells neorg to link to an existing hl
              begin = '+TSKeyword',

              ['end'] = '+TSKeyword',

              name = '+TSKeyword',
              parameters = '+TSType',
              content = '+Normal',
              comment = '+TSComment',
            },

            heading = {
              ['1'] = '+TSAttribute',
              ['2'] = '+TSLabel',
              ['3'] = '+TSMath',
              ['4'] = '+TSString',
            },

            error = '+TSError',

            marker = { [''] = '+TSLabel', title = '+Normal' },

            drawer = {
              [''] = '+TSPunctDelimiter',
              title = '+TSMath',
              content = '+Normal',
            },

            escapesequence = '+TSType',

            todoitem = {
              [''] = '+TSCharacter',
              pendingmark = '+TSNamespace',
              donemark = '+TSMethod',
            },

            unorderedlist = '+TSPunctDelimiter',

            quote = { [''] = '+TSPunctDelimiter', content = '+TSPunctDelimiter' },
          },
        },
      },
      ['core.norg.dirman'] = { config = { workspaces = { notes = '~/neorg' } } },
    },
  })
end

return M
