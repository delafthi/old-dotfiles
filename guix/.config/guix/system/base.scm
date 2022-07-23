(define-module (system base)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system nss)
  #:use-module (gnu packages))

(define-public packages
  (append 
    (map specification->package
      (list "htop"
            "vim"
            "nss-certs"))
    %base-packages))

(define-public system
  (operating-system
    (keyboard-layout (keyboard-layout "us" "altgr-intl,nodeadkeys"))
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
