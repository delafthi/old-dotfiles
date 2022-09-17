(define-module (home xdg)
  #:use-module (gnu home services)
  #:use-module (gnu home services xdg)
  #:use-module (gnu packages))

(define-public packages
  (specifications->packages
   (list "xdg-utils")))

(define-public services
  (list (service home-xdg-mime-applications-service-type
                 (home-xdg-mime-applications-configuration
                  (default (list (x-scheme-handler/msteams . teams.desktop)
                                 (application/pdf . org.pwmt.zathura.desktop)
                                 (text/plain . nvim.desktop)
                                 (x-scheme-handler/http . org.qutebrowser.qutebrowser.desktop)
                                 (x-scheme-handler/https . org.qutebrowser.qutebrowser.desktop)
                                 (x-scheme-handler/about . org.qutebrowser.qutebrowser.desktop)
                                 (x-scheme-handler/unknown . nvim.desktop)))))
        (service home-xdg-user-directories-service-type
                 (home-xdg-user-directories-configuration
                  (desktop "$HOME/desktop")
                  (documents "$HOME/documents")
                  (download "$HOME/downloads")
                  (music "$HOME/music")
                  (pictures "$HOME/pictures")
                  (publicshare "$HOME/public")
                  (videos "$HOME/videos")))))
