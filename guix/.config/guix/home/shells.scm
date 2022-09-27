(define-module (home shells)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages tmux)
  #:use-module (guix gexp))

(define shells-configuration-dir
  "../../../../shells/")

(define-public packages
  (specifications->packages
   (list "aspell"
         "aspell-dict-en"
         "aspell-dict-de"
         "bash"
         "bash-completion"
         "bat"
         "direnv"
         "exa"
         "fish"
         "fish-foreign-env"
         "fzf"
         "git"
         "git-lfs"
         "gzip"
         "hexyl"
         "htop"
         "neofetch"
         "neovim"
         "p7zip"
         "plocate"
         "ripgrep"
         "rust-starship-module-config-derive"
         "tar"
         "tmux"
         "unrar"
         "unzip"
         ;; "xplr"
         "zip")))

(define aliases
  (list ("cp" . "cp -i")
        ("df" . "df -h")
        ("feh" . (string-append #$(file-append feh "/bin/feh")
                                "--auto-zoom --scale-down"))
        ("free" . "free -m")
        ("gl" . #$(file-append lazygit "/bin/lazygit"))
        ("htop" . (string-append #$(file-append htop "/bin/htop")
                                 "-t"))
        ("la" . (string-append #$(file-append exa "/bin/exa")
                               "-a --color=always --group-directories-first"))
        ("ll" . (string-append #$(file-append exa "/bin/exa")
                               "-l --color=always --group-directories-first"))
        ("l" . (string-append #$(file-append exa "/bin/exa")
                              "-al --color=always --group-directories-first"))
        ("lt" . (string-append #$(file-append exa "/bin/exa")
                               "-aT --color=always --group-directories-first"))
        ("mv" . "mv -i")
        ("rm" . "rm -i")
        ("sudo" . "sudo -E")
        ("tn" . (string-append #$(file-append tmux "/bin/tmux")
                               "new -s $(pwd | sed 's/.*\\///g')"))
        ("vi" . #$(file-append neovim-nightly "/bin/nvim"))
        ("vim" . #$(file-append neovim-nightly "/bin/nvim"))))

(define abbreviations
  (list (".." . "cd ..")
        ("..." . "cd ../..")
        (".3" . "cd ../../..")
        (".4" . "cd ../../../..")
        (".5" . "cd ../../../../..")
        (":q" . "exit")))

(define-public services
  (list (simple-service 'my-env-vars
                        home-environment-variables-service-type
                        (list ("EDITOR" . #$(file-append neovim-nightly "/bin/nvim"))
                              ("GCC_COLORS" . "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01")
                              ("MANPAGER" . (string-append
                                             #$(file-append neovim-nightly "/bin/nvim")
                                             "+Man! +'set noma'")
                               ("PATH" . "$HOME/.local/bin:$PATH"))))
        (service home-bash-service-type
                 (home-bash-configuration
                  (aliases (append aliases
                                   abbreviations))
                  (bashrc (list (".bashrc" ,(local-file
                                             (string-append shells-configuration-dir ".bashrc")))))))
        (service home-fish-service-type
                 (home-fish-configuration
                  (abbreviations abbreviations)
                  (aliases aliases)
                  (config (list ("config.fish" ,(local-file
                                                 (string-append shells-configuration-dir ".config/fish/config.fish")))))))
        (simple-service 'bat-config
                        home-xdg-configuration-files-service-type
                        (list ("bat/config" ,(local-file
                                              (string-append shells-configuration-dir ".config/bat/config")))))
        (simple-service 'dircolors-config
                        home-files-service-type
                        (list (".dir_colors" ,(local-file
                                               (string-append shells-configuration-dir ".dir_colors")))))
        (simple-service 'mlocate-cron-job
                        home-mcron-service-type
                        (home-mcron-configuration
                         (jobs (list (job '(next-day) )))))
        (simple-service 'starship-config
                        home-xdg-configuration-files-service-type
                        (list ("starship" ,(local-file
                                            (string-append shells-configuration-dir ".config/starship")
                                            :#recursive? #t))))
        (simple-service 'bin-scripts
                        home-files-service-type
                        (list (".local/bin" ,(local-file
                                              (string-append bin-configuration-dir ".local/bin")
                                              :#recursive? #t))))
        (simple-service 'tmux-config
                        home-xdg-configuration-files-service-type
                        (list ("tmux" ,(local-file
                                        (string-append shells-configuration-dir ".config/tmux")
                                        :#recursive?
                                        #t))))))
