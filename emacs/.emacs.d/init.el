;; Disable all gui elements right from the start
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Disable compilation warning messages
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Define a custom package directory, add append it to the load path and set
;; some package related settings
(eval-and-compile
  ;; Create a cache directory
  (defcustom user-emacs-cache-directory
    "~/.cache/emacs/"
    "The path to the user cache folder of emacs, where generated files are stored"
    :initialize (lambda (symbol val)
                  (custom-initialize-reset symbol val)
                  (unless (file-directory-p val)
                    (make-directory val t)))
    :type 'string
    :group 'environment)
  ;; Change the package directory and some other settings
  (setq load-prefer-newer t
        package-user-dir (expand-file-name "elpa/" user-emacs-cache-directory)
        package--init-file-ensured t
        package-enable-at-startup nil)
  ;; Create the package directory of it does not yet exist
  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t))
  ;; Append the package directory to the load path
  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t))))

(eval-when-compile
  ;; Add other package sources
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("org" . "https://orgmode.org/elpa/")
                           ("elpa" . "https://elpa.gnu.org/packages/")))
  ;; Set up package
  (require 'package)
  (package-initialize)
  (unless package-archive-contents (package-refresh-contents))
  ;; Install use-package if it is not yet installed and initialize it
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package))

;; Automatically install missing packages and always defer packages until they
;; are used to speed up the start up time
(setq use-package-always-ensure t
      use-package-verbose t)

;; Increase the garbage collection bin to decrease the startup time
(setq gc-cons-threshold 10000000)

