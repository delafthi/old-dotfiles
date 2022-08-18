(define-module (systems delafthi)
  #:use-module (guix gexp)
  #:use-module (gnu system)
  #:use-module (gnu system setuid)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages nfs)
  #:use-module (gnu packages shells)
  #:use-module (gnu services)
  #:use-module (gnu services avahi)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (gnu services base)
  #:use-module (gnu services cups)
  #:use-module (gnu services dns)
  #:use-module (gnu services docker)
  #:use-module (gnu services linux)
  #:use-module (gnu services networking)
  #:use-module (gnu services nfs)
  #:use-module (gnu services nix)
  #:use-module (gnu services pm)
  #:use-module (gnu services sound)
  #:use-module (gnu services virtualization)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages linux)
  #:use-module ((systems base) #:prefix base:))

(define-public packages
  (append
   (map specification->package
        (list "alsa-utils"
              "curl"
              "libtool"
              "make"
              "nmap"
              "pkg-config"
              "rsync"
              "sshfs"
              "tmux"
              "wget"
              "xdg-user-dirs"
              "xdg-utils"))
   base:packages))

(define-public services
  (append (list
           (accountsservice-service)
           (service alsa-service-type)
           (service avahi-service-type)
           (service colord-service-type)
           (service cups-pk-helper-service-type)
           (service cups-service-type
                    (cups-configuration
                     (default-paper-size "A4")
                     (web-interface? #t)))
           (dbus-service)
           (service docker-service-type)
           (service dnsmasq-service-type
                    (dnsmasq-configuration
                     (tftp-enable? #t)
                     (tftp-root "/srv/tftp")
                     (tftp-unique-root (list "ip"))))
           (elogind-service #:config
                            (elogind-configuration
                             (handle-lid-switch 'suspend)
                             (handle-lid-switch-external-power 'suspend)
                             (handle-lid-switch-docked 'ignore)))
           (service kernel-module-loader-service-type (list "acpi_call"))
           (service libvirt-service-type)
           (service modem-manager-service-type)
           (service network-manager-service-type
                    (network-manager-configuration
                     (dns "dnsmasq")
                     (vpn-plugins(list network-manager-openvpn
                                       network-manager-openconnect))))
           (service nfs-service-type
                    (nfs-configuration
                     (exports
                      (list `("/srv/nfs" "192.168.0.0/24(rw,sync,no_root_squash,no_all_squash,no_subtree_check)")))))
           (service nftables-service-type)
           (service nix-service-type)
           (service ntp-service-type)
           polkit-wheel-service
           (service polkit-service-type)
           (service pulseaudio-service-type)
           (service sane-service-type)
           (simple-service 'mount-setuid-helpers setuid-program-service-type
                           (map (lambda (program)
                                  (setuid-program
                                   (program program)))
                                (list (file-append nfs-utils "/sbin/mount.nfs")
                                      (file-append ntfs-3g
                                                   "/sbin/mount.ntfs-3g"))))
           (service thermald-service-type)
           (simple-service 'mtp udev-service-type (list libmtp))
           (simple-service 'light udev-service-type (list light))
           (udisks-service)
           (service upower-service-type)
           (service usb-modeswitch-service-type)
           (service wpa-supplicant-service-type))
          (modify-services
           %base-services
           (guix-service-type config =>
                              (guix-configuration
                               (inherit config)
                               (substitute-urls
                                (cons "https://substitutes.nonguix.org"
                                      %default-substitute-urls))
                               (authorized-keys
                                (cons (local-file "../keys/nonguix.pub")
                                      %default-authorized-guix-keys)))))))

(define-public users
  (cons (user-account
         (name "delafthi")
         (group "users")
         (comment "Thierry Delafontaine")
         (home-directory "/home/thierryd")
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

(define-public system
  (operating-system
   (inherit base:system)
   (kernel linux)
   (kernel-loadable-modules (list acpi-call-linux-module))
   (initrd microcode-initrd)
   (firmware (list linux-firmware))
   (host-name "delafthi")
   (users users)
   (packages packages)
   (services services)))
