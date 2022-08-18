(define-module (systems homestation)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu packages)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services linux)
  #:use-module (gnu services xorg)
  #:use-module (nongnu packages nvidia)
  #:use-module (guix transformations)
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
          (options "subvol=@,compress=zstd,space_cache=v2")
          (dependencies luks-mapped-devices))
         %base-file-systems))

(define services
  (append
   (list (set-xorg-configuration
          (xorg-configuration
           (drivers (list "nvidia"))
           (keyboard-layout keyboard-layout)
           (modules (cons nvidia-driver
                          %default-xorg-modules))
           (server ((options->transformation '((with-graft . "mesa=nvda")))
                    xorg-server))))
         (udev-rules-service 'nvidia-driver nvidia-driver))
   (modify-services
    desktop:services
    (kernel-module-loader-service-type modules =>
                                       (append (list "ipmi_devintf"
                                                     "nvidia"
                                                     "nvidia_modeset"
                                                     "nvidia_uvm")
                                               modules)))))

(define system
  (operating-system
   (inherit desktop:system)
   (kernel-arguments
    (append (list "modprobe.blacklist=nouveau"
                  "amd_iommu=on"
                  "iommu=pt"
                  "modprobe.blacklist=nouveau"
                  %default-kernel-arguments))
    (kernel-loadable-modules (cons nvidia-driver
                                   (operating-system-kernel-loadable-modules
                                    desktop:system)))
    (host-name "homestation")
    (file-systems file-systems)
    (swap-devices
     (list (swap-space (target "/swap/swapfile")))))
   (services services)))

system