;; Benchmark the startup of emacs
(use-package benchmark-init
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate)
  (add-hook 'after-init-hook (lambda () (message "Emacs loaded in %s" (emacs-init-time)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emacs
  :custom
  ;; Startup
  (unhibit-default-init t)
  (inhibit-startup-screen t)
  (inhibit-startup-echo-area-message t)
  ;; User info
  (user-full-name "Thierry Delafontaine")
  (user-mail-address "delafontaineth@pm.me")
  ;; Environment
  (tool-bar-mode nil)
  (tooltip-mode nil)
  (menu-bar-mode nil)
  (scroll-bar-mode nil)
  (fringe-mode 10)
  (blink-cursor-mode nil)
  (x-stretch-cursor-mode t)
  (line-number-mode t)
  (column-number-mode t)
  (global-auto-revert-mode t)
  (size-indication-mode t)
  (current-language-environment "UTF-8")
  (keyboard-coding-systems 'utf-8)
  (display-line-numbers-type 'relative)
  ;; Scroll bevavior
  (scroll-margin 8)
  (scroll-preserve-screen-position 1)
  (scroll-conservatively 1)
  ;; Editing
  (delete-trailing-lines t)
  (next-line-add-newlines t)
  (tab-width 2)
  (fill-column 80)
  (indent-tabs-mode nil)
  (standard-indent 2)
  :config
  ;; Set fonts
  (set-face-attribute 'default nil :font "VictorMono Nerd Font" :height 110)
  (set-face-attribute 'fixed-pitch nil :font "VictorMono Nerd Font" :height 110)
  (set-face-attribute 'variable-pitch nil :font "VictorMono Nerd Font" :height 110 :weight 'regular)
  ;; Use the escape key to exit commands
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
  ;; Use y and p instead of yes and no
  (fset 'yes-or-no-p 'y-or-n-p)
  ;; Add hooks
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'prog-mode-hook 'hl-line-mode)
  (add-hook 'prog-mode-hook 'electric-pair-mode)
  (add-hook 'prog-mode-hook 'show-paren-mode)
  (add-hook 'after-init-hook (lambda() (setq gc-cons-threshold 1000000)
                               (message "gc-cons-threshold reset to %S" gc-cons-threshold))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Auto Update packages
(use-package auto-package-update
  :init
  (setq auto-package-update-last-update-day-path
        (expand-file-name ".last-package-update-day" user-emacs-cache-directory))
  :custom
  (auto-package-update-prompt-before-update t)
  (auto-package-update-preview t)
  (auto-package-delete-old-versions t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))

;; Move generated files to '~/.cache/emacs/'
;; These variables have to be set before no-littering gets loaded. However,
;; :init doesn't seem to work
(setq no-littering-etc-directory
      (expand-file-name "etc/" user-emacs-cache-directory))
(setq no-littering-var-directory
      (expand-file-name "var/" user-emacs-cache-directory))
(use-package no-littering
  :custom
  (auto-save-file-name-transforms
   `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (custom-file (no-littering-expand-etc-file-name "custom.el")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Interface enhancements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Evil
(use-package evil
  :init
  (setq evil-respect-visual-line-mode t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :custom
  (evil-want-C-i-jump nil)
  (evil-want-C-u-scroll t)
  (evil-want-Y-to-eol t)
  (evil-shift-width tab-width)
  (evil-move-beyond-eol t)
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  (evil-echo-state nil)
  :config
  (evil-mode))

;; A collection of bindings for different modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Make bindings that stick around
(use-package hydra
  :defer t)

;; Set keybindings more conveniently
(use-package general
  :after evil
  :config
  (general-define-key
   :states '(normal insert visual emacs)
   "C-h" 'windmove-left
   "C-j" 'windmove-down
   "C-k" 'windmove-up
   "C-l" 'windmove-right)
  (general-create-definer my-leader
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC")
  (my-leader
    "h" '(:ignore t :which-key "help")
    "hk" '(describe-key :which-key "describe key-bindings")
    "f" '(:ignore t :which-key "files")
    "fb" '(switch-to-buffer :which-key "go to buffer")
    "o" '(flyspell-mode :which-key "Enable spell checking")
    "cc" '(comment-or-uncomment-region :which-key "comment or uncomment region")))

;; Startup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dashboard
  :custom
  (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :config
  (dashboard-setup-startup-hook))

;; Help
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Better describe functions
(use-package helpful
  :after counsel
  :commands
  (helpful-callable helpful-command helpful-key helpful-variable)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind (([remap describe-command] . helpful-command)
         ([remap describe-key] . helpful-key)
         ("C-h C-h" . helpful-at-point))
  :config
  (my-leader
    "hh" '(helpful-at-point :which-key "describe the element under the cursor")))

;; Get a pop up menu, to see what the keybindings do
(use-package which-key
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 1)
  :config
  (which-key-mode))

;; Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Better minibuffer completion
(use-package ivy
  :diminish
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode)
  (global-set-key "\C-s" 'swiper))

;; Replace default emacs functions with their ivy alternatives
(use-package counsel
  :diminish
  :config
  (counsel-mode)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  (my-leader
    "hf" '(counsel-describe-function :which-key "describe function")
    "hv" '(counsel-describe-variable :which-key "describe variable")
    "ff" '(counsel-find-file :which-key "find a file")
    "rg" '(counsel-rg :which-key "grep in current dir")
    "/" '(swiper :which-key "swiper")))

;; Ivy additions
;; Display even more info in ivy functions
(use-package ivy-rich
  :after ivy
  :diminish
  :config
  (ivy-rich-mode))

;; Better sorting in ivy functions according to the usage
(use-package ivy-prescient
  :diminish
  :after ivy
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (ivy-prescient-mode))

;; Visual enhancements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Color delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Color color-codes
(use-package rainbow-mode
  :custom
  (rainbow-x-colors nil)
  :hook (prog-mode . rainbow-mode))

;; Syntax highlighting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Tree-sitter
(use-package tree-sitter-langs)
(use-package tree-sitter
  :hook
  (tree-sitter-after-on-hook . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save a list of recent files
(use-package recentf
  :config
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (my-leader
    "fr" '(counsel-recentf :which-key "recent files")))

;; Projects management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Projectile
(use-package projectile
  :diminish
  :init
  (setq projectile-project-search-path '("~/projects/work/" "~/projects/private/"))
  :custom
  (projectile-completion-system 'ivy)
  :config
  (projectile-mode)
  (my-leader
    "p" '(:ignore t :which-key "projectile")))

;; Counsel in projectile
(use-package counsel-projectile
  :after projectile
  :diminish
  :config
  (counsel-projectile-mode)
  (my-leader
    "pf" '(counsel-projectile-find-file :which-key "search for a file in current dir")
    "pg" '(counsel-projectile-rg :which-key "grep in project")
    "pp" '(counsel-projectile-switch-project :which-key "switch the project")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Lsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; lsp base package
(use-package lsp-mode
  :commands lsp
  :hook
  (lsp-mode . lsp-enable-which-key-integration))

;; integrate lsp in the ui
(use-package lsp-ui
  :commands lsp-ui-mode)

;; Ivy in lsp functions
(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

;; Error checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package flycheck)

;; Debugging
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dap-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; VCS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Git
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Magit
(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; git-svn integration
(use-package magit-svn
  :after magit
  :hook (magit-mode-hook . magit-svn-mode))

;; git-lfs integration
(use-package magit-lfs
  :after magit)

;; Work with git forges
(use-package forge
  :after magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Terminal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Terminal emulator with exetrnal lib
(use-package vterm)

;; Integrated emacs shell written in lisp
(use-package eshell
  :custom
  (eshell-destroy-buffer-when-process-dies t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Org base package
(use-package org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GUI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Icons
(use-package all-the-icons)

;; A Better modeline
(use-package doom-modeline
  :config (doom-modeline-mode))

;; Themes
(use-package nord-theme
  :init (load-theme 'nord t))
(use-package doom-themes)
