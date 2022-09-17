(define-module (home emacs)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (guix gexp))

(define emacs-configuration-dir
  "../../../../emacs/")

(define-public packages
  (specifications->packages
   (list "emacs"
         "nerd-font-victor-mono")))


(define-public services
  (list (simple-service 'emacs-config
                        home-files-service-type
                        (list (".emacs.d" ,(local-file
                                            (string-append nvim-configuration-dir ".emacs.d")
                                            :#recursive? #t))))))
