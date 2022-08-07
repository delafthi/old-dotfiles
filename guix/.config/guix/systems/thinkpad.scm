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
  #:use-module ((systems delafthi) #:prefix delafthi:))

(define luks-mapped-devices
  (list (mapped-device
         (source (uuid "dc1c3de7-a081-4866-b8bd-363da8a41766"))
         (target "cryptroot")
         (type luks-device-mapping))))

(define file-systems
  (cons* (file-system
          (device (uuid "D132-B4FE" 'fat))
          (mount-point "/boot/efi")
          (type "vfat"))
         (file-system
          (device "/dev/mapper/cryptroot")
          (mount-point "/")
          (type "btrfs")
          (options "subvol=@,ssd,compress=zstd,noatime,nodiratime")
          (dependencies luks-mapped-devices))
         (file-system
          (device "/dev/mapper/cryptroot")
          (mount-point "/home")
          (type "btrfs")
          (options "subvol=@home,ssd,compress=zstd,noatime,nodiratime")
          (dependencies luks-mapped-devices))
         %base-file-systems))

(define packages
  (append
   (map specification->package
        (list "mesa"
              "vulkan-tools"
              "xf86-input-libinput"
              "xf86-video-amdgpu"
              "xf86-video-intel"
              "xf86-video-vesa"))
   delafthi:packages))

(define services
  (append (list (service tlp-service-type
                         (tlp-configuration
                          (cpu-boost-on-ac? #t))))
          delafthi:services))

(define system
  (operating-system
   (inherit delafthi:system)
   (keyboard-layout (keyboard-layout "us" "dvorak-altgr-intl,nodeadkeys"))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (target "/boot/efi")
     (keyboard-layout keyboard-layout)))
   (host-name "thinkpad")
   (mapped-devices luks-mapped-devices)
   (file-systems file-systems)
   (swap-devices
    (list (swap-space (target "/var/swapfile"))))
   (packages packages)
   (services (modify-services services
                              (set-xorg-configuration
                               (xorg-configuration
                                (keyboard-layout keyboard-layout)))))))

system
