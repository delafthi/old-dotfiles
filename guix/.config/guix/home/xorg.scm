(define-module (home xorg)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp))

(define xorg-configuration-dir
  "../../../../xorg/")

(define-public packages
  (specifications->packages
   (list "awesome"
         "breeze-icons"
         "nerd-font-victor-mono"
         "pcmanfm"
         "picom"
         "unclutter")))

(define-public services
  (list (simple-service 'xorg-config
                        home-files-service-type
                        (list (".icons/default/index.theme" ,(local-file
                                                              (string-append xorg-configuration-dir ".icons/default-index.theme")))
                              (".xinitrc" ,(local-file
                                            (string-append xorg-configuration-dir ".xinitrc")))
                              (".xprofile" ,(local-file
                                             (string-append xorg-configuration-dir ".xprofile")))
                              (".Xresources" ,(local-file
                                               (string-append xorg-configuration-dir ".Xresources")))
                              (".Xresources.d" ,(local-file
                                                 (string-append xorg-configuration-dir ".Xresources.d")))
                              (".xserverrc" ,(local-file
                                              (string-append xorg-configuration-dir ".xserverrc")))))))
