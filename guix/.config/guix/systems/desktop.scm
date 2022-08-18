(define-module (systems desktop)
  #:use-module (guix gexp)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages suckless)
  #:use-module (gnu services)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)
  #:use-module ((systems delafthi) #:prefix delafthi:))

(define-public packages
  (append
   (map specification->package
        (list "awesome"
              "blueman"
              "bluez" "bluez-alsa"
              "gtk+"
              "gtk-engines"
              "pavucontrol"
              "picom"
              "xclip"
              "xdotool"
              "xrandr"
              "xterm"))
   delafthi:packages))

(define-public services
  (append (list
           (service bluetooth-service-type
                    (bluetooth-configuration
                     (auto-enable? #t)))
           fontconfig-file-system-service
           (service gdm-service-type)
           (simple-service 'network-manager-applet
                           profile-service-type
                           (list network-manager-applet))
           (service screen-locker-service-type
                    (screen-locker "slock" (file-append slock "/bin/slock") #f))
           x11-socket-directory-service
           (set-xorg-configuration
            (xorg-configuration
             (keyboard-layout
              (operating-system-keyboard-layout delafthi:system)))))
          delafthi:services))

(define-public system
  (operating-system
   (inherit delafthi:system)
   (host-name "desktop")
   (packages packages)
   (services services)))
