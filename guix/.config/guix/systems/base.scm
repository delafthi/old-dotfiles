(define-module (systems base)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system nss)
  #:use-module (gnu packages))

(define-public packages
  (append
   (map specification->package
        (list "btrfs-progs"
              "dbus"
              "dosfstools"
              "emacs" "emacs-guix"
              "exfat-utils"
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

(define-public system
  (operating-system
   (keyboard-layout (keyboard-layout "us" "altgr-intl"))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot/efi"))
     (keyboard-layout keyboard-layout)))
   (host-name "base")
   (file-systems (list ))
   (packages packages)
   (timezone "Europe/Zurich")
   (locale "en_US.utf8")
   (name-service-switch %mdns-host-lookup-nss)))
