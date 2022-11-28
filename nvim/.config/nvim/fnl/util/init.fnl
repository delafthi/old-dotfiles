(module util
  {autoload {nvim aniseed.nvim
             a aniseed.core
             : which-key}})

(defn error [msg name]
  "Raise an error notification"
  (vim.notify msg vim.log.levels.ERROR {:title (or name "init.lua")}))

(defn exec-and-restore-view [cmd]
  "Execute a command without littering our undo file"
  (let [curw (vim.fn.winsaveview)
        tmpundofile (vim.fn.tempname)]
    (nvim.command (.. "wundo! " tmpundofile))
    (nvim.command "try | silent undojoin | catch | endtry")
    (nvim.command cmd)
    (nvim.command (.. "silent! rundo " tmpundofile))
    (vim.fn.delete tmpundofile)
    (vim.fn.winrestview curw)))

(defn foldtext []
  "Sets how the text is folded"
  (let [foldstart (nvim.get_vvar "foldstart")]
    (let [line (nvim.buf_get_lines 0 (- foldstart 1) foldstart false)]
      (let [sub (string.gsub (. line 1) "{{{.*" "")]
        (.. "▸ " sub)))))

(defn get-visual-selection []
  "Returns the currently selected text"
  (let [start (vim.fn.getpos "'<")
        end (vim.fn.getpos "'<")]
    (let [n (math.abs (+ (- (. start 2) (. end 2)) 1))
          lines (nvim.buf_get_lines 0 (- (. start 2) 1) (. end 2) false)]
      (match n
        1 (tset lines n
                (string.sub (. lines n) 1 (+ (- (. end 3) (. start 3)) 1)))
        _ (tset lines n
                (string.sub (. lines n) 1 (. end 3))))
      (table.concat lines "\n"))))

(defn info [msg name]
  "Raise an info notification"
  (vim.notify msg vim.log.levels.INFO {:title (or name "init.lua")}))

(defn lua-line [path]
  "Evaluate the a lua buffer"
  (nvim.ex.luafile path))

(defn set-keymap [description modes map command opts]
  (.. "Wrapper around which-key.register, which is not able to set keybindings "
      "in multiple modes")
    ;; Set the keymap
  (vim.keymap.set modes (table.concat map "") command opts)
  ;; Register the mapping in which-key
  (when (a.some (fn [x] (when (= x "n") true)) modes)
        (which-key.register (a.assoc-in {} map description))))

(defn warn [msg name]
  "Raise an warning notification"
  (vim.notify msg vim.log.levels.WARN {:title (or name "init.lua")}))
