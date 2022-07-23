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
          "alsa-utils"
          "aspell" "aspell-dict-en" "aspell-dict-de"
          "git" "git-lfs"
          "gnupg"
          "gstreamer" "gst-libav" "gst-plugins-base" "gst-plugins-good"
          "nmap"
          "openssh"
          "rsync"
          "sshfs"
          "wget"
          "xdg-utils"
          "stow"

          ;;; Tools extras
          ;; "bitwarden-cli"
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
          "pavucontrol"
          "qutebrowser"
          "rofi" "pinentry-rofi" ;; "bitwarden-rofi" "eidolon"
          ;; "starship"
          "xclip"
          "xdotool"
          "xrandr"
          "xss-lock"
          "xterm"
          "zathura" "zathura-pdf-poppler"

          ;;; Devel base
          "cmake"
          "docker"
          "doxygen"
          "emacs" "emacs-guix"
          "graphviz"
          "libvirt"
          "libtool"
          "make"
          "ninja"
          "openjdk"
          "openocd"
          "pkg-config"
          "subversion"
          "texinfo"
          "texlive"
          "valgrind"

          ;;; Devel extras
          ;;;; C++
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
          ;; "hindent"

          ;; Javascript
          "node"

          ;;;; Lua
          "lua"
          "luajit"
          ;; "lua-language-server"
          ;; "luarocks"
          ;; "stylua"

          ;;;; Markdown/HTML
          ;; "prettier"

          ;;;; Python
          ;; "pyenv"
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

          ;;;; Shell
          ;; "bash-language-server"
          ;; "shfmt"

          ;; TeX
          "texlive"

          ;;;; VHDL
          ;; "rust_hdl"
          ;; "ghdl"

          ;;; GUI tools
          "blender"
          "gimp"
          "hugin"
          "inkscape"
          "libreoffice"
          ;; "lutris"
          "kicad"
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
