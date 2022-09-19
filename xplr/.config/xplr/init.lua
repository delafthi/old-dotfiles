---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
---@diagnostic enable

version = "0.19.0"

-- General Configuration
-- ~~~~~~~~~~~~~~~~~~~~~
xplr.config.general.show_hidden = true
xplr.config.general.prompt.format = " "
xplr.config.general.prompt.style = {}
xplr.config.general.logs.info.style = { fg = "White" }
xplr.config.general.logs.success.format = "SUCCESS"
xplr.config.general.logs.success.style = { fg = "Green" }
xplr.config.general.logs.warning.format = "WARNING"
xplr.config.general.logs.warning.style = { fg = "Yellow" }
xplr.config.general.logs.error.format = "ERROR"
xplr.config.general.logs.error.style = { fg = "Red" }
xplr.config.general.table.header.cols = {
  { format = "index", style = { fg = "DarkGray" } },
  { format = "path", style = {} },
  { format = "permissions", style = {} },
  { format = "size", style = {} },
  { format = "modified", style = {} },
}
xplr.config.general.table.header.style =
  { fg = "White", add_modifiers = { "Bold" } }
xplr.config.general.table.header.height = 1
xplr.config.general.table.row.cols = {
  {
    format = "builtin.fmt_general_table_row_cols_0",
    style = { fg = "DarkGray", sub_modifiers = { "Bold" } },
  },
  {
    format = "builtin.fmt_general_table_row_cols_1",
    style = {},
  },
  {
    format = "builtin.fmt_general_table_row_cols_2",
    style = {},
  },
  {
    format = "builtin.fmt_general_table_row_cols_3",
    style = {},
  },
  {
    format = "builtin.fmt_general_table_row_cols_4",
    style = {},
  },
}
xplr.config.general.table.tree = {
  { format = "", style = {} },
  { format = "", style = {} },
  { format = "", style = {} },
}
xplr.config.general.table.col_spacing = 1
xplr.config.general.table.col_widths = {
  { Length = 5 },
  { Percentage = 50 },
  { Percentage = 10 },
  { Percentage = 10 },
  { Percentage = 20 },
}
xplr.config.general.default_ui.prefix = "  "
xplr.config.general.default_ui.suffix = ""
xplr.config.general.default_ui.style = { fg = "White" }
xplr.config.general.focus_ui.prefix = " "
xplr.config.general.focus_ui.suffix = ""
xplr.config.general.focus_ui.style = { add_modifiers = { "Bold" } }
xplr.config.general.selection_ui.prefix = " │"
xplr.config.general.selection_ui.suffix = ""
xplr.config.general.selection_ui.style = {
  add_modifiers = { "Bold" },
}
xplr.config.general.focus_selection_ui.prefix = "│"
xplr.config.general.focus_selection_ui.suffix = ""
xplr.config.general.focus_selection_ui.style = {
  add_modifiers = { "Bold" },
}
xplr.config.general.sort_and_filter_ui.separator.format = "% "
xplr.config.general.sort_and_filter_ui.separator.style = {
  add_modifiers = { "Dim" },
}
xplr.config.general.panel_ui.default.border_type = "Rounded"
xplr.config.general.panel_ui.default.border_style = { fg = "DarkGray" }
xplr.config.general.panel_ui.table.title.style = { fg = "Cyan" }
xplr.config.general.panel_ui.table.border_style = { fg = "Cyan" }
xplr.config.general.panel_ui.help_menu.title.style = { fg = "Magenta" }
xplr.config.general.panel_ui.help_menu.border_style = { fg = "Magenta" }
xplr.config.general.panel_ui.input_and_logs.title.style = { fg = "DarkGray" }
xplr.config.general.panel_ui.input_and_logs.border_style = { fg = "DarkGray" }
xplr.config.general.panel_ui.selection.title.style = { fg = "Blue" }
xplr.config.general.panel_ui.selection.border_style = { fg = "Blue" }
xplr.config.general.panel_ui.sort_and_filter.title.style = { fg = "Magenta" }
xplr.config.general.panel_ui.sort_and_filter.border_style = { fg = "Magenta" }
xplr.config.general.initial_sorting = {
  { sorter = "ByCanonicalIsDir", reverse = true },
  { sorter = "ByIRelativePath", reverse = false },
}
xplr.config.general.initial_layout = "default"
xplr.config.general.global_key_bindings = {
  on_key = {
    esc = {
      messages = {
        "PopMode",
      },
    },
    ["ctrl-c"] = {
      messages = {
        "Terminate",
      },
    },
  },
}

-- Node Types
-- ~~~~~~~~~~
xplr.config.node_types.directory.style = {
  fg = "Blue",
  add_modifiers = { "Bold" },
}
xplr.config.node_types.directory.meta.icon = " "
xplr.config.node_types.file.style = {}
xplr.config.node_types.file.meta.icon = " "
xplr.config.node_types.symlink.style = {
  fg = "Cyan",
}
xplr.config.node_types.symlink.meta.icon = " "
xplr.config.node_types.mime_essence = {}
xplr.config.node_types.extension = {}
xplr.config.node_types.special = {}

