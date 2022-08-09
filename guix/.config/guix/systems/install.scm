(define-module (systems install)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (gnu packages)
  #:use-module (nongnu packages linux)
  #:export (installation-os-nonfree))

(define packages
  (append (map specification->package
               (list "git"
                     "stow"
                     "vim"))
          (operating-system-packages installation-os)))

(define installation-os-nonfree
  (operating-system
   (inherit installation-os)
   (kernel linux)
   (firmware (list linux-firmware))
   (packages packages)))

installation-os-nonfree
