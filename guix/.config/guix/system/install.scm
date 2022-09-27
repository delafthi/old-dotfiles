(define-module (system install)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim)
  #:use-module (nongnu packages linux)
  #:export (installation-os-nonfree))

(define packages
  (append
   (list git
         vim)
   (operating-system-packages installation-os)))

(define installation-os-nonfree
  (operating-system
   (inherit installation-os)
   (kernel linux)
   (firmware (list linux-firmware))
   (packages packages)))

installation-os-nonfree
