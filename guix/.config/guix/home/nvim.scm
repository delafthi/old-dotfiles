(define-module (home nvim)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp))

(define nvim-configuration-dir
  "../../../../nvim/")

(define-public packages
  (specifications->packages
   (list
    ;; "bash-language-server"
    ;; "cmake-format"
    ;; "cmake-language-server"
    ;; "dockerls"
    "fd"
    ;; "haskell-language-server"
    "hindent"
    ;; "github-cli"
    "lazygit"
    "llvm"
    ;; "lua-language-server"
    "neovim-nightly"
    ;; "prettier"
    "python-black"
    "python-lsp-server"
    "python-mccabe"
    "python-pycodestyle"
    "python-pyflakes"
    "python-pyls-black"
    "python-pyls-flake8"
    "python-pyls-isort"
    "python-rope"
    "ripgrep"
    ;; "rust_hdl"
    ;; "shfmt"
    ;; "stylua"
    ;; "texlab"
    ;; "vimls"
    )))


(define-public services
  (list (simple-service 'nvim-config
                        home-xgd-configuration-files-service-type
                        (list ("nvim" ,(local-file
                                        (string-append nvim-configuration-dir ".config/nvim")
                                        :#recursive? #t))))))
