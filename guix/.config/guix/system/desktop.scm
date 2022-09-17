(define-module (system desktop)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services linux)
  #:use-module (gnu services xorg)
  #:use-module (nongnu packages nvidia)
  #:use-module (guix transformations)
  #:use-module ((system delafthi) #:prefix delafthi:))

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

(define xorg-config
  (xorg-configuration
   (inherit delafthi:xorg-config)
   (drivers (list "nvidia"))
   (modules (cons nvidia-driver
                  %default-xorg-modules))
   (server
    ((options->transformation
      '((with-graft . "mesa=nvda")))
     xorg-server))))

(define greetd-terminals
  (cons (greetd-terminal-configuration
         (terminal-vt "1")
         (terminal-switch #t)
         (default-session-command
           (greetd-agreety-session
            (command (xorg-start-command
                      xorg-config)))))
        (cdr delafthi:greetd-terminals)))

(define services
  (cons (udev-rules-service 'nvidia-driver nvidia-driver)
        (modify-services
         delafthi:services
         (greetd-service-type config =>
                              (greetd-configuration
                               (inherit config)
                               (terminals greetd-terminals)))
         (kernel-module-loader-service-type modules =>
                                            (append
                                             (list "ipmi_devintf"
                                                   "nvidia"
                                                   "nvidia_modeset"
                                                   "nvidia_uvm")
                                             modules)))))

(define system
  (operating-system
   (inherit delafthi:system)
   (kernel-arguments
    (append
     (list "amd_iommu=on"
           "iommu=pt"
           "modprobe.blacklist=nouveau"
           %default-kernel-arguments))
    (kernel-loadable-modules (cons nvidia-driver
                                   (operating-system-kernel-loadable-modules
                                    delafthi:system)))
    (host-name "myome")
    (file-systems file-systems)
    (swap-devices (list (swap-space (target "/swap/swapfile")))))
   (services services)))

system
