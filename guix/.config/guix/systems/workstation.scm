(define-module (systems workstation)
  #:use-module (gnu system)
  #:use-module (gnu system accounts)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services linux)
  #:use-module (gnu services pm)
  #:use-module (gnu services xorg)
  #:use-module (nongnu packages nvidia)
  #:use-module (guix transformations)
  #:use-module (guix gexp)
  #:use-module ((systems delafthi) #:prefix delafthi:))

(define file-systems
  (cons* (file-system
          (device (uuid "" 'fat))
          (mount-point "/boot/efi")
          (type "vfat"))
         (file-system
          (device (uuid ""))
          (mount-point "/")
          (type "btrfs")
          (options "subvol=@,compress=zstd,space_cache=v2"))
         (file-system
          (device (uuid ""))
          (mount-point "/home")
          (type "btrfs")
          (options "subvol=@home,compress=zstd,space_cache=v2"))
         (file-system
          (device (uuid ""))
          (mount-point "/var")
          (type "btrfs")
          (options "subvol=@var,compress=zstd,space_cache=v2"))
         (file-system
          (device (uuid ""))
          (mount-point "/data")
          (type "ext4"))
         %base-file-systems))

(define users
  (cons (user-account
         (name "deaa")
         (group "users")
         (comment "Thierry Delafontaine")
         (home-directory "/home/deaa")
         (supplementary-groups
          (list "audio"
                "docker"
                "kvm"
                "lp"
                "netdev"
                "tty"
                "video"
                "wheel"))
         (shell (file-append fish "/bin/fish")))
        %base-user-accounts))

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
    delafthi:services
    (kernel-module-loader-service-type modules =>
                                       (append (list "ipmi_devintf"
                                                     "nvidia"
                                                     "nvidia_modeset"
                                                     "nvidia_uvm")
                                               modules)))))

(define system
  (operating-system
   (inherit delafthi:system)
   (kernel-arguments (append (list "modprobe.blacklist=nouveau")
                             %default-kernel-arguments))
   (kernel-loadable-modules (cons nvidia-driver
                                  (operating-system-kernel-loadable-modules
                                   delafthi:system)))
   (host-name "CLT-DSK-T-6006")
   (file-systems file-systems)
(swap-devices (list (swap-space (target (uuid "")))))
(users users)
(services services)))

system
