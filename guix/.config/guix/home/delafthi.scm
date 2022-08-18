(define-module (home delafthi)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu packages vim)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module ((home delafthi init) #:prefix init:)
  #:use-module ((home delafthi shells) #:prefix shells:)
  #:use-module ((home delafthi xdg) #:prefix xdg:))

(define-public packages
  (map specification->package
       (list ;;; Utils
        "aspell" "aspell-dict-en" "aspell-dict-de"
        "git" "git-lfs"
        "gstreamer" "gst-libav" "gst-plugins-base" "gst-plugins-good"
        "pinentry"
        "samba"
        "stow"
        "syncthing"
        "tmux"
        "direnv"

        ;;; Tools extras
        "rbw"
        "hacksaw"
        "pandoc"
        "shotgun"
        ;; "snap-sync"
        ;; "snapper"
        ;; "zsa-wally-cli"

        ;;; WM
        "breeze-icons"
        "feh"
        "kitty"
        "mpv"
        "nerd-fonts-victor-mono" "font-openmoji"
        "neovim"
        ;; "neovim-nightly"
        "nordic-theme"
        "papirus-icon-theme"
        "qutebrowser"
        "ranger"
        "rofi" "pinentry-rofi"
        ;; "starship"
        "unclutter"
        "volumeicon"
        "xss-lock"
        "zathura" "zathura-pdf-mupdf"

        ;;; Devel base
        "cmake"
        "docker"
        "doxygen"
        "graphviz"
        "ninja"
        "openjdk"
        "openocd"
        "subversion"
        "texlive"
        "valgrind"
        ;; "lazygit" "git-delta"

        ;;; Devel extras
        ;;;; C++
        "doxygen"
        "bear"
        "boost"
        ;; "cmake-language-server"
        "fmt"
        "gcc-toolchain"
        "gdb"
        "lldb"
        "llvm"
        "spdlog"

        ;;;; Docker
        ;; "dockerfile-language-server"

        ;;;; Haskell
        "ghc"
        ;; "haskel-language-server"
        "ghc-hindent"

        ;; Javascript
        "node"
        "yarn"

        ;;;; Lua
        "lua"
        "luajit"
        ;; "lua-language-server"
        ;; "luarocks"
        ;; "stylua"

        ;;;; Markdown/HTML
        ;; "prettier"

        ;;;; Python
        "python"
        "python-black"
        "python-flake8"
        "python-lsp-server"
        "python-matplotlib"
        "python-numpy"
        "python-pandas"
        "python-pylint"
        "python-pyls-black"
        "python-virtualenv"

          ;;;; R
        "r"

        ;;;; Rust
        "rust"
        "rust-cargo"
        "rust-lsp-server"

        ;;;; Shell
        ;; "bash-language-server"
        ;; "shfmt"

        ;; TeX
        "texlive"

        ;;;; VHDL
        ;; "rust_hdl"
        ;; "ghdl"
        "gtkwave"

        ;;; GUI tools
        "blender"
        "darktable"
        "gimp"
        "hugin"
        "inkscape"
        ;; "lutris"
        ;; "onlyoffice"
        ;; "spotify" "spicetify-cli"
        "virt-manager"
        )))

(define-public services
  (list (simple-service 'custom-environment-variable-service
                        home-environment-variables-service-type
                        `(("EDITOR" . #$(file-append neovim "/bin/nvim"))
                          ("GCC_COLORS" . "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01")
                          ("MANPAGER" . (string-append
                                         #$(file-append neovim "/bin/nvim")
                                         "+Man! +'set noma'"))))))

(define-public delafthi
  (home-environment
   (packages
    (append shells:packages
            xdg:packages
            packages))
   (services
    (append init:services
            shells:services
            xdg:services
            services))))

delafthi
