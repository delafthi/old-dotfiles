(define-module (home gui)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp))

(define gui-configuration-dir
  "../../../../gui/")

(define-public packages
  (specifications->packages
   (list "blender"
         "breeze-icons"
         "darktable"
         "feh"
         "gimp"
         "hugin"
         "inkscape"
         ;; "wezterm"
         "mpv"
         "nerd-font-victor-mono" "font-openmoji"
         "nordic-theme"
         ;; "onlyoffice"
         "papirus-icon-theme"
         "qutebrowser"
         ;; "spotify"
         "virt-manager"
         "zathura" "zathura-pdf-mupdf")))

(define-public services
  (list (simple-service 'feh-config
                        home-xgd-configuration-files-service-type
                        (list ("feh/keys" ,(local-file
                                            (string-append gui-configuration-dir ".config/feh/keys")))))
        (simple-service 'fontconfig-config
                        home-xgd-configuration-files-service-type
                        (list ("fontconfig/fonts.conf" ,(local-file
                                                         (string-append gui-configuration-dir ".config/fontconfig/fonts.conf")))))
        (simple-service 'gtk2-config
                        home-files-service-type
                        (list (".gtkrc-2.0" ,(local-file
                                              (string-append gui-configuration-dir ".gtkrc-2.0")))))
        (simple-service 'gtk3-config
                        home-xgd-configuration-files-service-type
                        (list ("gtk-3.0/settings.ini" ,(local-file
                                                        (string-append gui-configuration-dir ".config/gtk-3.0/settings.ini")))))
        (simple-service 'wezterm-config
                        home-xgd-configuration-files-service-type
                        (list ("wezterm/wezterm.lua" ,(local-file
                                                       (string-append gui-configuration-dir ".config/wezterm/wezterm.lua")))))
        (simple-service 'mpv-config
                        home-xgd-configuration-files-service-type
                        (list ("mpv" ,(local-file
                                       (string-append gui-configuration-dir ".config/mpv")
                                       :#recursive? #t))))
        (simple-service 'qutebrowser-config
                        home-xdg-configuration-files-service-type
                        (list ("qutebrowser" ,(local-file
                                               (string-append gui-configuration-dir ".config/qutebrowser")
                                               :#recursive? #t))))
        (simple-service 'qutebrowser-bin-scripts
                        home-files-service-type
                        (list (".local/bin" ,(local-file
                                              (string-append gui-configuration-dir ".local/bin")
                                              #:recursive? #t))))
        (simple-service 'zathura-config
                        home-xdg-configuration-files-service-type
                        (list ("zathura/zathurarc" ,(local-file
                                                     (string-append gui-configuration-dir ".config/zathura/zathurarc")))))))
