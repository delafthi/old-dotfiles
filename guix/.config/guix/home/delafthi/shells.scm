(define-module (home delafthi shells)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages disk)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages vim)
  #:use-module (guix gexp))

(define-public packages
  (map specification->package
    (list "fd"
          "fzy"
          "hexyl"
          "htop"
          "mlocate"
          "neofetch"
          "ripgrep"
          ;;"starship"
          "tar"
          "tmux"
          "unzip"
          "zip")))

(define aliases
  `(("bat" . (string-append #$(file-append bat "/bin/bat") 
                            " --italic-text=always --color always --theme Nord"))
    ("cp" . "cp -i")
    ("df" . "df -h")
    ("feh" . (string-append #$(file-append feh "/bin/feh")
                            "--auto-zoom --scale-down"))
    ("free" . "free -m")
    ("fzf" . (string-append #$(file-append fzf "/bin/fzf")
                            "--color='fg:#d8dee9,bg:#2e3440,fg+:#81a1c1,bg+:#2e3440,border:#4c566a' "
                            "--color='info:#81a1c1,spinner:#b48ead,header:#bf616a,prompt:#b48ead' "
                            "--color='hl:#ebcb8b,hl+:#ebcb8b,pointer:#b48ead,marker:#d08770' "
                            "--color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' "
                            "--color='hl:reverse,hl+:reverse'"))
    ("grep" . "batgrep")
    ("htop" . (string-append #$(file-append htop "/bin/htop")
                              "-t"))
    ("la" . (string-append #$(file-append exa "/bin/exa")
                           "-a --color=always --group-directories-first"))
    ("ll" . (string-append #$(file-append exa "/bin/exa")
                           "-l --color=always --group-directories-first"))
    ("ls" . (string-append #$(file-append exa "/bin/exa")
                           "-al --color=always --group-directories-first"))
    ("lt" . (string-append #$(file-append exa "/bin/exa")
                           "-aT --color=always --group-directories-first"))
    ("mv" . "mv -i")
    ("rm" . "rm -i")
    ("ssh" . (string-append #$(file-append kitty "/bin/kitty")
                            "+kitten ssh"))
    ("sudo" . "sudo -E")
    ("vi" . #$(file-append neovim "/bin/nvim"))
    ("vim" . #$(file-append neovim "/bin/nvim"))))

(define abbreviations
  `((".." . "cd ..")
    ("..." . "cd ../..")
    (".3" . "cd ../../..")
    (".4" . "cd ../../../..")
    (".5" . "cd ../../../../..")
    (":q" . "exit")))

(define-public services
  (list (service home-bash-service-type
          (home-bash-configuration
            (environment-variables
              `(("HISTCONTROL" . "ignoreboth") ;; No duplicate history entries
                ("HISTSIZE" . 5000) ;; History size
                ("HISTFILESIZE" . 10000))) ;; History file size
            (aliases 
              (append aliases
                      abbreviations))
            (bash-profile 
              `((string-append "source " 
                               #$(file-append bash-completion 
                                  "/usr/share/bash-completion/bash_completion")) ;; Enable auto-completion
               
                "bind 'set completion-ignore-case on'" ;; Ignore the casing during TAB completion
                "shopt -s autocd" ;; Change to named directory
                "shopt -s cdspell" ;; Autocorrects cd misspellings
                "shopt -s cmdhist" ;; Save multi-line commands in history as single line 
                "shopt -s dotglob" ;; Bash includes filenames beginning with a ‘.’ in the results of filename expansion 
                "shopt -s histappend" ;; Do not overwrite the history 
                "shopt -s expand_aliases" ;; Expand aliases 
                "shopt -s checkwinsize" ;; Checks term size when bash regains control 
                "set -o vi" ;; Enable vi bindings
               
                (string-append 
                  "ranger()\n"
                  "{\n"
                  "  if [ -z "$RANGER_LEVEL" ]; then\n"
                  "    " #$(file-append ranger "/bin/ranger") " '$@'\n"
                  "  else\n"
                  "    exit\n"
                  "}\n"
                  "fi") ;; Exit ranger rather than opening a new instance if we already are in an instance
               
                (string-append "eval '$("
                                ; ,(file-append starship "/bin/starship")
                                "init bash)'"))))) ;; Initialize starship
        (service home-fish-service-type
          (home-fish-configuration
            (config
                `((string-append "function fish_title\n"
                                  "  echo $argv[1]\n"
                                  "  pwd\n"
                                  "end") ;; Set the titel of the terminal window
                  (string-append "function fish_command_not_found\n"
                                  "  __fish_default_command_not_found_handler $argv\n"
                                  "end") ;; Set the command not found handler to the default one
                  (string-append "function nofunc --description 'Run command ignoring functions and aliases'\n"
                                  "  functions -c $argv[1] functionholder\n"
                                  "  functions --erase $argv[1]\n"
                                  "  $argv\n"
                                  "  functions -c functionholder @argv[1]\n"
                                  "  functions --erase functionholder\n"
                                  "end") ;; Run functions ignoring functions and aliases
                  (string-append "function ranger\n"
                                  "  if test -z '$RANGER_LEVEL'\n"
                                  "    " #$(file-append ranger "/bin/ranger") " $argv\n"
                                  "  else\n"
                                  "    exit\n"
                                  "  end\n"
                                  "end") ;; Exit ranger rather than opening a new instance if we already are in an instance
                  ;; Set keybindings
                  "bind -M insert \\cq exit"
                  "bind -M insert \\ck up-or-search"
                  "bind -M insert \\ck up-or-search"
                  "bind -M insert \\cj down-or-search"
                  "bind -M insert \\cp up-or-search"
                  "bind -M insert \\cn complete"
                  "bind -M insert \\cs pager-toggle-search"
                  "bind -M insert -k nul accept-autosuggestion"
                  "bind -M insert \\cc cancel-commandline repaint-mode"
                  (string-append "bind \\cc 'commandline -f cancel-commandline; " 
                                  "set fish_bind_mode insert; " 
                                  "commandline -f repaint-mode'")))
            (environment-variables 
              `(("fish_greeting" . "") ;; Disable the fish greeting message
                ("fish_key_bindings" . "fish_vi_key_bindings") ;; Enable vi bindings
                ;; Set the fish syntax highligting colors
                ("fish_color_normal" . "white")
                ("fish_color_command" . "magenta")
                ("fish_color_quote" . "green")
                ("fish_color_redirection" . "blue")
                ("fish_color_end" . "white")
                ("fish_color_error" . "red --bold")
                ("fish_color_param" . "white")
                ("fish_color_comment" . "brblack --italics")
                ("fish_color_match" . "cyan --bold")
                ("fish_color_selection" . "--reverse")
                ("fish_color_search_match" . "--reverse")
                ("fish_color_operator" . "yellow")
                ("fish_color_escape" . "yellow")
                ("fish_color_cwd" . "yellow")
                ("fish_color_autosuggestion" . "brblack --italics")
                ("fish_color_user" . "blue")
                ("fish_color_host" . "blue")
                ("fish_color_host_remote" . "purple")
                ("fish_color_cancel" . "red")
                ;; Vi cursor style
                ("fish_cursor_default" . "block")
                ("fish_cursor_visual" . "block")
                ("fish_cursor_insert" . "line")
                ("fish_cursor_replace_one" . "underscore")
                ("fish_cursor_replace" . "underscore")))
            (aliases aliases)
            (abbreviations abbreviations)))))
