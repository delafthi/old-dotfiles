(define-module (home wm)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp))

(define wm-configuration-dir
  "../../../../wm/")

(define-public packages
  (specifications->packages
   (list "awesome"
         "nerd-font-victor-mono"
         "picom"
         "rofi")))

(define-public services
  (list (simple-service 'awesome-config
                        home-xdg-configuration-files-service-type
                        (list ("awesome" ,(local-file
                                           (string-append wm-configuration-dir ".config/awesome")
                                           :#recursive? #t))))
        (simple-service 'picom-config
                        home-xdg-configuration-files-service-type
                        (list ("picom/picom.conf" ,(local-file
                                                    (string-append wm-configuration-dir ".config/picom/picom.conf")))))
        (simple-service 'rofi-config
                        home-xdg-configuration-files-service-type
                        (list ("rofi" ,(local-file
                                        (string-append wm-configuration-dir ".config/rofi")
                                        :#recursive? #t))))))
