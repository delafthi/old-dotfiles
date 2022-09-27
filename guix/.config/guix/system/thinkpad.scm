(define-module (system thinkpad)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services pm)
  #:use-module (gnu services xorg)
  #:use-module ((system delafthi) #:prefix delafthi:))

(define luks-mapped-devices
  (list (mapped-device
         (source (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"))
         (target "cryptroot")
         (type luks-device-mapping))))

(define file-systems
  (cons* (file-system
          (device (uuid "XXXX-XXXX" 'fat))
          (mount-point "/boot")
          (type "vfat"))
         (file-system
          (device "/dev/mapper/cryptroot")
          (mount-point "/")
          (type "btrfs")
          (options "subvol=@,compress=zstd,space_cache=v2")
          (dependencies luks-mapped-devices))
         (file-system
          (device "/dev/mapper/cryptroot")
          (mount-point "/home")
          (type "btrfs")
          (options "subvol=@home,compress=zstd,space_cache=v2")
          (dependencies luks-mapped-devices))
         %base-file-systems))

(define services
  (append
   (list (service thermald-service-type)
         (service tlp-service-type
                  (tlp-configuration
                   (cpu-boost-on-ac? #t))))
   delafthi:services))

(define system
  (operating-system
   (inherit delafthi:system)
   (keyboard-layout (keyboard-layout "us" "dvorak" #:model "thinkpad"))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot"))
     (keyboard-layout keyboard-layout)))
   (host-name "thinkpad")
   (mapped-devices luks-mapped-devices)
   (file-systems file-systems)
   (swap-devices (list (swap-space (target "/swap/swapfile"))))
   (services
    (modify-services
     services
     (greetd-service-type config =>
                          (greetd-configuration
                           (inherit config)
                           (terminals
                            (cons (greetd-terminal-configuration
                                   (terminal-vt "1")
                                   (terminal-switch #t)
                                   (default-session-command
                                     (greetd-agreety-session
                                      (command
                                       (xorg-start-command
                                        (xorg-configuration
                                         (inherit delafthi:xorg-config)
                                         (keyboard-layout keyboard-layout))))
                                      (command-args '()))))
                                  (cdr delafthi:greetd-terminals)))))))))

system
