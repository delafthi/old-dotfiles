(define-module (system delafthi)
  #:use-module (guix gexp)
  #:use-module (gnu system)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages shells)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services dns)
  #:use-module (gnu services docker)
  #:use-module (gnu services linux)
  #:use-module (gnu services nfs)
  #:use-module (gnu services nix)
  #:use-module (gnu services virtualization)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages linux)
  #:use-module ((system desktop) #:prefix desktop:))

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

(define-public packages
  (append 
    (map specification->package
      (list "gnupg"
            "openssh"))
    desktop:packages))

(define-public services
  (cons* (service docker-service-type)
         (service dnsmasq-service-type
           (dnsmasq-configuration
             (tftp-enable? #t)
             (tftp-root "/srv/tftp")
             (tftp-unique-root (list "ip"))))
         (service kernel-module-loader-service-type (list "acpi_call"))
         (service libvirt-service-type)
         (service nfs-service-type
           (nfs-configuration
             (exports
               (list `("/srv/nfs" "192.168.0.10/24(rw,sync,no_root_squash,no_all_squash,no_subtree_check)")))))
         (service nix-service-type)
         (modify-services desktop:services
           (guix-service-type config =>
             (guix-configuration
               (inherit config)
               (substitute-urls
                 (cons "https://substitutes.nonguix.org" 
                       %default-substitute-urls))
               (authorized-keys
                 (cons (local-file "../keys/nonguix.pub")
                       %default-authorized-guix-keys)))))))

(define-public system
  (operating-system
    (inherit desktop:system)
    (kernel linux)
    (kernel-loadable-modules (list acpi-call-linux-module))
    (initrd microcode-initrd)
    (firmware (list linux-firmware))
    (host-name "delafthi")
    (users users)
    (packages packages)
    (services services)))