-- Layouts
-- ~~~~~~~
xplr.config.layouts.builtin.default = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 70 },
        { Percentage = 30 },
      },
    },
    splits = {
      {
        Vertical = {
          config = {
            constraints = {
              { Length = 3 },
              { Min = 1 },
              { Length = 3 },
            },
          },
          splits = {
            "SortAndFilter",
            "Table",
            "InputAndLogs",
          },
        },
      },
      {
        Vertical = {
          config = {
            constraints = {
              { Percentage = 50 },
              { Percentage = 50 },
            },
          },
          splits = {
            "Selection",
            "HelpMenu",
          },
        },
      },
    },
  },
}
xplr.config.layouts.builtin.no_help = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 70 },
        { Percentage = 30 },
      },
    },
    splits = {
      {
        Vertical = {
          config = {
            constraints = {
              { Length = 3 },
              { Min = 1 },
              { Length = 3 },
            },
          },
          splits = {
            "SortAndFilter",
            "Table",
            "InputAndLogs",
          },
        },
      },
      "Selection",
    },
  },
}
xplr.config.layouts.builtin.no_selection = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 70 },
        { Percentage = 30 },
      },
    },
    splits = {
      {
        Vertical = {
          config = {
            constraints = {
              { Length = 3 },
              { Min = 1 },
              { Length = 3 },
            },
          },
          splits = {
            "SortAndFilter",
            "Table",
            "InputAndLogs",
          },
        },
      },
      "HelpMenu",
    },
  },
}
xplr.config.layouts.builtin.no_help_no_selection = {
  Vertical = {
    config = {
      constraints = {
        { Length = 3 },
        { Min = 1 },
        { Length = 3 },
      },
    },
    splits = {
      "SortAndFilter",
      "Table",
      "InputAndLogs",
    },
  },
}
xplr.config.layouts.custom = {}

