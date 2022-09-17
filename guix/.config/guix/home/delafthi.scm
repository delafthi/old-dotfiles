(define-module (home delafthi)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu packages)
  #:use-module (gnu packages vim)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module ((home dev) #:prefix dev:)
  #:use-module ((home emacs) #:prefix emacs:)
  #:use-module ((home gui) #:prefix gui:)
  #:use-module ((home misc) #:prefix misc:)
  #:use-module ((home nvim) #:prefix nvim:)
  #:use-module ((home shells) #:prefix shells:)
  #:use-module ((home wm) #:prefix wm:)
  #:use-module ((home xdg) #:prefix xdg:)
  #:use-module ((home xorg) #:prefix xorg:))

(define-public delafthi
  (home-environment
   (packages
    (append dev:packages
            dev:c-packages
            dev:haskell-packages
            dev:java-packages
            dev:javascript-packages
            dev:lua-packages
            dev:markdown-packages
            dev:python-packages
            dev:r-packages
            dev:rust-packages
            dev:shell-packages
            dev:tex-packages
            dev:hdl-packages
            emacs:packages
            gui:packages
            misc:packages
            nvim:packages
            shells:packages
            wm:packages
            xdg:packages
            xorg:packages))

   (services
    (append dev:services
            emacs:services
            gui:services
            misc:services
            nvim:services
            shells:services
            wm:services
            xdg:services
            xorg:services))))

delafthi
