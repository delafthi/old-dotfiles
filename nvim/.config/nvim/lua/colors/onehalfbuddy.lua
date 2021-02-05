local Color, colors, Group, group, style = require('colorbuddy').setup()
local c = colors
local g = group
local s = style
local b = s.bold
local i = s.italic
local n = s.inverse
local uc = s.undercurl
local ul = s.underline
local r = s.reverse
local sto = s.standout
local no = s.NONE
local v = vim.g

v.colors_name = 'onehalfbuddy'

if vim.o.background == 'dark' then
    -- dark colors
    Color.new('red', '#e06c75')
    Color.new('red_1', '#e45649')
    Color.new('green', '#98c379')
    Color.new('green_1', '#50a14f')
    Color.new('yellow', '#e5c07b')
    Color.new('yellow_1', '#c18401')
    Color.new('blue', '#61afef')
    Color.new('blue_1', '#0184bc')
    Color.new('purple', '#c678dd')
    Color.new('purple_1', '#a626a4')
    Color.new('cyan', '#56b6c2')
    Color.new('cyan_1', '#0997b3')

    Color.new('bg', '#282c34')
    Color.new('bg_1', '#313640')
    Color.new('bg_2', '#373c45')
    Color.new('bg_3', '#474e5d')

    Color.new('fg', '#dcdfe4')
    Color.new('fg_1', '#919baa')
    Color.new('fg_2', '#5c6370')
    Color.new('fg_3', '#474e5d')
else
    -- light colors
    Color.new('red', '#e45649')
    Color.new('red_1', '#e06c75')
    Color.new('green', '#50a14f')
    Color.new('green_1', '#98c379')
    Color.new('yellow', '#c18401')
    Color.new('yellow_1', '#e5c07b')
    Color.new('blue', '#0184bc')
    Color.new('blue_1', '#61afef')
    Color.new('purple', '#a626a4')
    Color.new('purple_1', '#c678dd')
    Color.new('cyan', '#0997b3')
    Color.new('cyan_1', '#56b6c2')

    Color.new('bg', '#fafafa')
    Color.new('bg_1', '#f0f0f0')
    Color.new('bg_2', '#bfceff')
    Color.new('bg_3', '#d4d4d4')

    Color.new('fg', '#383a42')
    Color.new('fg_1', '#5e5e5e')
    Color.new('fg_2', '#a0a1a7')
    Color.new('fg_3', '#a0a1a7')

end

-------------------------------------------------------------
-- Syntax Groups (descriptions and ordering from `:h w18`) --
-------------------------------------------------------------

Group.new('Comment', c.fg_3, c.none, no) -- any comment

Group.new('Constant', c.blue, c.none, no) -- any constant
Group.new('String', c.green, c.none, no) -- this is a string
Group.new('Character', c.green_1, c.none, no) -- a character constant: 'c', '\n'
Group.new('Boolean', c.yellow, c.none, no) -- a boolean constant: TRUE, false
Group.new('Float', c.blue_1, c.none, no) -- a floating point constant: 2.3e10

Group.new('Identifier', c.fg, c.none, no) -- any variable name
Group.new('Function', c.purple, c.none, b) -- function name (also: methods for classes)

Group.new('Statement', c.blue, c.none, i) -- any statement
Group.new('Conditional', c.blue, c.none, i) -- if, then, else, endif, switch, etc.
Group.new('Repeat', c.blue, c.none, i) -- for, do, while, etc.
Group.new('Label', c.yellow, c.none, i) -- case, default, etc.
Group.new('Operator', c.red, c.none, no) -- sizeof", "+", "*", etc.
Group.new('Keyword', c.blue, c.none, i) -- any other keyword
Group.new('Exception', c.red_1, c.none, i) -- try, catch, throw

Group.new('PreProc', c.cyan, c.none, no) -- generic Preprocessor
Group.new('Include', c.blue_1, c.none, no) -- preprocessor #include
Group.new('Define', c.blue_1, c.none, no) -- preprocessor #define
Group.new('Macro', c.blue_1, c.none, b) -- same as Define
Group.new('PreCondit', c.blue, c.none, no) -- preprocessor #if, #else, #endif, etc.

Group.new('Type', c.yellow, c.none, no) -- int, long, char, etc.
Group.new('StorageClass', c.yellow_1, c.none, b) -- static, register, volatile, etc.
Group.new('Structure', c.purple, c.none, b) -- struct, union, enum, etc.
Group.new('Typedef', c.purple, c.none, no) -- A typedef

Group.new('Special', c.yellow, c.none, i) -- any special symbol
Group.new('SpecialChar', c.yellow, c.none, no) -- special character in a constant
Group.new('Tag', c.cyan_1, c.none, no) -- you can use CTRL-] on this
Group.new('Delimiter', c.red_1, c.none, no) -- character that needs attention
Group.new('SpecialComment', c.fg_2, c.none, no) -- special things inside a comment
Group.new('Debug', c.red_1, c.none, b) -- debugging statements

Group.new('Underlined', c.blue, c.none, ul) -- text that stands out, HTML links

Group.new('Ignore', c.fg, c.none, no) -- left blank, hidden

Group.new('Error', c.red, c.none, b + r) -- any erroneous construct

Group.new('Todo', c.yellow, c.none, b + r) -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

--------------------------------------------------------------------------------
-- Highlighting Groups (descriptions and ordering from `:h highlight-groups`) --
--------------------------------------------------------------------------------

