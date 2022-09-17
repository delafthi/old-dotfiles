(define-module (home misc)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp))

(define misc-configuration-dir
  "../../../../misc/")

(define-public packages
  (specifications->packages
   (list "gnupg"
         ;; "papis"
         "pinentry"
         "pinentry-rofi"
         "python-whoosh"
         "rbw"
         "rofi"
         ;; "snap-sync"
         ;; "snapper"
         "syncthing"
         ;; "zsa-wally-cli")))
         "zathura"
         "zathura-pdf-mupdf")))

(define-public services
  (list (simple-service 'gnupg-config
                        home-files-service-type
                        (list (".gnupg" ,(local-file
                                          (string-append misc-configuration-dir ".gnupg")
                                          :#recursive? #t))))
        (simple-service 'papis-config
                        home-xdg-configuration-files-service-type
                        (list ("papis/config" ,(local-file
                                                (string-append misc-configuration-dir ".config/papis/config")))))))
