(define-module (system homestation)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu services)
  #:use-module (gnu services pm)
  #:use-module ((system delafthi) #:prefix delafthi:))

(define luks-mapped-devices
  (list (mapped-device
    (source (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"))
    (target "cryptroot")
    (type luks-device-mapping))))

(define file-systems
  (cons*
    (file-system
      (device (uuid "xxxx-xxxx" 'fat))
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

(operating-system
  (inherit delafthi:system)
  (host-name "homestation")
  (mapped-devices luks-mapped-devices)
  (file-systems file-systems)
  (swap-devices (list
    (swap-space
      (target "/var/swapfile")))))
