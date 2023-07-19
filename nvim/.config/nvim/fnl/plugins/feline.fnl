(module plugins.feline
  {autoload {: feline
             onedarkpro-helpers onedarkpro.helpers
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
           :bg "gray"})
     :left_sep "█"}
    {:provider "file_size"
     :hl (fn []
           {:name "StatusComponentFileSize"
           :fg "white"
           :bg "gray"})
     :left_sep "█"}
    {:provider "git_branch"
     :hl (fn []
           {:name "StatusComponentGitBranch"
           :fg "orange"
           :bg "gray"})
     :icon "󰘬 "
     :left_sep "█"}
    {:provider "git_diff_added"
     :hl (fn []
           {:name "StatusComponentGitDiffAdded"
           :fg "green"
           :bg "gray"})
     :icon "󰐗 "
     :left_sep "█"}
    {:provider "git_diff_changed"
     :hl (fn []
           {:name "StatusComponentGitDiffChanged"
           :fg "yellow"
           :bg "gray"})
     :icon "󰆗 "
     :left_sep "█"}
    {:provider "git_diff_removed"
     :hl (fn []
           {:name "StatusComponentGitDiffRemoved"
           :fg "red"
           :bg "gray"})
     :icon "󰍶 "
     :left_sep "█"}
    {:provider " "
     :hl (fn []
           {:name "StatusComponentLeftSideRightSpace"
           :fg "fg"
           :bg "gray"})}
    {:provider " "
     :hl (fn []
           {:name "StatusComponentCenterSpace"
            :fg "fg"
            :bg "bg"})}]
    ;; Right section of the statusline
   [{:provider "diagnostic_errors"
     :hl (fn []
           {:name "StatusComponentLspErrors"
           :fg "red"
           :bg "bg"
           :style "bold"})
     :icon "󰅙 "
     :right_sep "█"}
    {:provider "diagnostic_warnings"
     :hl (fn []
           {:name "StatusComponentLspWarnings"
           :fg "yellow"
           :bg "bg"
           :style "bold"})
     :icon " "
     :right_sep "█"}
    {:provider "diagnostic_info"
     :hl (fn []
           {:name "StatusComponentLspInfo"
           :fg "blue"
           :bg "bg"})
     :icon "󰋼 "
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
            :bg "gray"})}
    {:provider "file_info"
     :hl (fn []
           {:name "StatusNCComponentFileInfo"
           :fg "white"
           :bg "gray"})
     :right_sep "█"}
    {:provider " "
     :hl (fn []
           {:name "StatusNCComponentCenterSpace"
            :fg "fg"
            :bg "bg"})}]
  ;; Right section of the statusline
   [{:provider " "
     :hl (fn []
           {:name "StatusNCComponentLinePercentageLeftSpace"
           :fg "fg"
           :bg "bg"})}
    {:provider "position"
     :hl (fn []
           {:name "StatusNCComponentPosition"
           :fg "white"
           :bg "bg"})
     :right_sep "█"}
    {:provider "line_percentage"
     :hl (fn []
           {:name "StatusNCComponentLinePercentage"
           :fg "white"
           :bg "bg"})}
    {:provider " "
     :hl (fn []
           {:name "StatusNCComponentLinePercentageRightSpace"
           :fg "fg"
           :bg "bg"})}]])

(def- theme
  (let [c (onedarkpro-helpers.get_colors "onedark")]
    {:fg c.fg
     :bg c.bg_statusline
     :black c.black
     :gray c.gray
     :white c.white
     :blue c.blue
     :cyan c.cyan
     :red c.red
     :orange c.orange
     :yellow c.yellow
     :green c.green
     :magenta c.purple
     :violet c.purple}))


(defn config [] "Configure feline.nvim"
  ;; Overwrite statusline hl groups to prevent interference
  (let [c (onedarkpro-helpers.get_colors "onedark")]
    (nvim.command (.. "highlight Statusline guibg=" c.black))
    (nvim.command (.. "highlight StatuslineNC guibg=" c.black)))

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
