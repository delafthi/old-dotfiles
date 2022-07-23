(define-module (system homestation)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu packages)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services linux)
  #:use-module (gnu services pm)
  #:use-module (gnu services xorg)
  #:use-module (nongnu packages nvidia)
  #:use-module (guix transformations)
  #:use-module ((system delafthi) #:prefix delafthi:))

(define luks-mapped-devices
  (list (mapped-device
          (source (uuid "98758da2-6449-41c7-8629-dc5376b829a2"))
          (target "cryptroot")
          (type luks-device-mapping))))

(define file-systems
  (cons* (file-system
           (device (uuid "7857-6E91" 'fat))
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

(define-public packages
  delafthi:packages)

(define-public services
  (append
    (list (service kernel-module-loader-service-type (list "nvidia_uvm"))
          (set-xorg-configuration
            (xorg-configuration
              (drivers (list "nvidia"))
              (keyboard-layout keyboard-layout)
              (modules (cons*
                nvidia-driver
                %default-xorg-modules))
              (server 
                (options->transformation (list (with-graft . "mesa=nvda"))) 
                xorg-server))))
    (modify-services delafthi:services
      (udev-service-type config =>
        (udev-configuration)
        (inherit config)
        (rules
          (cons*
            nvdidia-driver
            (udev-configuration-rules config))))))))

(define-public homestation
  (operating-system
    (inherit delafthi:system)
    (kernel-arguments
      (cons* "modprobp.blacklist=nouveau"
            "amd_iommu=on"
            "iommu=pt"
            %default-kernel-arguments))
    (kernel-loadable-modules (list nvidia-driver))
    (host-name "homestation")
    (mapped-devices luks-mapped-devices)
    (file-systems file-systems)
    (swap-devices (list (swap-space (target "/var/swapfile"))))))

homestation