Group.new('ColorColumn', c.fg, c.bg_1, no) --  used for the columns set with 'colorcolumn'
Group.new('Conceal', c.blue, c.bg, no) -- placeholder characters substituted for concealed text (see 'conceallevel')
Group.new('Cursor', c.fg, c.none, b + r) -- the character under the cursor
Group.new('lCursor', c.fg, c.none, b + r) -- the character under the crusor when language-mapping is used (see 'guicursor')
Group.new('CursorIM', c.fg, c.none, r) -- like Cursor, but used when in IME mode
Group.new('CursorColumn', c.none, c.none, b + r) -- Screen-column at the  cursor, when 'cursorcolumn' is set.
Group.new('CursorLine', c.none, c.bg_1, no) -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guigf) is not set.
Group.new('Directory', c.blue, c.none, b) -- directory names (and other special names in listings)
Group.new('DiffAdd', c.green, c.none, r) -- diff mode: Added line
Group.new('DiffChange', c.yellow, c.none, r) --  diff mode: Changed line
Group.new('DiffDelete', c.red, c.none, r) -- diff mode: Deleted line
Group.new('DiffText', c.yellow, c.none, r) -- diff mode: Changed text within a changed line
Group.new('EndOfBuffer', c.none, c.none, no) -- filler lines (~) after the last line in the buffer
Group.new('TermCursor', c.none, c.none, no) -- cursor in a focused terminal
Group.new('TermCursorNC', c.fg_2, c.none, r) -- cursor in an unfocused terminal
Group.new('ErrorMsg', c.red, c.none, no) -- error messages on the command line
Group.new('VertSplit', c.bg_2, c.bg_2, no) -- the column separating verti-- cally split windows
Group.new('Folded', c.purple, c.bg_1, i) -- line used for closed folds
Group.new('FoldColumn', c.none, c.none, no) -- 'foldcolumn'
Group.new('SignColumn', c.fg_2, c.none, no) -- column where signs are displayed
Group.new('IncSearch', c.yellow_1, c.none, b + r) -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
Group.new('Substitute', c.yellow_1, c.none, b + r) -- :substitute replacement text highlighting
Group.new('LineNr', c.fg_1, c.none, no) -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
Group.new('CursorLineNr', c.blue, c.none, b) -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
Group.new('MatchParen', c.blue_1, c.none, b + ul) -- The character under the cursor or just before it, if it is a paired bracket, and its match.
Group.new('ModeMsg', c.yellow, c.none, no) -- 'showmode' message (e.g., "-- INSERT --")
Group.new('MsgArea', c.yellow, c.none, no) -- Area for messages and cmdline
Group.new('MsgSeparator', c.yellow, c.none, no) -- Separator for scrolled messages, msgsep flag of 'display'
Group.new('MoreMsg', g.ModeMsg, g.ModeMsg, g.ModeMsg) -- more-prompt
Group.new('NonText', c.fg_1, c.none, no) -- '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
Group.new('Normal', c.fg, c.bg, no) -- normal text
Group.new('NormalFloat', c.fg, c.bg, no) -- normal text in floating windows
Group.new('NormalNC', c.fg, c.bg, no) -- normal text in non-current windows
Group.new('Pmenu', c.fg, c.bg_2, no) -- Popup menu: normal item.
Group.new('PmenuSel', c.blue, c.none, b + r) -- Popup menu: selected item.
Group.new('PmenuSbar', c.fg, c.bg_3, no) -- Popup menu: scrollbar.
Group.new('PmenuThumb', c.fg, c.blue, no) -- Popup menu: Thumb of the scrollbar.
Group.new('Question', c.yellow, c.none, b) -- hit-enter prompt and yes/no questions
Group.new('QuickFixLine', g.Search, g.Search, g.Search) -- Current quickfix item in the quickfix window.
Group.new('Search', c.yellow_1, c.none, b + r) -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
Group.new('SpecialKey', c.purple, c.none, no) -- Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
Group.new('SpellBad', c.red, c.none, i + uc) -- Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
Group.new('SpellCap', c.blue, c.none, i + uc) -- Word that should start with a capital. This will be combined with the highlighting used otherwise.
Group.new('SpellLocal', c.cyan, c.none, i + uc) -- Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
Group.new('SpellRare', c.purple, c.none, i + uc) -- Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
Group.new('StatusLine', c.fg, c.bg_1, no) -- status line of current window
Group.new('StatusLineNC', c.fg, c.bg_1, no) -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
Group.new('TabLine', c.blue, c.bg, no) -- tab  pages line, not active tap page label
Group.new('TabLineFill', c.cyan, c.bg_1, no) -- tab  pages line, where there are no labels
Group.new('TabLineSel', c.green, c.bg_1, no) -- tab  pages line, active tab page label
Group.new('Title', c.green, c.none, b) -- titles for output from ":set all", ":autocmd" etc.
Group.new('Visual', c.fg, c.purple, no) -- Visual mode selection
Group.new('VisualNOS', g.Visual, g.Visual, g.Visual) -- Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
Group.new('WarningMsg', c.red, c.none, no) --  warning messages
Group.new('Whitespace', c.red, c.none, no) -- "nbsp", "space", "tab" and "trail" in 'listchars'
Group.new('WildMenu', c.yellow, c.bg_1, b) --  current match in 'wildmenu' completion

--------------------------------
-- Miscellaneous Highlighting --
--------------------------------

Group.new('ToolbarLine', c.fg, c.bg_3, no)
Group.new('ToolbarButton', c.fg, c.bg_3, b)
Group.new('NormalMode', c.green, c.none, r)
Group.new('InsertMode', c.blue, c.none, r)
Group.new('ReplaceMode', c.cyan, c.none, r)
Group.new('VisualMode', c.yellow, c.none, r)
Group.new('CommandMode', c.purple, c.none, r)
Group.new('Warnings', c.yellow, c.none, r)

------------------------------------
-- Language-Specific Highlighting --
------------------------------------

