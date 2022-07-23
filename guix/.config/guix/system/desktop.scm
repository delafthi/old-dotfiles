(define-module (system desktop)
  #:use-module (guix gexp)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages suckless)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services cups)
  #:use-module (gnu services desktop)
  #:use-module (gnu services networking)
  #:use-module (gnu services sddm)
  #:use-module (gnu services xorg)
  #:use-module ((system base) #:prefix base:))

(define-public packages
  (append
    (map specification->package
         (list "awesome"
               "bluez-alsa"
               "gtk+"
               "gtk-engines"
               "libva-utils"
               "xclip"
               "xdotool"
               "xrandr"
               "xss-lock"
               "xterm"))
    base:packages))

(define-public services
  (append
    (list (service bluetooth-service-type
            (bluetooth-configuration
              (auto-enable? #t)))
          (service cups-service-type
            (cups-configuration
              (default-paper-size "A4")
              (web-interface? #t)))
          (service screen-locker-service-type
            (screen-locker "slock" (file-append slock "/bin/slock") #f)))
    (modify-services %desktop-services
      (elogind-service-type config =>
        (elogind-configuration
          (inherit config)
          (handle-lid-switch 'suspend)
          (handle-lid-switch-external-power 'suspend)
          (handle-lid-switch-docked 'ignore)))
      (delete gdm-service-type)
      (network-manager-service-type config =>
        (network-manager-configuration
          (inherit config)
          (dns "dnsmasq")
          (vpn-plugins
            (list network-manager-openvpn
                  network-manager-openconnect))))
      (sddm-service-type config =>
        (sddm-configuration
          (inherit config)
          (numlock "on")
          (xorg-configuration
            (keyboard-layout keyboard-layout))))
      (udev-service-type config =>
        (udev-configuration
          (inherit config)
          (rules
            (cons light
                  (udev-configuration-rules config))))))))

(define-public system
  (operating-system
    (inherit base:system)
    (host-name "desktop")
    (packages packages)
    (services services)))
