(define-module (systems thinkpad)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services pm)
  #:use-module (gnu services xorg)
  #:use-module ((systems desktop) #:prefix desktop:))

(define luks-mapped-devices
  (list (mapped-device
         (source (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"))
         (target "cryptroot")
         (type luks-device-mapping))))

(define file-systems
  (cons* (file-system
          (device (uuid "XXXX-XXXX" 'fat))
          (mount-point "/boot/efi")
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

(define packages
  (append
   (map specification->package
        (list "xf86-video-amdgpu"
              "xf86-video-intel"))
   desktop:packages))

(define services
  (append (list (service tlp-service-type
                         (tlp-configuration
                          (cpu-boost-on-ac? #t))))
          desktop:services))

(define system
  (operating-system
   (inherit desktop:system)
   (keyboard-layout (keyboard-layout "us" "dvorak" #:model "thinkpad"))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot/efi"))
     (keyboard-layout keyboard-layout)))
   (host-name "thinkpad")
   (mapped-devices luks-mapped-devices)
   (file-systems file-systems)
   (swap-devices
    (list (swap-space (target "/swap/swapfile"))))
   (packages packages)
   (services (append (list (set-xorg-configuration
                            (xorg-configuration
                             (keyboard-layout keyboard-layout))))
                     services))))

system
