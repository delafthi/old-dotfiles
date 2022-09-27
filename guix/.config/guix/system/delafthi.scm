(define-module (system delafthi)
  #:use-module (guix gexp)
  #:use-module (gnu system)
  #:use-module (gnu system setuid)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages nfs)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages tmux)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services)
  #:use-module (gnu services avahi)
  #:use-module (gnu services base)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (gnu services cups)
  #:use-module (gnu services dns)
  #:use-module (gnu services docker)
  #:use-module (gnu services linux)
  #:use-module (gnu services mcron)
  #:use-module (gnu services networking)
  #:use-module (gnu services nfs)
  #:use-module (gnu services pm)
  #:use-module (gnu services sound)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages linux)
  #:use-module ((system base) #:prefix base:)
  #:export (packages
            xorg-config
            greetd-terminals
            services
            system))

(define packages
  (append
   (list gnu-make
         nmap
         pavucontrol
         pinentry
         rsync
         sshfs
         tmux
         xclip
         xdotool
         xrandr
         xterm)
   base:packages))

(define xorg-config
  (xorg-configuration
   (keyboard-layout
    (operating-system-keyboard-layout
     base:system))))

(define greetd-terminals
  (cons (greetd-terminal-configuration
         (terminal-vt "1")
         (terminal-switch #t)
         (default-session-command
           (greetd-agreety-session
            (command (xorg-start-command
                      xorg-config))
            (command-args '()))))
        (cdr base:greetd-terminals)))

(define desktop-services
  (append
   (list (screen-locker-service slock)

         ;; Add udev rules for MTP devices so that non-root users can access
         ;; them.
         (simple-service 'mtp udev-service-type (list libmtp))
         ;; Add udev rules for scanners
         (service sane-service-type)
         ;; Add polkit rules, so that non-root users in the wheel group can
         ;; perform administrative tasks (similar to "sudo").
         polkit-wheel-service

         ;; Allow desktop users to also mount NTFS and NFS file systems
         ;; without root
         (simple-service 'mount-setuid-helpers setuid-program-service-type
                         (map (lambda (program)
                                (setuid-program
                                 (program program)))
                              (list (file-append nfs-utils "/sbin/mount.nfs")
                                    (file-append ntfs-3g
                                                 "/sbin/mount.ntfs-3g"))))

         ;; The global fontconfig cache directory can sometimes contain
         ;; stale entries, possibly referencing fonts that have been GC'd,
         ;; so mount it read-only.
         fontconfig-file-system-service

         ;; NetworkManager and plugins
         (service network-manager-service-type
                  (network-manager-configuration
                   (dns "dnsmasq")
                   (vpn-plugins(list network-manager-openvpn
                                     network-manager-openconnect))))
         (service wpa-supplicant-service-type) ;; Needed by NetworkManager
         (service modem-manager-service-type)
         (service usb-modeswitch-service-type)
         (service bluetooth-service-type
                  (bluetooth-configuration
                   (auto-enable? #t)))

         ;; The D-Bus clique
         (service avahi-service-type)
         (udisks-service)
         (service upower-service-type)
         (accountsservice-service)
         (service cups-pk-helper-service-type)
         (service colord-service-type)
         (geoclue-service)
         (service polkit-service-type)
         (service elogind-service-type)
         (dbus-service)

         (service ntp-service-type)

         x11-socket-directory-service

         (service alsa-service-type))
   (modify-services
    base:services
    (greetd-service-type config =>
                         (greetd-configuration
                          (inherit config)
                          (terminals greetd-terminals))))))

(define updatedb-job
  #~(job '(next-day)
         (lambda ()
           (execl (string-append #$findutils "/bin/updatedb")
                  "updatedb"
                  "--prunepaths=/gnu/store /srv /swap /tmp /var/tmp"))))

(define garbage-collector-job
  #~(job '(next-day)
         (lambda ()
           (execl (string-append #$guix "/bin/guix")
                  "guix"
                  "gc -F 50G"))))

(define services
  (append
   (list (service docker-service-type)
         (service cups-service-type
                  (cups-configuration
                   (default-paper-size "A4")
                   (web-interface? #t)))
         (service dnsmasq-service-type
                  (dnsmasq-configuration
                   (tftp-enable? #t)
                   (tftp-root "/srv/tftp")
                   (tftp-unique-root (list "ip"))))
         (simple-service 'garbage-collector-cron-job mcron-service-type
                         (list garbage-collector-job))
         (service kernel-module-loader-service-type (list "acpi_call"))
         (service libvirt-service-type)
         (udev-rules-service 'light light)
         (service nfs-service-type
                  (nfs-configuration
                   (exports
                    (list '("/srv/nfs" "192.168.0.0/24(rw,sync,no_root_squash,no_all_squash,no_subtree_check)")))))
         (service nftables-service-type)
         (udev-rules-service 'pipewire pipewire-0.3)
         (simple-service 'updatedb-cron-job mcron-service-type (list updatedb-job))
         (service tlp-service-type))
   desktop-services))

(define users
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

(define system
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
