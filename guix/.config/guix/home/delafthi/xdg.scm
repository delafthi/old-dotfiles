(define-module (home delafthi xdg)
  #:use-module (gnu home services)
  #:use-module (gnu home services xdg)
  #:use-module (gnu packages))

(define-public packages
  (map specification->package
    (list "xdg-utils")))

(define-public services
  (list (service home-xdg-mime-applications-service-type
          (home-xdg-mime-applications-configuration
            (default
              `((x-scheme-handler/msteams . teams.desktop)
                (application/pdf . org.pwmt.zathura.desktop)
                (x-scheme-handler/http . qutebrowser.desktop)
                (x-scheme-handler/https . qutebrowser.desktop)
                (x-scheme-handler/unknown . neovim.desktop)))))
        (service home-xdg-user-directories-service-type
          (home-xdg-user-directories-configuration
            (download "$HOME/downloads")
            (videos "$HOME/videos")
            (music "$HOME/music")
            (pictures "$HOME/pictures")
            (documents "$HOME/documents")
            (publicshare "$HOME/public")
            (templates "$HOME/templates")
            (desktop "$HOME")))))
