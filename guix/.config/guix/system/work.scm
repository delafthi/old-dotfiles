(define-module (system work)
  #:use-module (gnu system)
  #:use-module (gnu system accounts)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system shadow)
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
  #:use-module ((system delafthi) #:prefix delafthi:))

(define file-systems
  (cons* (file-system
          (device (uuid "XXXX-XXXX" 'fat))
          (mount-point "/boot")
          (type "vfat"))
         (file-system
          (device (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"))
          (mount-point "/")
          (type "btrfs")
          (options "subvol=@,compress=zstd,space_cache=v2"))
         (file-system
          (device (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"))
          (mount-point "/home")
          (type "btrfs")
          (options "subvol=@home,compress=zstd,space_cache=v2"))
         (file-system
          (device (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"))
          (mount-point "/var")
          (type "btrfs")
          (options "subvol=@var,compress=zstd,space_cache=v2"))
         (file-system
          (device (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"))
          (mount-point "/data")
          (type "ext4"))
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
                      xorg-config))
            (command-args '()))))
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
         (service static-networking
                  (addresses
                   (list (network-address
                          (device "enp6s0")
                          (value "192.168.0.1/24"))))
                  (routes
                   (list (network-route
                          (destination "192.168.0.0/24")
                          (device "enp5s0")
                          (gateway "192.168.0.1"))))
                  (name-servers (list "160.85.192.100"
                                      "160.85.193.100"))))

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
                "seat"
                "tty"
                "video"
                "wheel"))
         (shell (file-append fish "/bin/fish")))
        %base-user-accounts))

(define system
  (operating-system
   (inherit delafthi:system)
   (kernel-arguments
    (append
     (list "i915.modeset=0"
           "modprobe.blacklist=nouveau")
     %default-kernel-arguments))
   (kernel-loadable-modules (cons nvidia-driver
                                  (operating-system-kernel-loadable-modules
                                   delafthi:system)))
   (host-name "CLT-DSK-T-6006")
   (file-systems file-systems)
   (swap-devices (list (swap-space (target "/swap/swapfile"))))
   (users users)
   (services services)))

system
