(module plugins.feline
  {autoload {: feline
             nordic-palette nordic.palette
             nvim aniseed.nvim
             vi-mode feline.providers.vi_mode}})

(def- active-statusline
  ;; Left section of the statusline
  [[{:provider " "
     :hl (fn []
           {:name (.. (vi-mode.get_mode_highlight_name) "LeftSpace")
           :fg "fg"
           :bg (vi-mode.get_mode_color)
           :style "bold"})}
    {:provider "vi_mode"
     :hl (fn []
           {:name (vi-mode.get_mode_highlight_name)
           :fg "black"
           :bg (vi-mode.get_mode_color)
           :style "bold"})
     :icon ""}
    {:provider " "
     :hl (fn []
           {:name (.. (vi-mode.get_mode_highlight_name) "RightSpace")
           :fg "fg"
           :bg (vi-mode.get_mode_color)
           :style "bold"})}
    {:provider "file_info"
     :hl (fn []
           {:name "StatusComponentFileInfo"
           :fg "white"
           :bg "light_grey"})
     :left_sep "█"}
    {:provider "file_size"
     :hl (fn []
           {:name "StatusComponentFileSize"
           :fg "white"
           :bg "light_grey"})
     :left_sep "█"}
    {:provider "git_branch"
     :hl (fn []
           {:name "StatusComponentGitBranch"
           :fg "orange"
           :bg "light_grey"})
     :icon " "
     :left_sep "█"}
    {:provider "git_diff_added"
     :hl (fn []
           {:name "StatusComponentGitDiffAdded"
           :fg "green"
           :bg "light_grey"})
     :icon " "
     :left_sep "█"}
    {:provider "git_diff_changed"
     :hl (fn []
           {:name "StatusComponentGitDiffChanged"
           :fg "yellow"
           :bg "light_grey"})
     :icon " "
     :left_sep "█"}
    {:provider "git_diff_removed"
     :hl (fn []
           {:name "StatusComponentGitDiffRemoved"
           :fg "red"
           :bg "light_grey"})
     :icon " "
     :left_sep "█"}
    {:provider " "
     :hl (fn []
           {:name "StatusComponentLeftSideRightSpace"
           :fg "fg"
           :bg "light_grey"})}
    {:provider " "
     :hl (fn []
           {:name "StatusComponentCenterSpace"
            :fg "fg"
            :bg "dark_grey"})}]
    ;; Right section of the statusline
   [{:provider "diagnostic_errors"
     :hl (fn []
           {:name "StatusComponentLspErrors"
           :fg "red"
           :bg "dark_grey"
           :style "bold"})
     :icon " "
     :right_sep "█"}
    {:provider "diagnostic_warnings"
     :hl (fn []
           {:name "StatusComponentLspWarnings"
           :fg "yellow"
           :bg "dark_grey"
           :style "bold"})
     :icon " "
     :right_sep "█"}
    {:provider "diagnostic_info"
     :hl (fn []
           {:name "StatusComponentLspInfo"
           :fg "blue"
           :bg "dark_grey"})
     :icon " "
     :right_sep "█"}
    {:provider " "
     :hl (fn []
           {:name "StatusComponentPositionLeftSpace"
           :fg "fg"
           :bg "blue"})}
    {:provider "position"
     :hl (fn []
           {:name "StatusComponentPosition"
           :fg "black"
           :bg "blue"})
     :right_sep "█"}
    {:provider "line_percentage"
     :hl (fn []
           {:name "StatusComponentLinePercentage"
           :fg "black"
           :bg "blue"})}
    {:provider " "
     :hl (fn []
           {:name "StatusComponentLinePercentageRightSpace"
           :fg "fg"
           :bg "blue"})}]])

(def- inactive-statusline
  ;; Left section of the statusline
  [[{:provider " "
     :hl (fn []
           {:name "StatusNCComponentFileInfoLeftSpace"
            :fg "fg"
            :bg "light_grey"})}
    {:provider "file_info"
     :hl (fn []
           {:name "StatusNCComponentFileInfo"
           :fg "white"
           :bg "light_grey"})
     :right_sep "█"}
    {:provider " "
     :hl (fn []
           {:name "StatusNCComponentCenterSpace"
            :fg "fg"
            :bg "dark_grey"})}]
  ;; Right section of the statusline
   [{:provider " "
     :hl (fn []
           {:name "StatusNCComponentLinePercentageLeftSpace"
           :fg "fg"
           :bg "light_grey"})}
    {:provider "position"
     :hl (fn []
           {:name "StatusNCComponentPosition"
           :fg "white"
           :bg "light_grey"})
     :right_sep "█"}
    {:provider "line_percentage"
     :hl (fn []
           {:name "StatusNCComponentLinePercentage"
           :fg "white"
           :bg "light_grey"})}
    {:provider " "
     :hl (fn []
           {:name "StatusNCComponentLinePercentageRightSpace"
           :fg "fg"
           :bg "light_grey"})}]])

(def- theme
  (let [c nordic-palette]
    {:fg c.dark_white
     :bg c.dark_black
     :black c.dark_black
     :dark_grey c.black
     :grey c.bright_black
     :light_grey c.gray
     :white c.dark_white
     :light_white c.white
     :dark_blue c.intense_blue
     :blue c.blue
     :skyblue c.blue
     :light_blue c.cyan
     :cyan c.bright_cyan
     :red c.red
     :orange c.orange
     :yellow c.yellow
     :green c.green
     :magenta c.purple
     :violet c.purple}))


(defn config [] "Configure feline.nvim"
  ;; Overwrite statusline hl groups to prevent interference
  (let [c nordic-palette]
    (nvim.command (.. "highlight Statusline guibg=" c.dark_black))
    (nvim.command (.. "highlight StatuslineNC guibg=" c.dark_black)))

  ;; Call the setup function
  (feline.setup
    {:components
      {:active active-statusline
       :inactive inactive-statusline}
     :custom_providers []
     :theme theme
     :force_inactive
      {:filetypes ["^lazy"
                   "^Neogit"
                   "^Telescope"
                   "^help"]
       :buftypes ["^terminal"]}
     :disable
      {:filetypes ["^alpha$"]}}))
