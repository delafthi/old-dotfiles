local M = {}
local u = require('utils')

function M.config()
  local su = require('snippets').u
  -- require('snippets').set_ux(require('snippets.inserters.text_markers'))
  u.map('i', '<Tab>', '<Cmd>lua return require("snippets").expand_or_advance(1)<Cr>')
  u.map('i', '<S-Tab>', '<Cmd>lua return require("snippets").advance_snippet(-1)<Cr>')

  require('snippets').snippets = {
    c = {
      ['#if'] = [[
#if $1
  $0
#endif
      ]],
      ['inc'] = '#include "$1"';
      ['sinc'] = '#include <$1>';
      ['struct'] = su.match_indentation [[
typedef struct $1 {
  $0
} $1;
      ]],
      ['enum'] = su.match_indentation [[
typedef enum $1 {
  $0
} $1;
      ]],
      ['union'] = su.match_indentation [[
union $1 {
  $0
}
      ]],
      ['def'] = [[#define ]];
      ['for'] = su.match_indentation [[
for ($1; $2; $3) {
  $0
}
      ]],
      ['fori'] = su.match_indentation [[
for (int ${1:i}; $1 < $2; $1++) {
  $0
}
      ]],
    },
    latex = {
      ['gfx'] = [[
\begin{figure}[$1]
  \centering
  \includegraphics[${3:width=$2cm}]{$2}
  \caption{$4}
  \label{fig:$5}
\end{figure}
      ]],
    },
    lua = {
      ['fori'] = su.match_indentation [[
for ${1:i} = ${2:1}, ${3:#t} do
  $0
end
      ]],
      ['forp'] = su.match_indentation [[
for ${1:k}, ${2:v} in pairs(${3:t}) do
  $0
end
      ]],
      -- func = [[function${1|test123}(${2|vim.trim})$0 end]];
      ['func'] = 'function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end',
      ['req'] = "local ${2:${1|S.v:match'([^.()]+)[()]*$'}} = require '$1'",
      ['loc'] = 'local $1 = $0',
      ['local'] = 'local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}';
    },
    markdown = {
      -- ['$$'] = su.match_indentation [[
      -- $$
      -- \begin{array}{rcl}
      -- ${1:}
      -- \end{array}
      -- $$
      -- ]],
    },
    _global = {
      ['date'] = '${=os.date()}',
      ['ymd'] = '${=os.date("%Y-%m-%d")}',
      ['time'] = '${=os.time()}',
      ['uname'] = function() return vim.loop.os_uname().sysname end,
      ['copyright'] = su.force_comment 'Copyright (C) Thierry Delafontaine ${=os.date("%Y")}',
    },
  }
end

return M
