(let [wezterm (require "wezterm")
      leader "CTRL|SHIFT"]
  {:audible_bell "Disabled"
   :automatically_reload_config false
   :check_for_updates false
   :colors
    {:foreground "#d8dee9"
     :background "#2e3440"
     :cursor_fg "#2e3440"
     :cursor_bg "#d8dee9"
     :cursor_border "#d8dee9"
     :compose_cursor "#3b4252"
     :selection_fg nil
     :selection_bg "#434c5e"
     :split "#3b4252"
     :ansi ["#3b4252"
            "#bf616a"
            "#a3be8c"
            "#ebcb8b"
            "#81a1c1"
            "#b48ead"
            "#88c0d0"
            "#e5e9f0"]
     :brights ["#4c566a"
               "#bf616a"
               "#a3be8c"
               "#ebcb8b"
               "#81a1c1"
               "#b48ead"
               "#8fbcbb"
               "#eceff4"]
     :copy_mode_active_highlight_fg {:Color "#d8dee9"}
     :copy_mode_active_highlight_bg {:Color "#81a1c1"}
     :copy_mode_inactive_highlight_fg {:Color "#2e3440"}
     :copy_mode_inactive_highlight_bg {:Color "#88c0d0"}

     :quick_select_label_fg {:Color "#2e3440"}
     :quick_select_label_bg {:Color "#81a1c1"}
     :quick_select_match_fg {:Color "#d8dee9"}
     :quick_select_match_bg {:Color "#434c5e"}}
   :cursor_blink_rate 0
   :debug_key_events false
   :disable_default_key_bindings true
   :enable_scroll_bar false
   :enable_tab_bar false
   :exit_behavior "Close"
   :font
    (wezterm.font_with_fallback
      [{:family "VictorMono Nerd Font"
        :weight "Medium"}
       {:family "OpenMoji Color"
        :weight "Bold"}])
   :font_size 12.0
   :keys
    [{:key "y"
      :mods leader
      :action (wezterm.action.CopyTo "Clipboard")}
     {:key "p"
      :mods leader
      :action (wezterm.action.PasteFrom "Clipboard")}
     {:key "k"
      :mods leader
      :action (wezterm.action.ScrollByLine -1)}
     {:key "j"
      :mods leader
      :action (wezterm.action.ScrollByLine 1)}
     {:key "u"
      :mods leader
      :action (wezterm.action.ScrollByPage -1)}
     {:key "d"
      :mods leader
      :action (wezterm.action.ScrollByPage 1)}
     {:key "g"
      :mods leader
      :action wezterm.action.ScrollToBottom}
     {:key ">"
      :mods leader
      :action wezterm.action.IncreaseFontSize}
     {:key "<"
      :mods leader
      :action wezterm.action.DecreaseFontSize}
     {:key "Backspace"
      :mods leader
      :action wezterm.action.ResetFontSize}
     {:key "f"
      :mods leader
      :action wezterm.action.QuickSelect}
     {:key " "
      :mods leader
      :action wezterm.action.ActivateCopyMode}
     {:key "R"
      :mods leader
      :action wezterm.action.ReloadConfiguration}
     {:key "?"
      :mods leader
      :action (wezterm.action.Search "CurrentSelectionOrEmptyString")}
     {:key "c"
      :mods leader
      :action (wezterm.action.ClearScrollback "ScrollbackOnly")}]
   :max_fps 140
   :quick_select_alphabet "aoeuqjkxpyhtnsgcrlmwvzfidb"
   :scrollback_lines 10000
   :term "wezterm"
   :warn_about_missing_glyphs false
   :window_close_confirmation "NeverPrompt"
   :window_decorations "NONE"
   :window_padding
    {:left 6
     :right 6
     :top 4
     :bottom 4}})
