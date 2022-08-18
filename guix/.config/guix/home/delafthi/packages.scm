(define-module (home delafthi packages)
  #:use-module (gnu packages))

(define-public misc-packages
  (map specification->package
    (list
      "alsa-utils"
      "aspell" "aspell-dict-en" "aspell-dict-de"
      "curl"
      "fontconfig"
      "git" "git-lfs"
      "gnupg"
      "man-db" "man-pages"
      "openssh"
      "pipewire"
      "rsync"
      "sshfs"
      "tar"
      "wget"
      "unrar"
      "unzip"
      "xdg-user-dirs"
      "xdg-utils"
      "zip")))

(define-public utils-packages
  (map specification->package
    (list
      "bat"
      "exa"
      "fd"
      "fzf"
      "fzy"
      "gstreamer" "gst-libav" "gst-plugins-base" "gst-plugins-good"
      "hexyl"
      "htop"
      "minicom"
      "mlocate"
      "neofetch"
      "ripgrep"
      "stow"
      "tmux")))

(define-public networking-packages
  (map specification->package
    (list
      "nmap"
      "openconnect"
      "openvpn")))

(define-public bluetooth-packages
  (map specification->package
    (list
      "blueman"
      "bluez"
      "bluez-alsa")))

(define-public extra-utils-packages
  (map specification->package
    (list
      ;; "bitwarden-cli"
      ;; "hacksaw"
      "nix"
      "pandoc"
      "ranger"
      ;; "shotgun"
      ;; "snap-sync"
      ;; "snapper"
      ;; "wyvern"
      ;; "zsa-wally-cli"
      )))
(define-public wm-packages
  (map specification->package
    (list
      "awesome"
      "breeze-icons"
      "gtk+"
      "gtk-engines"
      "mesa"
      "font-victor-mono"
      "nordic-theme"
      "papirus-icon-theme"
      "picom";; "picom-jonaburg-git"
      "unclutter"
      "vulkan-tools"
      "xclip"
      "xdotool"
      "xf86-input-libinput"
      "xf86-video-amdgpu"
      "xf86-video-intel"
      "xf86-video-vesa"
      "xrandr"
      "xss-lock"
      "xterm")))

(define-public dev-packages
  (map specification->package
    (list
      "cmake"
      "docker"
      "doxygen"
      "emacs" "emacs-guix"
      "git" "git-lfs"
      "graphviz"
      "libvirt"
      "libtool"
      "make"
      ;; "neovim-git"
      "ninja"
      "openjdk"
      "openocd"
      "pkg-config"
      ;; "starship"
      "subversion"
      "texinfo"
      "texlive"
      "valgrind")))

(define-public python-packages
  (map specification->package
    (list
      ;; "pyenv"
      "python"
      "python-black"
      "python-flake8"
      "python-lsp-server"
      "python-matplotlib"
      "python-numpy"
      "python-pandas"
      "python-pylint"
      "python-pyls-black")))

(define-public cpp-packages
  (map specification->package
    (list
      "bear"
      "boost"
      "fmt"
      "gcc-toolchain"
      "gdb"
      "lldb"
      "llvm"
      "spdlog")))

(define-public lang-packages
  (map specification->package
    (list
      ;; "bash-language-server"
      ;; "cmake-language-server"
      ;; "dockerfile-language-server"
      "ghc"
      ;; "haskel-language-server"
      ;; "hindent"
      "lua"
      "luajit"
      ;; "lua-language-server"
      ;; "luarocks"
      "node"
      ;; "prettier"
      "r"
      ;; "shfmt"
      ;; "stylua"
      "texlive"
      ;; "yarn"
      )))

(define-public gui-packages
  (map specification->package
    (list
      "feh"
      "kitty"
      "mpv"
      "pavucontrol"
      "pcmanfm"
      "qutebrowser"
      "rofi" ;; "bitwarden-rofi" "eidolon"
      ;; "spotify" "spicetify-cli"
      "virt-manager"
      "zathura" "zathura-pdf-poppler")))

(define-public extra-packages
  (map specification->package
    (list
      "blender"
      "gimp"
      "hugin"
      "inkscape"
      "libreoffice"
      "kicad")))
