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
  #:use-module (gnu services pm)
  #:use-module (gnu services xorg)
  #:use-module (nongnu packages nvidia)
  #:use-module (guix transformations)
  #:use-module ((systems delafthi) #:prefix delafthi:))

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
                    xorg-server)))))
   (modify-services
    delafthi:services
    (kernel-module-loader-service-type modules =>
                                       (append (list "nvidia"
                                                     "nvidia_modest"
                                                     "nvidia_uvm")
                                               modules))

    (udev-service-type config =>
                       (udev-configuration
                        (inherit config)
                        (rules
                         (cons nvidia-driver
                               (udev-configuration-rules config))))))))

(define system
  (operating-system
   (inherit delafthi:system)
   (kernel-arguments
    (append (list "amd_iommu=on"
                  "iommu=pt"
                  %default-kernel-arguments))
    (kernel-loadable-modules (cons nvidia-driver
                                   (operating-system-kernel-loadable-modules
                                    delafthi:system)))
    (host-name "homestation")
    (file-systems file-systems)
    (swap-devices (list (uuid "")))
    (services services)))

  system
