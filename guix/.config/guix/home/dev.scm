(define-module (home dev)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp))

(define dev-configuration-dir
  "../../../../misc/")

(define-public packages
  (specifications->packages
   (list "babeltrace"
         "cmake"
         ;; "cmake-language-server"
         "doxygen"
         "graphviz"
         "git"
         "git-delta"
         "lazygit"
         "lttng-tools"
         "ninja"
         "pandoc"
         "subversion"
         "valgrind")))

(define-public c-packages
  (specifications->packages
   (list "doxygen"
         "bear"
         "boost"
         "fmt"
         "gcc-toolchain"
         "gdb"
         "lldb"
         "llvm"
         "openocd"
         "spdlog")))

(define-public haskell-packages
  (specifications->packages
   (list "ghc"
         ;; "haskel-language-server"
         "ghc-hindent")))

(define-public java-packages
  (specifications->packages
   (list "openjdk")))

(define-public javascript-packages
  (specifications->packages
   (list "node"
         "yarn")))

(define-public lua-packages
  (specifications->packages
   (list "lua"
         "luajit"
         ;; "lua-language-server"
         ;; "luarocks"
         ;; "stylua"
         )))

(define-public markdown-packages
  (specifications->packages
   (list ;; "prettier"
    )))

(define-public python-packages
  (specifications->packages
   (list "python"
         "python-black"
         "python-flake8"
         "python-lsp-server"
         "python-matplotlib"
         "python-numpy"
         "python-pandas"
         "python-pylint"
         "python-pyls-black"
         "python-virtualenv")))

(define-public r-packages
  (specifications->packages
   (list "r"
         "r-languageserver")))

(define-public rust-packages
  (specifications->packages
   (list "rust"
         "rust-cargo"
         "rust-lsp-server")))

(define-public shell-packages
  (specifications->packages
   (list
    ;;"bash-language-server"
    ;;"shfmt"
    )))

(define-public tex-packages
  (specifications->packages
   (list ;; "texlab"
    "texlive")))

(define-public hdl-packages
  (specifications->packages
   (list
    ;; "rust_hdl"
    ;; "ghdl"
    "gtkwave")))

(define-public services
  (list (simple-service 'clang-format-config
                        home-files-service-type
                        (list (".clang-format" ,(local-file
                                                 (string-append dev-configuration-dir ".clang-format")))
                              (".local/bin/cp-clang-format" ,(local-file
                                                              (string-append dev-configuration-dir ".local/bin/cp-clang-format")))))
        (simple-service 'gdb-config
                        home-files-service-type
                        (list (".gdbinit" ,(local-file
                                            (string-append dev-configuration-dir ".gdbinit")))))
        (simple-service 'git-config
                        home-files-service-type
                        (list (".gitconfig" ,(local-file
                                              (string-append dev-configuration-dir ".gitconfig")))))
        (simple-service 'git-xdg-config
                        home-xdg-configuration-files-service-type
                        (list ("git/ignore" ,(local-file
                                              (string-append dev-configuration-dir ".config/git/ignore")))))
        (simple-service 'gtkwave-config
                        home-files-service-type
                        (list ("gtkwave.tcl" ,(local-file
                                               (string-append dev-configuration-dir "gtkwave.tcl")))
                              (".gtkwaverc" ,(local-file
                                              (string-append dev-configuration-dir ".gtkwaverc")))))
        (simple-service 'latexmkrc-config
                        home-files-service-type
                        (list (".latexmkrc" ,(local-file
                                              (string-append dev-configuration-dir ".latexmkrc")))))
        (simple-service 'lazygit-config
                        home-xdg-configuration-files-service-type
                        (list ("lazygit/config.yml" ,(local-file
                                                      (string-append dev-configuration-dir ".config/lazygit/config.yml")))))
        (simple-service 'python-black-config
                        home-xdg-configuration-files-service-type
                        (list ("black" ,(local-file
                                         (string-append dev-configuration-dir ".config/black")))))
        (simple-service 'python-flake8-config
                        home-xdg-configuration-files-service-type
                        (list ("flake8" ,(local-file
                                          (string-append dev-configuration-dir ".config/flake8")))))
        (simple-service 'python-jupyter-config
                        home-files-service-type
                        (list (".jupyter/custom/custom.css" ,(local-file
                                                              (string-append dev-configuration-dir ".jupyter/custom/custom.css")))))
        (simple-service 'stylua-config
                        home-files-service-type
                        (list (".local/bin/cp-stylua" ,(local-file
                                                        (string-append dev-configuration-dir ".local/bin/cp-stylua")))))
        (simple-service 'stylua-xdg-config
                        home-xdg-configuration-files-service-type
                        (list ("stylua/stylua.toml" ,(local-file
                                                      (string-append dev-configuration-dir ".config/stylua/stylua.toml")))))))
