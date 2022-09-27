(define-module (system base)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system nss)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages cryptsetup)
  #:use-module (gnu packages disk)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages file-systems)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages less)
  #:use-module (gnu packages man)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (guix gexp)
  #:export (packages
            greetd-terminals
            services
            system))

(define base-packages-interactive
  (list bash-completion
        emacs
        git
        gnupg
        guile-readline
        guile-colorized
        info-reader
        kbd
        less
        man-db
        man-pages
        sudo
        neovim))

(define base-packages-disk-utilities
  (list cryptsetup
        dosfstools
        btrfs-progs
        f2fs-tools
        jfsutils
        xfsprogs))

(define packages
  (append
   (list nss-certs
         openssh
         openssl
         texinfo)
   %base-packages-artwork
   base-packages-disk-utilities
   base-packages-interactive
   %base-packages-linux
   %base-packages-networking
   %base-packages-utils))

(define greetd-terminals
  (list (greetd-terminal-configuration (terminal-vt "1") (terminal-switch #t))
        (greetd-terminal-configuration (terminal-vt "2"))
        (greetd-terminal-configuration (terminal-vt "3"))
        (greetd-terminal-configuration (terminal-vt "4"))
        (greetd-terminal-configuration (terminal-vt "5"))
        (greetd-terminal-configuration (terminal-vt "6"))))

(define services
  (append
   (modify-services
    %base-services
    (guix-service-type config =>
                       (guix-configuration
                        (inherit config)
                        (substitute-urls
                         (cons* "https://substitutes.nonguix.org"
                                "http://ci.guix.trop.in"
                                %default-substitute-urls))
                        (authorized-keys
                         (cons (local-file "../keys/nonguix.pub")
                               %default-authorized-guix-keys))))
    (delete login-service-type)
    (delete mingetty-service-type))
   (list (service greetd-service-type
                  (greetd-configuration
                   (greeter-supplementary-groups (list "input" "video"))
                   (terminals greetd-terminals))))))

(define system
  (operating-system
   (keyboard-layout (keyboard-layout "us" "altgr-intl"))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot"))
     (keyboard-layout keyboard-layout)))
   (host-name "base")
   (file-systems '())
   (packages packages)
   (services services)
   (timezone "Europe/Zurich")
   (locale "en_US.utf8")
   (name-service-switch %mdns-host-lookup-nss)))
