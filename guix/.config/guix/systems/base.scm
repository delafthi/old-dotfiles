(define-module (systems base)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system nss)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (guix gexp)
  #:export (packages
            services
            system))

(define packages
  (append
   (map specification->package
        (list "dosfstools"
              "emacs" "emacs-guix" "emacs-geiser"
              "git"
              "gnupg"
              "guile-readline"
              "man-db"
              "man-pages"
              "nss-certs"
              "openssh"
              "openssl"
              "texinfo"
              "vim"
              "wget"))
   %base-packages))

(define services
  (cons (service greetd-service-type
                 (greetd-configuration
                  (terminals
                   (list
                    (greetd-terminal-configuration
                     (terminal-vt "1") (terminal-switch #t))
                    (greetd-terminal-configuration (terminal-vt "2"))
                    (greetd-terminal-configuration (terminal-vt "3"))
                    (greetd-terminal-configuration (terminal-vt "4"))
                    (greetd-terminal-configuration (terminal-vt "5"))
                    (greetd-terminal-configuration (terminal-vt "6"))))))
        (modify-services
         %base-services
         (guix-service-type config =>
                            (guix-configuration
                             (inherit config)
                             (substitute-urls
                              (cons "https://substitutes.nonguix.org"
                                    %default-substitute-urls))
                             (authorized-keys
                              (cons (local-file "../keys/nonguix.pub")
                                    %default-authorized-guix-keys))))
         (delete login-service-type)
         (delete mingetty-service-type))))

(define system
  (operating-system
   (keyboard-layout (keyboard-layout "us" "altgr-intl"))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot/efi"))
     (keyboard-layout keyboard-layout)))
   (host-name "base")
   (file-systems '())
   (packages packages)
   (services services)
   (timezone "Europe/Zurich")
   (locale "en_US.utf8")
   (name-service-switch %mdns-host-lookup-nss)))