-- Modes
-- ~~~~~
xplr.config.modes.builtin.default = {
  name = "default",
  key_bindings = {
    on_key = {
      ["#"] = {
        messages = {
          "PrintAppStateAndQuit",
        },
      },
      ["."] = {
        help = "show hidden",
        messages = {
          {
            ToggleNodeFilter = {
              filter = "RelativePathDoesNotStartWith",
              input = ".",
            },
          },
          "ExplorePwdAsync",
        },
      },
      [":"] = {
        help = "action",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "action" },
        },
      },
      ["?"] = {
        help = "global help menu",
        messages = {
          {
            BashExec = [===[
              [ -z "$PAGER" ] && PAGER="less -+F"
              cat -- "${XPLR_PIPE_GLOBAL_HELP_MENU_OUT}" | ${PAGER:?}
            ]===],
          },
        },
      },
      ["G"] = {
        help = "go to bottom",
        messages = {
          "PopMode",
          "FocusLast",
        },
      },
      ["ctrl-a"] = {
        help = "select/unselect all",
        messages = {
          "ToggleSelectAll",
        },
      },
      ["ctrl-f"] = {
        help = "search",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "search" },
          { SetInputPrompt = "/" },
          { SetInputBuffer = "(?i)" },
          "ExplorePwdAsync",
        },
      },
      ["ctrl-i"] = {
        help = "next visited path",
        messages = {
          "NextVisitedPath",
        },
      },
      ["ctrl-o"] = {
        help = "last visited path",
        messages = {
          "LastVisitedPath",
        },
      },
      ["ctrl-r"] = {
        help = "refresh screen",
        messages = {
          "ClearScreen",
        },
      },
      ["ctrl-u"] = {
        help = "clear selection",
        messages = {
          "ClearSelection",
        },
      },
      ["ctrl-w"] = {
        help = "switch layout",
        messages = {
          { SwitchModeBuiltin = "switch_layout" },
        },
      },
      ["d"] = {
        help = "delete",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "delete" },
        },
      },
      down = {
        help = "down",
        messages = {
          "FocusNext",
        },
      },
      enter = {
        help = "quit with result",
        messages = {
          "PrintResultAndQuit",
        },
      },
      ["f"] = {
        help = "filter",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "filter" },
        },
      },
      ["g"] = {
        help = "go to",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "go_to" },
        },
      },
      left = {
        help = "back",
        messages = {
          "Back",
        },
      },
      ["q"] = {
        help = "quit",
        messages = {
          "Quit",
        },
      },
      ["r"] = {
        help = "rename",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "rename" },
          {
            BashExecSilently = [===[
              NAME=$(basename "${XPLR_FOCUS_PATH:?}")
              echo SetInputBuffer: "'"${NAME:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
            ]===],
          },
        },
      },
      ["ctrl-d"] = {
        help = "duplicate as",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "duplicate_as" },
          {
            BashExecSilently = [===[
              NAME=$(basename "${XPLR_FOCUS_PATH:?}")
              echo SetInputBuffer: "'"${NAME:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
            ]===],
          },
        },
      },
      right = {
        help = "enter",
        messages = {
          "Enter",
        },
      },
      ["s"] = {
        help = "sort",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "sort" },
        },
      },
      space = {
        help = "toggle selection",
        messages = {
          "ToggleSelection",
          "FocusNext",
        },
      },
      up = {
        help = "up",
        messages = {
          "FocusPrevious",
        },
      },
      ["~"] = {
        help = "go home",
        messages = {
          {
            BashExecSilently = [===[
              echo ChangeDirectory: "'"${HOME:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
            ]===],
          },
        },
      },
    },
    on_number = {
      help = "input",
      messages = {
        "PopMode",
        { SwitchModeBuiltin = "number" },
        { SetInputPrompt = ":" },
        "BufferInputFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.default.key_bindings.on_key["tab"] =
  xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-i"]
xplr.config.modes.builtin.default.key_bindings.on_key["v"] =
  xplr.config.modes.builtin.default.key_bindings.on_key.space
xplr.config.modes.builtin.default.key_bindings.on_key["V"] =
  xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-a"]
xplr.config.modes.builtin.default.key_bindings.on_key["/"] =
  xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-f"]
xplr.config.modes.builtin.default.key_bindings.on_key["h"] =
  xplr.config.modes.builtin.default.key_bindings.on_key.left
xplr.config.modes.builtin.default.key_bindings.on_key["j"] =
  xplr.config.modes.builtin.default.key_bindings.on_key.down
xplr.config.modes.builtin.default.key_bindings.on_key["k"] =
  xplr.config.modes.builtin.default.key_bindings.on_key.up
xplr.config.modes.builtin.default.key_bindings.on_key["l"] =
  xplr.config.modes.builtin.default.key_bindings.on_key.right
xplr.config.modes.builtin.debug_error = {
  name = "debug error",
  layout = {
    Vertical = {
      config = {
        constraints = {
          { Min = 14 },
          { MinLessThanScreenHeight = 14 },
        },
      },
      splits = {
        {
          CustomContent = {
            title = "debug error",
            body = {
              StaticParagraph = {
                render = [[

  Some errors occurred during startup.
  If you think this is a bug, please report it at:

  https://github.com/sayanarijit/xplr/issues/new

  Press `enter` to open the logs in your $EDITOR.
  Press `escape` to ignore the errors and continue with the default config.

  To disable this mode, set `xplr.config.general.disable_debug_error_mode`
  to `true` in your config file.
                ]],
              },
            },
          },
        },
        "InputAndLogs",
      },
    },
  },
  key_bindings = {
    on_key = {
      enter = {
        help = "open logs in editor",
        messages = {
          {
            BashExec = [===[
              ${EDITOR:-vi} "${XPLR_PIPE_LOGS_OUT:?}"
            ]===],
          },
        },
      },
      q = {
        help = "quit",
        messages = {
          "Quit",
        },
      },
    },
    default = {
      messages = {},
    },
  },
}
xplr.config.modes.builtin.recover = {
  name = "recover",
  layout = {
    CustomContent = {
      title = " recover ",
      body = {
        StaticParagraph = {
          render = [[

  You pressed an invalid key and went into "recover" mode.
  This mode saves you from performing unwanted actions.

  Let's calm down, press `escape`, and try again.

  To disable this mode, set `xplr.config.general.enable_recover_mode`
  to `false` in your config file.
          ]],
        },
      },
    },
  },
  key_bindings = {
    default = {
      messages = {},
    },
  },
}
xplr.config.modes.builtin.go_to_path = {
  name = "go to path",
  key_bindings = {
    on_key = {
      enter = {
        help = "submit",
        messages = {
          {
            BashExecSilently = [===[
              if [ -d "$XPLR_INPUT_BUFFER" ]; then
                echo ChangeDirectory: "'"$XPLR_INPUT_BUFFER"'" >> "${XPLR_PIPE_MSG_IN:?}"
              elif [ -e "$XPLR_INPUT_BUFFER" ]; then
                echo FocusPath: "'"$XPLR_INPUT_BUFFER"'" >> "${XPLR_PIPE_MSG_IN:?}"
              fi
            ]===],
          },
          "PopMode",
        },
      },
      tab = {
        help = "try complete",
        messages = {
          { CallLuaSilently = "builtin.try_complete_path" },
        },
      },
    },
    default = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.selection_ops = {
  name = "selection ops",
  key_bindings = {
    on_key = {
      ["c"] = {
        help = "copy here",
        messages = {
          {
            BashExec = [===[
              (while IFS= read -r line; do
              if cp -vr -- "${line:?}" ./; then
                echo LogSuccess: $line copied to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
              else
                echo LogError: Failed to copy $line to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
              fi
              done < "${XPLR_PIPE_SELECTION_OUT:?}")
              echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
              echo ClearSelection >> "${XPLR_PIPE_MSG_IN:?}"
              read -p "[enter to continue]"
            ]===],
          },
          "PopMode",
        },
      },
      ["m"] = {
        help = "move here",
        messages = {
          {
            BashExec = [===[
              (while IFS= read -r line; do
              if mv -v -- "${line:?}" ./; then
                echo LogSuccess: $line moved to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
              else
                echo LogError: Failed to move $line to $PWD >> "${XPLR_PIPE_MSG_IN:?}"
              fi
              done < "${XPLR_PIPE_SELECTION_OUT:?}")
              echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
              read -p "[enter to continue]"
            ]===],
          },
          "PopMode",
        },
      },
      ["x"] = {
        help = "open in gui",
        messages = {
          {
            BashExecSilently = [===[
              if [ -z "$OPENER" ]; then
                if command -v xdg-open; then
                  OPENER=xdg-open
                  elif command -v open; then
                  OPENER=open
                else
                  echo 'LogError: $OPENER not found' >> "${XPLR_PIPE_MSG_IN:?}"
                  exit 1
                fi
              fi
              (while IFS= read -r line; do
              $OPENER "${line:?}" > /dev/null 2>&1
              done < "${XPLR_PIPE_RESULT_OUT:?}")
            ]===],
          },
          "ClearScreen",
          "PopMode",
        },
      },
    },
  },
}
xplr.config.modes.builtin.create = {
  name = "create",
  key_bindings = {
    on_key = {
      d = {
        help = "create directory",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "create_directory" },
          { SetInputPrompt = "ð ❯ " },
          { SetInputBuffer = "" },
        },
      },
      f = {
        help = "create file",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "create_file" },
          { SetInputPrompt = "ƒ ❯ " },
          { SetInputBuffer = "" },
        },
      },
    },
  },
}
xplr.config.modes.builtin.create_directory = {
  name = "create directory",
  key_bindings = {
    on_key = {
      tab = {
        help = "try complete",
        messages = {
          { CallLuaSilently = "builtin.try_complete_path" },
        },
      },
      enter = {
        help = "submit",
        messages = {
          {
            BashExecSilently = [===[
              PTH="$XPLR_INPUT_BUFFER"
              if [ "${PTH}" ]; then
                mkdir -p -- "${PTH:?}" \
                && echo "SetInputBuffer: ''" >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo LogSuccess: $PTH created >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo FocusPath: "'"$PTH"'" >> "${XPLR_PIPE_MSG_IN:?}"
              else
                echo PopMode >> "${XPLR_PIPE_MSG_IN:?}"
              fi
            ]===],
          },
        },
      },
    },
    default = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.create_file = {
  name = "create file",
  key_bindings = {
    on_key = {
      tab = {
        help = "try complete",
        messages = {
          { CallLuaSilently = "builtin.try_complete_path" },
        },
      },
      enter = {
        help = "submit",
        messages = {
          {
            BashExecSilently = [===[
              PTH="$XPLR_INPUT_BUFFER"
              if [ "$PTH" ]; then
                mkdir -p -- "$(dirname $PTH)" \
                && touch -- "$PTH" \
                && echo "SetInputBuffer: ''" >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo LogSuccess: $PTH created >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                && echo FocusPath: "'"$PTH"'" >> "${XPLR_PIPE_MSG_IN:?}"
              else
                echo PopMode >> "${XPLR_PIPE_MSG_IN:?}"
              fi
            ]===],
          },
        },
      },
    },
    default = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.number = {
  name = "number",
  key_bindings = {
    on_key = {
      down = {
        help = "to down",
        messages = {
          "FocusNextByRelativeIndexFromInput",
          "PopMode",
        },
      },
      enter = {
        help = "to index",
        messages = {
          "FocusByIndexFromInput",
          "PopMode",
        },
      },
      up = {
        help = "to up",
        messages = {
          "FocusPreviousByRelativeIndexFromInput",
          "PopMode",
        },
      },
    },
    on_navigation = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
    on_number = {
      help = "input",
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.number.key_bindings.on_key["j"] =
  xplr.config.modes.builtin.number.key_bindings.on_key.down
xplr.config.modes.builtin.number.key_bindings.on_key["k"] =
  xplr.config.modes.builtin.number.key_bindings.on_key.up
xplr.config.modes.builtin.go_to = {
  name = "go to",
  key_bindings = {
    on_key = {
      f = {
        help = "follow symlink",
        messages = {
          "FollowSymlink",
          "PopMode",
        },
      },
      g = {
        help = "top",
        messages = {
          "FocusFirst",
          "PopMode",
        },
      },
      p = {
        help = "path",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "go_to_path" },
          { SetInputBuffer = "" },
        },
      },
      x = {
        help = "open in gui",
        messages = {
          {
            BashExecSilently = [===[
              if [ -z "$OPENER" ]; then
                if command -v xdg-open; then
                  OPENER=xdg-open
                  elif command -v open; then
                  OPENER=open
                else
                  echo 'LogError: $OPENER not found' >> "${XPLR_PIPE_MSG_IN:?}"
                  exit 1
                fi
              fi
              $OPENER "${XPLR_FOCUS_PATH:?}" > /dev/null 2>&1
            ]===],
          },
          "ClearScreen",
          "PopMode",
        },
      },
    },
  },
}
xplr.config.modes.builtin.rename = {
  name = "rename",
  key_bindings = {
    on_key = {
      tab = {
        help = "try complete",
        messages = {
          { CallLuaSilently = "builtin.try_complete_path" },
        },
      },
      enter = {
        help = "submit",
        messages = {
          {
            BashExecSilently = [===[
              SRC="${XPLR_FOCUS_PATH:?}"
              TARGET="${XPLR_INPUT_BUFFER:?}"
              if [ -e "${TARGET:?}" ]; then
                echo LogError: $TARGET already exists >> "${XPLR_PIPE_MSG_IN:?}"
              else
                mv -- "${SRC:?}" "${TARGET:?}" \
                  && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                  && echo FocusPath: "'"$TARGET"'" >> "${XPLR_PIPE_MSG_IN:?}" \
                  && echo LogSuccess: $SRC renamed to $TARGET >> "${XPLR_PIPE_MSG_IN:?}"
              fi
            ]===],
          },
          "PopMode",
        },
      },
    },
    default = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.duplicate_as = {
  name = "duplicate as",
  key_bindings = {
    on_key = {
      tab = {
        help = "try complete",
        messages = {
          { CallLuaSilently = "builtin.try_complete_path" },
        },
      },
      enter = {
        help = "submit",
        messages = {
          {
            BashExecSilently = [===[
              SRC="${XPLR_FOCUS_PATH:?}"
              TARGET="${XPLR_INPUT_BUFFER:?}"
              if [ -e "${TARGET:?}" ]; then
                echo LogError: $TARGET already exists >> "${XPLR_PIPE_MSG_IN:?}"
              else
                cp -r -- "${SRC:?}" "${TARGET:?}" \
                  && echo ExplorePwd >> "${XPLR_PIPE_MSG_IN:?}" \
                  && echo FocusPath: "'"$TARGET"'" >> "${XPLR_PIPE_MSG_IN:?}" \
                  && echo LogSuccess: $SRC duplicated as $TARGET >> "${XPLR_PIPE_MSG_IN:?}"
              fi
            ]===],
          },
          "PopMode",
        },
      },
    },
    default = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.delete = {
  name = "delete",
  key_bindings = {
    on_key = {
      ["D"] = {
        help = "force delete",
        messages = {
          {
            BashExec = [===[
              (while IFS= read -r line; do
              if rm -rfv -- "${line:?}"; then
                echo LogSuccess: $line deleted >> "${XPLR_PIPE_MSG_IN:?}"
              else
                echo LogError: Failed to delete $line >> "${XPLR_PIPE_MSG_IN:?}"
              fi
              done < "${XPLR_PIPE_RESULT_OUT:?}")
              echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
              read -p "[enter to continue]"
            ]===],
          },
          "PopMode",
        },
      },
      ["d"] = {
        help = "delete",
        messages = {
          {
            BashExec = [===[
              (while IFS= read -r line; do
              if [ -d "$line" ] && [ ! -L "$line" ]; then
                if rmdir -v -- "${line:?}"; then
                  echo LogSuccess: $line deleted >> "${XPLR_PIPE_MSG_IN:?}"
                else
                  echo LogError: Failed to delete $line >> "${XPLR_PIPE_MSG_IN:?}"
                fi
              else
                if rm -v -- "${line:?}"; then
                  echo LogSuccess: $line deleted >> "${XPLR_PIPE_MSG_IN:?}"
                else
                  echo LogError: Failed to delete $line >> "${XPLR_PIPE_MSG_IN:?}"
                fi
              fi
              done < "${XPLR_PIPE_RESULT_OUT:?}")
              echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
              read -p "[enter to continue]"
            ]===],
          },
          "PopMode",
        },
      },
    },
  },
}
xplr.config.modes.builtin.action = {
  name = "action to",
  key_bindings = {
    on_key = {
      ["!"] = {
        help = "shell",
        messages = {
          { Call = { command = "bash", args = { "-i" } } },
          "ExplorePwdAsync",
          "PopMode",
        },
      },
      ["c"] = {
        help = "create",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "create" },
        },
      },
      ["e"] = {
        help = "open in editor",
        messages = {
          {
            BashExec = [===[
              ${EDITOR:-vi} "${XPLR_FOCUS_PATH:?}"
            ]===],
          },
          "PopMode",
        },
      },
      ["l"] = {
        help = "logs",
        messages = {
          {
            BashExec = [===[
              [ -z "$PAGER" ] && PAGER="less -+F"
              cat -- "${XPLR_PIPE_LOGS_OUT}" | ${PAGER:?}
            ]===],
          },
          "PopMode",
        },
      },
      ["s"] = {
        help = "selection operations",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "selection_ops" },
        },
      },
      ["m"] = {
        help = "toggle mouse",
        messages = {
          "PopMode",
          "ToggleMouse",
        },
      },
      ["q"] = {
        help = "quit options",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "quit" },
        },
      },
    },
    on_number = {
      help = "go to index",
      messages = {
        "PopMode",
        { SwitchModeBuiltin = "number" },
        { SetInputPrompt = ":" },
        "BufferInputFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.quit = {
  name = "quit",
  key_bindings = {
    on_key = {
      enter = {
        help = "just quit",
        messages = {
          "Quit",
        },
      },
      p = {
        help = "quit printing pwd",
        messages = {
          "PrintPwdAndQuit",
        },
      },
      f = {
        help = "quit printing focus",
        messages = {
          "PrintFocusPathAndQuit",
        },
      },
      s = {
        help = "quit printing selection",
        messages = {
          "PrintSelectionAndQuit",
        },
      },
      r = {
        help = "quit printing result",
        messages = {
          "PrintResultAndQuit",
        },
      },
    },
  },
}
xplr.config.modes.builtin.search = {
  name = "search",
  key_bindings = {
    on_key = {
      down = {
        help = "down",
        messages = {
          "FocusNext",
        },
      },
      enter = {
        help = "submit",
        messages = {
          { RemoveNodeFilterFromInput = "RelativePathDoesMatchRegex" },
          "PopMode",
          "ExplorePwdAsync",
        },
      },
      right = {
        help = "enter",
        messages = {
          { RemoveNodeFilterFromInput = "RelativePathDoesMatchRegex" },
          "Enter",
          { SetInputBuffer = "(?i)" },
          "ExplorePwdAsync",
        },
      },
      left = {
        help = "back",
        messages = {
          { RemoveNodeFilterFromInput = "RelativePathDoesMatchRegex" },
          "Back",
          { SetInputBuffer = "(?i)" },
          "ExplorePwdAsync",
        },
      },
      tab = {
        help = "toggle selection",
        messages = {
          "ToggleSelection",
          "FocusNext",
        },
      },
      up = {
        help = "up",
        messages = {
          "FocusPrevious",
        },
      },
    },
    default = {
      messages = {
        { RemoveNodeFilterFromInput = "RelativePathDoesMatchRegex" },
        "UpdateInputBufferFromKey",
        { AddNodeFilterFromInput = "RelativePathDoesMatchRegex" },
        "ExplorePwdAsync",
      },
    },
  },
}
xplr.config.modes.builtin.search.key_bindings.on_key["esc"] =
  xplr.config.modes.builtin.search.key_bindings.on_key.enter
xplr.config.modes.builtin.search.key_bindings.on_key["ctrl-n"] =
  xplr.config.modes.builtin.search.key_bindings.on_key.down
xplr.config.modes.builtin.search.key_bindings.on_key["ctrl-p"] =
  xplr.config.modes.builtin.search.key_bindings.on_key.up
xplr.config.modes.builtin.filter = {
  name = "filter",
  key_bindings = {
    on_key = {
      ["r"] = {
        help = "relative path does match regex",
        messages = {
          { SwitchModeBuiltin = "relative_path_does_match_regex" },
          {
            SetInputPrompt = xplr.config.general.sort_and_filter_ui.filter_identifiers.RelativePathDoesMatchRegex.format,
          },
          { SetInputBuffer = "" },
          { AddNodeFilterFromInput = "RelativePathDoesMatchRegex" },
          "ExplorePwdAsync",
        },
      },
      ["R"] = {
        help = "relative path does not match regex",
        messages = {
          { SwitchModeBuiltin = "relative_path_does_not_match_regex" },
          {
            SetInputPrompt = xplr.config.general.sort_and_filter_ui.filter_identifiers.RelativePathDoesNotMatchRegex.format,
          },
          { SetInputBuffer = "" },
          { AddNodeFilterFromInput = "RelativePathDoesNotMatchRegex" },
          "ExplorePwdAsync",
        },
      },
      backspace = {
        help = "remove last filter",
        messages = {
          "RemoveLastNodeFilter",
          "ExplorePwdAsync",
        },
      },
      ["ctrl-r"] = {
        help = "reset filters",
        messages = {
          "ResetNodeFilters",
          "ExplorePwdAsync",
        },
      },
      ["ctrl-u"] = {
        help = "clear filters",
        messages = {
          "ClearNodeFilters",
          "ExplorePwdAsync",
        },
      },
    },
  },
}
xplr.config.modes.builtin.relative_path_does_match_regex = {
  name = "relative path does match regex",
  key_bindings = {
    on_key = {
      enter = {
        help = "submit",
        messages = {
          "PopMode",
        },
      },
      esc = {
        messages = {
          { RemoveNodeFilterFromInput = "RelativePathDoesMatchRegex" },
          "PopMode",
          "ExplorePwdAsync",
        },
      },
    },
    default = {
      messages = {
        { RemoveNodeFilterFromInput = "RelativePathDoesMatchRegex" },
        "UpdateInputBufferFromKey",
        { AddNodeFilterFromInput = "RelativePathDoesMatchRegex" },
        "ExplorePwdAsync",
      },
    },
  },
}
xplr.config.modes.builtin.relative_path_does_not_match_regex = {
  name = "relative path does not match regex",
  key_bindings = {
    on_key = {
      enter = {
        help = "submit",
        messages = {
          "PopMode",
        },
      },
      esc = {
        messages = {
          { RemoveNodeFilterFromInput = "RelativePathDoesNotMatchRegex" },
          "PopMode",
          "ExplorePwdAsync",
        },
      },
    },
    default = {
      messages = {
        { RemoveNodeFilterFromInput = "RelativePathDoesNotMatchRegex" },
        "UpdateInputBufferFromKey",
        { AddNodeFilterFromInput = "RelativePathDoesNotMatchRegex" },
        "ExplorePwdAsync",
      },
    },
  },
}
xplr.config.modes.builtin.sort = {
  name = "sort",
  key_bindings = {
    on_key = {
      ["!"] = {
        help = "reverse sorters",
        messages = {
          "ReverseNodeSorters",
          "ExplorePwdAsync",
        },
      },
      ["E"] = {
        help = "by canonical extension reverse",
        messages = {
          {
            AddNodeSorter = {
              sorter = "ByCanonicalExtension",
              reverse = true,
            },
          },
          "ExplorePwdAsync",
        },
      },
      ["M"] = {
        help = "by canonical mime essence reverse",
        messages = {
          {
            AddNodeSorter = {
              sorter = "ByCanonicalMimeEssence",
              reverse = true,
            },
          },
          "ExplorePwdAsync",
        },
      },
      ["N"] = {
        help = "by node type reverse",
        messages = {
          {
            AddNodeSorter = {
              sorter = "ByCanonicalIsDir",
              reverse = true,
            },
          },
          {
            AddNodeSorter = {
              sorter = "ByCanonicalIsFile",
              reverse = true,
            },
          },
          {
            AddNodeSorter = {
              sorter = "ByIsSymlink",
              reverse = true,
            },
          },
          "ExplorePwdAsync",
        },
      },
      ["R"] = {
        help = "by relative path reverse",
        messages = {
          {
            AddNodeSorter = {
              sorter = "ByIRelativePath",
              reverse = true,
            },
          },
          "ExplorePwdAsync",
        },
      },
      ["S"] = {
        help = "by size reverse",
        messages = {
          {
            AddNodeSorter = {
              sorter = "BySize",
              reverse = true,
            },
          },
          "ExplorePwdAsync",
        },
      },
      backspace = {
        help = "remove last sorter",
        messages = {
          "RemoveLastNodeSorter",
          "ExplorePwdAsync",
        },
      },
      ["ctrl-r"] = {
        help = "reset sorters",
        messages = {
          "ResetNodeSorters",
          "ExplorePwdAsync",
        },
      },
      ["ctrl-u"] = {
        help = "clear sorters",
        messages = {
          "ClearNodeSorters",
          "ExplorePwdAsync",
        },
      },
      ["e"] = {
        help = "by canonical extension",
        messages = {
          {
            AddNodeSorter = {
              sorter = "ByCanonicalExtension",
              reverse = false,
            },
          },
          "ExplorePwdAsync",
        },
      },
      enter = {
        help = "submit",
        messages = {
          "PopMode",
        },
      },
      ["m"] = {
        help = "by canonical mime essence",
        messages = {
          {
            AddNodeSorter = {
              sorter = "ByCanonicalMimeEssence",
              reverse = false,
            },
          },
          "ExplorePwdAsync",
        },
      },
      ["n"] = {
        help = "by node type",
        messages = {
          {
            AddNodeSorter = { sorter = "ByCanonicalIsDir", reverse = false },
          },
          {
            AddNodeSorter = { sorter = "ByCanonicalIsFile", reverse = false },
          },
          {
            AddNodeSorter = { sorter = "ByIsSymlink", reverse = false },
          },
          "ExplorePwdAsync",
        },
      },
      ["r"] = {
        help = "by relative path",
        messages = {
          { AddNodeSorter = { sorter = "ByIRelativePath", reverse = false } },
          "ExplorePwdAsync",
        },
      },
      ["s"] = {
        help = "by size",
        messages = {
          { AddNodeSorter = { sorter = "BySize", reverse = false } },
          "ExplorePwdAsync",
        },
      },

      ["c"] = {
        help = "by created",
        messages = {
          { AddNodeSorter = { sorter = "ByCreated", reverse = false } },
          "ExplorePwdAsync",
        },
      },

      ["C"] = {
        help = "by created reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByCreated", reverse = true } },
          "ExplorePwdAsync",
        },
      },

      ["l"] = {
        help = "by last modified",
        messages = {
          { AddNodeSorter = { sorter = "ByLastModified", reverse = false } },
          "ExplorePwdAsync",
        },
      },

      ["L"] = {
        help = "by last modified reverse",
        messages = {
          { AddNodeSorter = { sorter = "ByLastModified", reverse = true } },
          "ExplorePwdAsync",
        },
      },
    },
  },
}
xplr.config.modes.builtin.switch_layout = {
  name = "switch layout",
  key_bindings = {
    on_key = {
      ["1"] = {
        help = "default",
        messages = {
          { SwitchLayoutBuiltin = "default" },
          "PopMode",
        },
      },
      ["2"] = {
        help = "no help menu",
        messages = {
          { SwitchLayoutBuiltin = "no_help" },
          "PopMode",
        },
      },
      ["3"] = {
        help = "no selection panel",
        messages = {
          { SwitchLayoutBuiltin = "no_selection" },
          "PopMode",
        },
      },
      ["4"] = {
        help = "no help or selection",
        messages = {
          { SwitchLayoutBuiltin = "no_help_no_selection" },
          "PopMode",
        },
      },
    },
  },
}
xplr.config.modes.custom = {}

-- Function
-- ~~~~~~~~
xplr.fn.builtin.try_complete_path = function(m)
  if not m.input_buffer then
    return
  end

  local function splitlines(str)
    local res = {}
    for s in str:gmatch("[^\r\n]+") do
      table.insert(res, s)
    end
    return res
  end

  local function matches_all(str, files)
    for _, p in ipairs(files) do
      if string.sub(p, 1, #str) ~= str then
        return false
      end
    end
    return true
  end

  local path = m.input_buffer

  local p = assert(io.popen(string.format("ls -d %q* 2>/dev/null", path)))
  local out = p:read("*all")
  p:close()

  local found = splitlines(out)
  local count = #found

  if count == 0 then
    return
  elseif count == 1 then
    return {
      { SetInputBuffer = found[1] },
    }
  else
    local first = found[1]
    while #first > #path and matches_all(path, found) do
      path = string.sub(found[1], 1, #path + 1)
    end

    if matches_all(path, found) then
      return {
        { SetInputBuffer = path },
      }
    end

    return {
      { SetInputBuffer = string.sub(path, 1, #path - 1) },
    }
  end
end
xplr.fn.builtin.fmt_general_table_row_cols_0 = function(m)
  local r = ""
  if m.is_before_focus then
    r = r .. " -"
  else
    r = r .. "  "
  end

  r = r .. m.relative_index .. "│"

  return string.format("%7s", r)
end
xplr.fn.builtin.fmt_general_table_row_cols_1 = function(m)
  local r = m.tree .. m.prefix

  if m.meta.icon == nil then
    r = r .. ""
  else
    r = r .. m.meta.icon .. " "
  end

  r = r .. m.relative_path

  if m.is_dir then
    r = r .. "/"
  end

  r = r .. m.suffix .. " "

  if m.is_symlink then
    r = r .. "-> "

    if m.is_broken then
      r = r .. "×"
    else
      r = r .. m.symlink.absolute_path

      if m.symlink.is_dir then
        r = r .. "/"
      end
    end
  end

  return r
end
xplr.fn.builtin.fmt_general_table_row_cols_2 = function(m)
  local no_color = os.getenv("NO_COLOR")

  local function green(x)
    if no_color == nil then
      return "\x1b[32m" .. x .. "\x1b[0m"
    else
      return x
    end
  end

  local function yellow(x)
    if no_color == nil then
      return "\x1b[33m" .. x .. "\x1b[0m"
    else
      return x
    end
  end

  local function red(x)
    if no_color == nil then
      return "\x1b[31m" .. x .. "\x1b[0m"
    else
      return x
    end
  end

  local function bit(x, color, cond)
    if cond then
      return color(x)
    else
      return "-"
    end
  end

  local p = m.permissions

  local r = ""

  r = r .. bit("r", yellow, p.user_read)
  r = r .. bit("w", red, p.user_write)

  if p.user_execute == false and p.setuid == false then
    r = r .. "-"
  elseif p.user_execute == true and p.setuid == false then
    r = r .. bit("x", green, p.user_execute)
  elseif p.user_execute == false and p.setuid == true then
    r = r .. bit("S", green, p.user_execute)
  else
    r = r .. bit("s", green, p.user_execute)
  end

  r = r .. bit("r", yellow, p.group_read)
  r = r .. bit("w", red, p.group_write)

  if p.group_execute == false and p.setuid == false then
    r = r .. "-"
  elseif p.group_execute == true and p.setuid == false then
    r = r .. bit("x", green, p.group_execute)
  elseif p.group_execute == false and p.setuid == true then
    r = r .. bit("S", green, p.group_execute)
  else
    r = r .. bit("s", green, p.group_execute)
  end

  r = r .. bit("r", yellow, p.other_read)
  r = r .. bit("w", red, p.other_write)

  if p.other_execute == false and p.setuid == false then
    r = r .. "-"
  elseif p.other_execute == true and p.setuid == false then
    r = r .. bit("x", green, p.other_execute)
  elseif p.other_execute == false and p.setuid == true then
    r = r .. bit("T", green, p.other_execute)
  else
    r = r .. bit("t", green, p.other_execute)
  end

  return r
end
xplr.fn.builtin.fmt_general_table_row_cols_3 = function(m)
  if not m.is_dir then
    return m.human_size
  else
    return "-"
  end
end
xplr.fn.builtin.fmt_general_table_row_cols_4 = function(m)
  return tostring(os.date("%d %b %H:%M", m.last_modified / 1000000000))
end
xplr.fn.custom = {}