-- C
Group.new('cOperator', c.purple, c.none, no)
Group.new('cStructure', c.yellow, c.none, no)
-- CoffeeScript
Group.new('coffeeExtendedOp', c.fg_3, c.none, no)
Group.new('coffeeSpecialOp', c.fg_3, c.none, no)
Group.new('coffeeCurly', c.yellow, c.none, no)
Group.new('coffeeParen', c.fg_3, c.none, no)
Group.new('coffeeBracket', c.yellow, c.none, no)
-- Clojure
Group.new('clojureKeyword', c.blue, c.none, no)
Group.new('clojureCond', c.yellow, c.none, no)
Group.new('clojureSpecial', c.yellow, c.none, no)
Group.new('clojureDefine', c.yellow, c.none, no)
Group.new('clojureFunc', c.yellow, c.none, no)
Group.new('clojureRepeat', c.yellow, c.none, no)
Group.new('clojureCharacter', c.cyan, c.none, no)
Group.new('clojureStringEscape', c.cyan, c.none, no)
Group.new('clojureException', c.red, c.none, no)
Group.new('clojureRegexp', c.cyan, c.none, no)
Group.new('clojureRegexpEscape', c.cyan, c.none, no)
Group.new('clojureRegexpCharClass', c.fg_3, c.none, b)
Group.new('clojureRegexpMod', g.clojureRegexpCharClass, g.clojureRegexpCharClass, g.clojureRegexpCharClass)
Group.new('clojureRegexpQuantifier', g.clojureRegexpCharClass, g.clojureRegexpCharClass, g.clojureRegexpCharClass)
Group.new('clojureParen', c.fg_3, c.none, no)
Group.new('clojureAnonArg', c.yellow, c.none, no)
Group.new('clojureVariable', c.blue, c.none, no)
Group.new('clojureMacro', c.yellow, c.none, no)
Group.new('clojureMeta', c.yellow, c.none, no)
Group.new('clojureDeref', c.yellow, c.none, no)
Group.new('clojureQuote', c.yellow, c.none, no)
Group.new('clojureUnquote', c.yellow, c.none, no)
-- CSS
Group.new('cssBraces', c.blue, c.none, no)
Group.new('cssFunctionName', c.yellow, c.none, no)
Group.new('cssIdentifier', c.yellow, c.none, no)
Group.new('cssClassName', c.green, c.none, no)
Group.new('cssColor', c.blue, c.none, no)
Group.new('cssSelectorOp', c.blue, c.none, no)
Group.new('cssSelectorOp2', c.blue, c.none, no)
Group.new('cssImportant', c.green, c.none, no)
Group.new('cssVendor', c.fg_1, c.none, no)
Group.new('cssTextProp', c.cyan, c.none, no)
Group.new('cssAnimationProp', c.cyan, c.none, no)
Group.new('cssUIProp', c.yellow, c.none, no)
Group.new('cssTransformProp', c.cyan, c.none, no)
Group.new('cssTransitionProp', c.cyan, c.none, no)
Group.new('cssPrintProp', c.cyan, c.none, no)
Group.new('cssPositioningProp', c.yellow, c.none, no)
Group.new('cssBoxProp', c.cyan, c.none, no)
Group.new('cssFontDescriptorProp', c.cyan, c.none, no)
Group.new('cssFlexibleBoxProp', c.cyan, c.none, no)
Group.new('cssBorderOutlineProp', c.cyan, c.none, no)
Group.new('cssBackgroundProp', c.cyan, c.none, no)
Group.new('cssMarginProp', c.cyan, c.none, no)
Group.new('cssListProp', c.cyan, c.none, no)
Group.new('cssTableProp', c.cyan, c.none, no)
Group.new('cssFontProp', c.cyan, c.none, no)
Group.new('cssPaddingProp', c.cyan, c.none, no)
Group.new('cssDimensionProp', c.cyan, c.none, no)
Group.new('cssRenderProp', c.cyan, c.none, no)
Group.new('cssColorProp', c.cyan, c.none, no)
Group.new('cssGeneratedContentProp', c.cyan, c.none, no)
-- DTD
Group.new('dtdFunction', c.fg_3, c.none, no)
Group.new('dtdTagName', c.purple, c.none, no)
Group.new('dtdParamEntityPunct', c.fg_3, c.none, no)
Group.new('dtdParamEntityDPunct', c.fg_3, c.none, no)
-- Diff
Group.new('diffAdded', c.green, c.none, no)
Group.new('diffRemoved', c.red, c.none, no)
Group.new('diffChanged', c.cyan, c.none, no)
Group.new('diffFile', c.yellow, c.none, no)
Group.new('diffNewFile', c.yellow, c.none, no)
Group.new('diffLine', c.blue, c.none, no)
-- Elixir
Group.new('elixirDocString', g.Comment, g.Comment, g.Comment)
Group.new('elixirStringDelimiter', c.green, c.none, no)
Group.new('elixirInterpolationDelimiter', c.cyan, c.none, no)
Group.new('elixirModuleDeclaration', c.yellow, c.none, no)
-- Go
Group.new('goDirective', c.cyan, c.none, no)
Group.new('goConstants', c.purple, c.none, no)
Group.new('goDeclaration', g.Keyword, g.Keyword, g.Keyword)
Group.new('goDeclType', c.blue, c.none, no)
Group.new('goBuiltins', c.yellow, c.none, no)
-- Haskell
Group.new('haskellType', g.Type, nil)
Group.new('haskellIdentifier', g.Identifier, nil)
Group.new('haskellSeparator', c.cyan, nil)
Group.new('haskellDelimiter', g.Delimiter, nil)
Group.new('haskellOperators', c.blue, c.none, no)
Group.new('haskellBacktick', c.yellow, c.none, no)
Group.new('haskellStatement', c.yellow, c.none, no)
Group.new('haskellConditional', c.yellow, c.none, no)
Group.new('haskellLet', c.cyan, c.none, no)
Group.new('haskellDefault', c.cyan, c.none, no)
Group.new('haskellWhere', c.cyan, c.none, no)
Group.new('haskellBottom', c.cyan, c.none, no)
Group.new('haskellBlockKeywords', c.cyan, c.none, no)
Group.new('haskellImportKeywords', c.cyan, c.none, no)
Group.new('haskellDeclKeyword', c.cyan, c.none, no)
Group.new('haskellDeriving', c.cyan, c.none, no)
Group.new('haskellAssocType', c.cyan, c.none, no)
Group.new('haskellNumber', c.purple, c.none, no)
Group.new('haskellPragma', c.purple, c.none, no)
Group.new('haskellString', c.green, c.none, no)
Group.new('haskellChar', c.green, c.none, no)
-- HTML (keep consistent with Markdown, below)
Group.new('htmlTag', c.blue, c.none, no)
Group.new('htmlEndTag', c.blue, c.none, no)
Group.new('htmlTagName', c.purple2, c.none, no)
Group.new('htmlArg', c.cyan, c.none, no)
Group.new('htmlScriptTag', c.purple, c.none, no)
Group.new('htmlTagN', c.fg_1, c.none, no)
Group.new('htmlSpecialTagName', c.cyan, c.none, b)
Group.new('htmlLink', c.blue, c.none, ul)
Group.new('htmlSpecialChar', c.yellow, c.none, no)
Group.new('htmlBold', c.fg, c.none, b)
Group.new('htmlBoldUnderline', c.fg, c.none, b, ul)
Group.new('htmlBoldItalic', c.fg, c.none, b + i)
Group.new('htmlBoldUnderlineItalic', c.fg, c.none, b + i + ul)
Group.new('htmlUnderline', c.fg, c.none, ul)
Group.new('htmlUnderlineItalic', c.fg, c.none, i + ul)
Group.new('htmlItalic', c.blue1, c.none, i)
Group.new('htmlH1', c.blue, c.none, b)
Group.new('htmlH2', c.cyan, c.none, b)
Group.new('htmlH3', c.green, c.none, b)
Group.new('htmlH4', c.yellow, c.none, b)
Group.new('htmlH5', c.yellow, c.none, no)
Group.new('htmlH6', c.yellow, c.none, no)
-- Java
Group.new('javaAnnotation', c.blue, c.none, no)
Group.new('javaDocTags', c.cyan, c.none, no)
Group.new('javaCommentTitle', g.vimCommentTitle, g.vimCommentTitle, g.vimCommentTitle)
Group.new('javaParen', c.fg_3, c.none, no)
Group.new('javaParen1', c.fg_3, c.none, no)
Group.new('javaParen2', c.fg_3, c.none, no)
Group.new('javaParen3', c.fg_3, c.none, no)
Group.new('javaParen4', c.fg_3, c.none, no)
Group.new('javaParen5', c.fg_3, c.none, no)
Group.new('javaOperator', c.yellow, c.none, no)
Group.new('javaVarArg', c.green, c.none, no)
-- JavaScript
Group.new('javaScriptBraces', c.fg_1, c.none, no)
Group.new('javaScriptFunction', c.cyan, c.none, no)
Group.new('javaScriptIdentifier', c.red, c.none, no)
Group.new('javaScriptMember', c.blue, c.none, no)
Group.new('javaScriptNumber', c.purple, c.none, no)
Group.new('javaScriptNull', c.purple, c.none, no)
Group.new('javaScriptParens', c.fg_3, c.none, no)
Group.new('javascriptImport', c.cyan, c.none, no)
Group.new('javascriptExport', c.cyan, c.none, no)
Group.new('javascriptClassKeyword', c.cyan, c.none, no)
Group.new('javascriptClassExtends', c.cyan, c.none, no)
Group.new('javascriptDefault', c.cyan, c.none, no)
Group.new('javascriptClassName', c.yellow, c.none, no)
Group.new('javascriptClassSuperName', c.yellow, c.none, no)
Group.new('javascriptGlobal', c.yellow, c.none, no)
Group.new('javascriptEndColons', c.fg_1, c.none, no)
Group.new('javascriptFuncArg', c.fg_1, c.none, no)
Group.new('javascriptGlobalMethod', c.fg_1, c.none, no)
Group.new('javascriptNodeGlobal', c.fg_1, c.none, no)
Group.new('javascriptBOMWindowProp', c.fg_1, c.none, no)
Group.new('javascriptArrayMethod', c.fg_1, c.none, no)
Group.new('javascriptArrayStaticMethod', c.fg_1, c.none, no)
Group.new('javascriptCacheMethod', c.fg_1, c.none, no)
Group.new('javascriptDateMethod', c.fg_1, c.none, no)
Group.new('javascriptMathStaticMethod', c.fg_1, c.none, no)
Group.new('javascriptURLUtilsProp', c.fg_1, c.none, no)
Group.new('javascriptBOMNavigatorProp', c.fg_1, c.none, no)
Group.new('javascriptDOMDocMethod', c.fg_1, c.none, no)
Group.new('javascriptDOMDocProp', c.fg_1, c.none, no)
Group.new('javascriptBOMLocationMethod', c.fg_1, c.none, no)
Group.new('javascriptBOMWindowMethod', c.fg_1, c.none, no)
Group.new('javascriptStringMethod', c.fg_1, c.none, no)
Group.new('javascriptVariable', c.yellow, c.none, no)
Group.new('javascriptIdentifier', c.yellow, c.none, no)
Group.new('javascriptClassSuper', c.yellow, c.none, no)
Group.new('javascriptFuncKeyword', c.cyan, c.none, no)
Group.new('javascriptAsyncFunc', c.cyan, c.none, no)
Group.new('javascriptClassStatic', c.yellow, c.none, no)
Group.new('javascriptOperator', c.red1, c.none, no)
Group.new('javascriptForOperator', c.red1, c.none, no)
Group.new('javascriptYield', c.red1, c.none, no)
Group.new('javascriptExceptions', c.red_1, c.none, no)
Group.new('javascriptMessage', c.red_1, c.none, no)
Group.new('javascriptTemplateSB', c.cyan, c.none, no)
Group.new('javascriptTemplateSubstitution', c.fg_1, c.none, no)
Group.new('javascriptLabel', c.fg_1, c.none, no)
Group.new('javascriptObjectLabel', c.fg_1, c.none, no)
Group.new('javascriptPropertyName', c.fg_1, c.none, no)
Group.new('javascriptLogicSymbols', c.fg_1, c.none, no)
Group.new('javascriptArrowFunc', c.yellow, c.none, no)
Group.new('javascriptDocParamName', c.fg_3, c.none, no)
Group.new('javascriptDocTags', c.fg_3, c.none, no)
Group.new('javascriptDocNotation', c.fg_3, c.none, no)
Group.new('javascriptDocParamType', c.fg_3, c.none, no)
Group.new('javascriptDocNamedParamType', c.fg_3, c.none, no)
Group.new('javascriptBrackets', c.fg_1, c.none, no)
Group.new('javascriptDOMElemAttrs', c.fg_1, c.none, no)
Group.new('javascriptDOMEventMethod', c.fg_1, c.none, no)
Group.new('javascriptDOMNodeMethod', c.fg_1, c.none, no)
Group.new('javascriptDOMStorageMethod', c.fg_1, c.none, no)
Group.new('javascriptHeadersMethod', c.fg_1, c.none, no)
Group.new('javascriptAsyncFuncKeyword', c.red_1, c.none, b)
Group.new('javascriptAwaitFuncKeyword', c.red_1, c.none, b)
Group.new('jsClassKeyword', g.Keyword, g.Keyword, g.Keyword)
Group.new('jsExtendsKeyword', g.Keyword, g.Keyword, g.Keyword)
Group.new('jsExportDefault', c.blue, c.none, b)
Group.new('jsTemplateBraces', c.cyan, c.none, no)
Group.new('jsGlobalNodeObjects', g.Keyword, g.Keyword, g.Keyword)
Group.new('jsGlobalObjects', g.Keyword, g.Keyword, g.Keyword)
Group.new('jsFunction', g.Function, g.Function, g.Function)
Group.new('jsFuncParens', c.yellow, c.none, no)
Group.new('jsParens', c.red1, c.none, no)
Group.new('jsNull', c.purple, c.none, no)
Group.new('jsUndefined', g.ErrorMsg, g.ErrorMsg, g.ErrorMsg)
Group.new('jsClassDefinition', c.yellow, c.none, no)
Group.new('jsObjectProp', g.Identifier, g.Identifier, g.Identifier)
Group.new('jsObjectKey', c.blue, c.none, no)
Group.new('jsFunctionKey', c.blue_1, c.none, no)
Group.new('jsBracket', c.red_1, c.none, no)
Group.new('jsObjectColon', c.red_1, c.none, no)
Group.new('jsFuncArgs', c.blue, c.none, no)
Group.new('jsFuncBraces', c.blue_1, c.none, no)
Group.new('jsVariableDef', c.fg_1, c.none, no)
Group.new('jsObjectBraces', g.Special, g.Special, g.Special)
Group.new('jsObjectValue', c.fg_2, c.none, no)
Group.new('jsClassBlock', c.blue_1, c.none, no)
Group.new('jsFutureKeys', c.yellow, c.none, b)
Group.new('jsFuncArgs', c.blue, c.none, no)
Group.new('jsStorageClass', c.blue, c.none, no)
Group.new('jsxRegion', c.blue, c.none, no)
-- JSON
Group.new('jsonKeyword', c.green, c.none, no)
Group.new('jsonQuote', c.green, c.none, no)
Group.new('jsonBraces', c.fg_1, c.none, no)
Group.new('jsonString', c.fg_1, c.none, no)
-- Lua
Group.new('luaIn', c.red_1, c.none, no)
Group.new('luaFunction', c.cyan, c.none, no)
Group.new('luaTable', c.yellow, c.none, no)
-- Markdown (keep consistent with HTML, above
Group.new('markdownItalic', g.htmlItalic, g.htmlItalic, g.htmlItalic)
Group.new('markdownH1', g.htmlH1, g.htmlH1, g.htmlH1)
Group.new('markdownH2', g.htmlH2, g.htmlH2, g.htmlH2)
Group.new('markdownH3', g.htmlH3, g.htmlH3, g.htmlH3)
Group.new('markdownH4', g.htmlH4, g.htmlH4, g.htmlH4)
Group.new('markdownH5', g.htmlH5, g.htmlH5, g.htmlH5)
Group.new('markdownH6', g.htmlH6, g.htmlH6, g.htmlH6)
Group.new('markdownCode', c.purple, c.none, no)
Group.new('mkdCode', g.markdownCode, g.markdownCode, g.markdownCode)
Group.new('markdownCodeBlock', c.yellow, c.none, no)
Group.new('markdownCodeDelimiter', c.yellow, c.none, i)
Group.new('mkdCodeDelimiter', g.markdownCodeDelimiter, g.markdownCodeDelimiter, g.markdownCodeDelimiter)
Group.new('markdownBlockquote', c.yellow, c.none, b)
Group.new('markdownListMarker', c.fg, c.none, b)
Group.new('markdownOrderedListMarker', c.red, c.none, b)
Group.new('markdownRule', c.fg_3, c.none, no)
Group.new('markdownHeadingRule', c.fg_3, c.none, no)
Group.new('markdownUrlDelimiter', c.cyan, c.none, no)
Group.new('markdownLinkDelimiter', c.red, c.none, no)
Group.new('markdownLinkTextDelimiter', c.yellow, c.none, no)
Group.new('markdownHeadingDelimiter', c.yellow, c.none, no)
Group.new('markdownUrl', c.blue, c.none, ul)
Group.new('markdownUrlTitleDelimiter', c.green, c.none, ul)
Group.new('markdownLinkText', g.htmlLink, g.htmlLink, g.htmlLink)
Group.new('markdownIdDeclaration', g.markdownLinkText, g.markdownLinkText, g.markdownLinkText)
-- MoonScript
Group.new('moonSpecialOp', c.fg_3, c.none, no)
Group.new('moonExtendedOp', c.fg_3, c.none, no)
Group.new('moonFunction', c.fg_3, c.none, no)
Group.new('moonObject', c.yellow, c.none, no)
-- Objective-C
Group.new('objcTypeModifier', c.red, c.none, no)
Group.new('objcDirective', c.blue, c.none, no)
-- PureScript
Group.new('purescriptModuleKeyword', c.cyan, c.none, no)
Group.new('purescriptModuleName', c.red_1, c.none, b)
Group.new('purescriptWhere', c.cyan, c.none, no)
Group.new('purescriptDelimiter', c.fg_3, c.none, no)
Group.new('purescriptType', g.Type, g.Type, g.Type)
Group.new('purescriptImportKeyword', g.Keyword, g.Keyword, g.Keyword)
Group.new('purescriptHidingKeyword', g.Keyword, g.Keyword, g.Keyword)
Group.new('purescriptAsKeyword', g.Keyword, g.Keyword, g.Keyword)
Group.new('purescriptStructure', g.Structure, g.Structure, g.Structure)
Group.new('purescriptOperator', g.Operator, g.Operator, g.Operator)
Group.new('purescriptTypeVar', g.Type, g.Type, g.Type)
Group.new('purescriptConstructor', g.Function, g.Function, g.Function)
Group.new('purescriptFunction', g.Function, g.Function, g.Function)
Group.new('purescriptConditional', g.Conditional, g.Conditional, g.Conditional)
Group.new('purescriptBacktick', c.yellow, c.none, no)
-- Python
Group.new('pythonCoding', g.Comment, g.Comment, g.Comment)
-- Ruby
Group.new('rubyStringDelimiter', c.green, c.none, no)
Group.new('rubyInterpolationDelimiter', c.cyan, c.none, no)
-- Rust
Group.new('rustSelf', c.blue, c.none, b)
Group.new('rustPanic', c.red_1, c.none, b)
Group.new('rustAssert', c.blue_1, c.none, b)
-- Scala
Group.new('scalaNameDefinition', c.fg_1, c.none, no)
Group.new('scalaCaseFollowing', c.fg_1, c.none, no)
Group.new('scalaCapitalWord', c.fg_1, c.none, no)
Group.new('scalaTypeExtension', c.fg_1, c.none, no)
Group.new('scalaKeyword', c.red_1, c.none, b)
Group.new('scalaKeywordModifier', c.red1, c.none, no)
Group.new('scalaSpecial', c.cyan, c.none, no)
Group.new('scalaOperator', c.fg_1, c.none, no)
Group.new('scalaTypeDeclaration', c.yellow, c.none, no)
Group.new('scalaTypeTypePostDeclaration', c.yellow, c.none, no)
Group.new('scalaInstanceDeclaration', c.fg_1, c.none, no)
Group.new('scalaInterpolation', c.cyan, c.none, no)
-- TypeScript
Group.new('typeScriptReserved', c.cyan, c.none, no)
Group.new('typeScriptLabel', g.Label, g.Label, g.Label)
Group.new('typeScriptFuncKeyword', g.Function, g.Function, g.Function)
Group.new('typeScriptIdentifier', g.Identifier, g.Identifier, g.Identifier)
Group.new('typeScriptBraces', c.red_1, c.none, no)
Group.new('typeScriptEndColons', c.fg_1, c.none, no)
Group.new('typeScriptDOMObjects', c.fg_1, c.none, no)
Group.new('typeScriptAjaxMethods', g.Function, g.Function, g.Function)
Group.new('typeScriptLogicSymbols', c.fg_1, c.none, no)
Group.new('typeScriptDocSeeTag', g.Comment, g.Comment, g.Comment)
Group.new('typeScriptDocParam', g.Comment, g.Comment, g.Comment)
Group.new('typeScriptDocTags', g.vimCommentTitle, g.vimCommentTitle, g.vimCommentTitle)
Group.new('typeScriptGlobalObjects', g.Keyword, g.Keyword, g.Keyword)
Group.new('typeScriptParens', c.blue_1, c.none, no)
Group.new('typeScriptOpSymbols', g.Operator, g.Operator, g.Operator)
Group.new('typeScriptHtmlElemProperties', g.Special, g.Special, g.Special)
Group.new('typeScriptNull', c.purple, c.none, b)
Group.new('typeScriptInterpolationDelimiter', c.cyan, c.none, no)
-- XML
Group.new('xmlTag', c.blue, c.none, no)
Group.new('xmlEndTag', c.blue, c.none, no)
Group.new('xmlTagName', c.blue, c.none, no)
Group.new('xmlEqual', c.blue, c.none, no)
Group.new('docbkKeyword', c.cyan, c.none, b)
Group.new('xmlDocTypeDecl', c.fg_3, c.none, no)
Group.new('xmlDocTypeKeyword', c.purple, c.none, no)
Group.new('xmlCdataStart', c.fg_3, c.none, no)
Group.new('xmlCdataCdata', c.purple, c.none, no)
Group.new('xmlAttrib', c.cyan, c.none, no)
Group.new('xmlProcessingDelim', c.fg_3, c.none, no)
Group.new('xmlAttribPunct', c.fg_3, c.none, no)
Group.new('xmlEntity', c.yellow, c.none, no)
Group.new('xmlEntityPunct', c.yellow, c.none, no)
-- Vim
Group.new('vimCommentTitle', c.blue_1, c.none, b)
Group.new('vimNotation', c.yellow, c.none, no)
Group.new('vimBracket', c.yellow, c.none, no)
Group.new('vimMapModKey', c.yellow, c.none, no)
Group.new('vimCommand', c.blue, c.none, i)
Group.new('vimLet', c.blue, c.none, i)
Group.new('vimNorm', c.blue, c.none, b)
Group.new('vimFuncSID', g.Function, g.Function, g.Function)
Group.new('vimFunction', g.Function, g.Function, g.Function)
Group.new('vimGroup', c.blue1, c.none, no)
Group.new('vimHiGroup', g.Type, g.Type, g.Type)
Group.new('vimSetSep', c.fg_3, c.none, no)
Group.new('vimSep', c.fg_3, c.none, no)
Group.new('vimContinue', c.yellow, c.none, no)

-------------------------
-- Plugin Highlighting --
-------------------------

-- ALE (dense-analysis/ale)
Group.new('ALEError', c.fg, c.none, uc)
Group.new('ALEWarning', c.fg, c.none, uc)
Group.new('ALEInfo', c.fg, c.none, uc)
Group.new('ALEErrorSign', c.red, c.none, no)
Group.new('ALEWarningSign', c.yellow, c.none, no)
Group.new('ALEInfoSign', c.blue, c.none, no)
-- Buftabline (ap/vim-buftabline)
Group.new('BufTabLineCurrent', c.none, c.fg_3, no)
Group.new('BufTabLineActive', c.fg_3, c.bg_2, no)
Group.new('BufTabLineHidden', c.purple, c.bg_1, no)
Group.new('BufTabLineFill', c.none, c.none, no)
-- Crates (mhinz/vim-crates)
Group.new('Crate', g.Comment, g.Comment, g.Comment)
-- CTRL P (ctrlpvim/ctrlp.vim)
Group.new('CtrlPMatch', c.yellow, c.none, no)
Group.new('CtrlPNoEntries', c.red, c.none, no)
Group.new('CtrlPPrtBase', c.bg_2, c.none, no)
Group.new('CtrlPPrtCursor', c.blue, c.none, no)
Group.new('CtrlPLinePre', c.bg_2, c.none, no)
Group.new('CtrlPMode1', c.blue, c.bg_2, b)
Group.new('CtrlPMode2', c.none, c.blue, b)
Group.new('CtrlPStats', c.fg_3, c.bg_2, b)
-- Current Word (dominikduda/vim_current_word)
Group.new('CurrentWord', c.fg, c.purple, ul)
Group.new('CurrentWordTwins', c.fg, c.purple, no)
-- Dirvish (justinmk/vim-dirvish)
Group.new('DirvishPathTail', c.cyan, c.none, no)
Group.new('DirvishArg', c.yellow, c.none, no)
-- Easy Motion (easymotion/vim-easymotion)
Group.new('EasyMotionTarget', g.Search, g.Search, g.Search)
Group.new('EasyMotionShade', g.Comment, g.Comment, g.Comment)
-- Git Commit (tpope/vim-git)
Group.new('gitcommitSelectedFile', c.green, c.none, no)
Group.new('gitcommitDiscardedFile', c.red, c.none, no)
-- Gitgutter (airblade/vim-gitgutter)
Group.new('GitGutterAdd', c.green, c.none, b)
Group.new('GitGutterChange', c.yellow, c.none, b)
Group.new('GitGutterDelete', c.red, c.none, b)
Group.new('GitGutterChangeDelete', c.red_1, c.none, b)
-- Git Messenger (rhysd/git-messenger.vim)
Group.new('gitmessengerPopupNormal', g.CursorLine, g.CursorLine, g.CursorLine) -- Normal color in popup window
Group.new('gitmessengerHeader', g.CursorLine, g.CursorLine, g.CursorLine) -- Header such as 'Commit:', 'Author:'
Group.new('gitmessengerHash', g.CursorLine, g.CursorLine, g.CursorLine) -- Commit hash at 'Commit:' header
Group.new('gitmessengerHistory', g.CursorLine, g.CursorLine, g.CursorLine) -- History number at 'History:' header
-- Indent Guide (nathanaelkane/vim-indent-guides)
Group.new('IndentGuidesOdd', c.none, c.bg_2, r)
Group.new('IndentGuidesEven', c.none, c.bg_1, r)
-- Multi Cursors (mg979/vim-visual-multi)
Group.new('multiple_cursors_cursor', c.fg, c.none, r)
Group.new('multiple_cursors_visual', c.fg, c.bg_2, no)
-- NerdTree (preservim/nerdtree)
Group.new('NERDTreeDir', c.blue, c.none, b)
Group.new('NERDTreeDirSlash', c.blue, c.none, no)
Group.new('NERDTreeOpenable', c.blue, c.none, no)
Group.new('NERDTreeClosable', c.blue, c.none, no)
Group.new('NERDTreeFile', c.fg_1, c.none, no)
Group.new('NERDTreeExecFile', c.yellow, c.none, no)
Group.new('NERDTreeUp', c.red_1, c.none, no)
Group.new('NERDTreeCWD', c.purple, c.none, no)
Group.new('NERDTreeHelp', c.fg_1, c.none, no)
Group.new('NERDTreeToggleOn', c.green, c.none, no)
Group.new('NERDTreeToggleOff', c.red, c.none, no)
-- Netrw (vim builtin)
Group.new('netrwDir', c.blue, c.none, no)
Group.new('netrwClassify', c.blue, c.none, no)
Group.new('netrwLink', c.fg_3, c.none, no)
Group.new('netrwSymLink', c.fg_1, c.none, no)
Group.new('netrwExe', c.yellow, c.none, no)
Group.new('netrwComment', c.fg_3, c.none, no)
Group.new('netrwList', c.blue, c.none, no)
Group.new('netrwHelpCmd', c.cyan, c.none, no)
Group.new('netrwCmdSep', c.fg_3, c.none, no)
Group.new('netrwVersion', c.green, c.none, no)
-- Show Marks (jacquesbh/vim-showmarks) -- Created by Andreas Politz
Group.new('ShowMarksHLl', c.blue, c.none, b)
Group.new('ShowMarksHLu', c.blue, c.none, b)
Group.new('ShowMarksHLo', c.blue, c.none, b)
Group.new('ShowMarksHLm', c.blue, c.none, b)
-- Signature (kshenoy/vim-signature)
Group.new('SignatureMarkText', c.blue, c.none, b)
Group.new('SignatureMarkerText', c.purple, c.none, b)
-- Signify (mhinz/vim-signify)
Group.new('SignifySignAdd', c.green, c.none, no)
Group.new('SignifySignChange', c.yellow, c.none, no)
Group.new('SignifySignDelete', c.red, c.none, no)
-- Startify (mhinz/vim-startify)
Group.new('StartifyBracket', c.fg_3, c.none, no)
Group.new('StartifyFile', c.fg_1, c.none, no)
Group.new('StartifyNumber', c.blue, c.none, no)
Group.new('StartifyPath', c.blue1, c.none, b)
Group.new('StartifySlash', c.blue, c.none, no)
Group.new('StartifySection', c.blue, c.none, b)
Group.new('StartifySpecial', g.Type, g.Type, g.Type)
Group.new('StartifyHeader', c.purple, c.none, no)
Group.new('StartifyFooter', c.purple, c.none, no)
-- Syntastic (vim-syntastic/syntastic)
Group.new('SyntasticError', c.fg, c.none, uc)
Group.new('SyntasticWarning', c.fg, c.none, uc)
Group.new('SyntasticErrorSign', c.red, c.none, no)
Group.new('SyntasticWarningSign', c.yellow, c.none, no)
-- Which Key (liuchengxu/vim-which-key)
Group.new('WhichKey', g.Function, g.Function, g.Function)
Group.new('WhichKeySeperator', c.green, c.none, no)
Group.new('WhichKeyGroup', g.Keyword, g.Keyword, g.Keyword)
Group.new('WhichKeyDesc', g.Identifier, g.Identifier, g.Identifier)

---------------------
-- Neovim Builtins --
---------------------

-- +- Neovim Support -+
Group.new('healthError', g.Error, g.Error, g.Error)
Group.new('healthSuccess',c.blue, c.none, no)
Group.new('healthWarning',g.Warnings, g.Warnings, g.Warnings)
Group.new('TermCursorNC',c.fg, c.none, b + r)

-- LSP Groups (descriptions and ordering from `:h lsp-highlight`)
Group.new('LspDiagnosticsError', g.Error, g.Error, g.Error) -- used for "Error" diagnostic virtual text
Group.new('LspDiagnosticsErrorSign', g.Error, g.Error, g.Error) -- used for "Error" diagnostic signs in sign column
Group.new('LspDiagnosticsErrorFloating', g.Error, g.Error, g.Error) -- used for "Error" diagnostic messages in the diagnostics float
Group.new('LspDiagnosticsWarning', g.Warnings, g.Warnings, g.Warnings) -- used for "Warning" diagnostic virtual text
Group.new('LspDiagnosticsWarningSign', g.Warnings, g.Warnings, g.Warnings) -- used for "Warning" diagnostic signs in sign column
Group.new('LspDiagnosticsWarningFloating', g.Warnings, g.Warnings, g.Warnings) -- used for "Warning" diagnostic messages in the diagnostics float
Group.new('LSPDiagnosticsInformation', c.blue, c.none, no) -- used for "Information" diagnostic virtual text
Group.new('LspDiagnosticsInformationSign', c.blue, c.none, no)  -- used for "Information" diagnostic signs in sign column
Group.new('LspDiagnosticsInformationFloating', c.blue, c.none, no) -- used for "Information" diagnostic messages in the diagnostics float
Group.new('LspDiagnosticsHint', c.cyan, c.none, no)  -- used for "Hint" diagnostic virtual text
Group.new('LspDiagnosticsHintSign', c.cyan, c.none, no) -- used for "Hint" diagnostic signs in sign column
Group.new('LspDiagnosticsHintFloating', c.cyan, c.none, no) -- used for "Hint" diagnostic messages in the diagnostics float
Group.new('LspReferenceText', c.fg_3, c.none, no) -- used for highlighting "text" references
Group.new('LspReferenceRead', c.fg_3, c.none, no) -- used for highlighting "read" references
Group.new('LspReferenceWrite', c.fg_3, c.none, no) -- used for highlighting "write" references

-- Nvim Treesitter Groups (descriptions and ordering from `:h nvim-treesitter-highlights`)
Group.new('TSError', g.Error, g.Error, g.Error) -- For syntax/parser errors
Group.new('TSPunctDelimiter', g.Delimiter, g.Delimiter, g.Delimiter) -- For delimiters ie: `.
Group.new('TSPunctBracket', c.red, nil) -- For brackets and parens
Group.new('TSPunctSpecial', c.fg , nil) -- For special punctutation that does not fall in the catagories before
Group.new('TSConstant', g.Constant, g.Constant, g.Constant) -- For constants
Group.new('TSConstBuiltin', g.Constant, g.Constant, g.Constant) -- For constant that are built in the language: `nil` in Lua
Group.new('TSConstMacro', g.Constant, g.Constant, g.Constant) -- For constants that are defined by macros: `NULL` in C
Group.new('TSString', g.String, g.String, g.String) -- For strings
Group.new('TSStringRegex', c.green_1 , nil) -- For regexes
Group.new('TSStringEscape', c.yellow , nil) -- For escape characters within a string
Group.new('TSCharacter', g.Character, g.Character, g.Character) -- For characters
Group.new('TSNumber', g.Number, g.Number, g.Number) -- For integers
Group.new('TSBoolean', g.Boolean, g.Boolean, g.Boolean) -- For booleans
Group.new('TSFloat', g.Float, g.Float, g.Float) -- For floats
Group.new('TSFunction', g.Function, g.Function, g.Function) -- For function (calls and definitions
Group.new('TSFuncBuiltin', g.Function, g.Function, g.Function) -- For builtin functions: `table.insert` in Lua
Group.new('TSFuncMacro', g.Function, g.Function, g.Function) -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
Group.new('TSParameter', c.cyan, c.none, no) -- For parameters of a function.
Group.new('TSParameterReference', g.TSParameter,  g.TSParameter, g.TSParameter) -- For references to parameters of a function.
Group.new('TSMethod', g.Function, g.Function, g.Function) -- For method calls and definitions.
Group.new('TSField', c.fg, c.none) -- For fields.
Group.new('TSProperty', g.TSField,  g.TSField, g.TSField) -- Same as `TSField`.
Group.new('TSConstructor', c.purple, nil)  -- For constructor calls and definitions: `{}` in Lua, and Java constructors
Group.new('TSConditional', g.Conditional, g.Conditional, g.Conditional) -- For keywords related to conditionnals
Group.new('TSRepeat', g.Repeat, g.Repeat, g.Repeat) -- For keywords related to loops
Group.new('TSLabel', g.Label, g.Label, g.Label) -- For labels: `label:` in C and `:label:` in Lua
Group.new('TSOperator', g.Operator,  g.Operator, g.Operator) -- For any operator: `+`, but also `->` and `*` in C
Group.new('TSKeyword', g.Keyword, g.Keyword, g.Keyword) -- For keywords that don't fall in previous categories.
Group.new('TSKeywordFunction', c.red, c.none, no) -- For keywords used to define a fuction.
Group.new('TSException', g.Exception, g.Exception, g.Exception) -- For exception related keywords.
Group.new('TSType', g.Type, g.Type, g.Type) -- For types.
Group.new('TSTypeBuiltin', g.Type, g.Type, g.Type) -- For builtin types (you guessed it, right ?).
Group.new('TSStructure', g.Structure, g.Structure, g.Structure) -- This is left as an exercise for the reader.
Group.new('TSInclude', g.Include, g.Include, g.Include) -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
Group.new('TSAnnotation', c.blue, c.none, no) -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
Group.new('TSText', c.fg, c.none, b) -- For strings considered text in a markup language.
Group.new('TSStrong', c.fg, c.none, b) -- For text to be represented with strong.
Group.new('TSEmphasis', c.blue, c.none, i) -- For text to be represented with emphasis.
Group.new('TSUnderline', c.blue, c.none, b) -- TSUnderline
Group.new('TSTitle', c.red, c.none, b) -- Text that is part of a title.
Group.new('TSLiteral', c.cyan, c.none, b) -- Literal text.
Group.new('TSURI', c.blue, c.none, ul) -- Any URI like a link or email.
Group.new('TSVariable', c.fg, c.none, no) -- Variable names
Group.new('TSVariableBuiltin', c.purple, c.none, no) -- Variable names that are defined by the languages, like `this` or `self`.
