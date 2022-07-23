(define-module (home delafthi init)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages)
  #:use-module (gnu packages compton)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu services)
  #:use-module (guix gexp))

(define-public services
  (list (simple-service 'applet-service
          home-shepherd-service-type
          (list (shepherd-service
                  (documentation "Starts the blueman applet.")
                  (provision (list 'blueman-applet))
                  (start #~(make-forkexec-constructor
                             (list #$(file-append blueman
                                                  "/bin/blueman-applet")))))
                (shepherd-service
                  (documentation "Starts the network-manager applet.")
                  (provision (list 'nm-applet
                                   network-manager-applet))
                  (start #~(make-forkexec-constructor
                             (list #$(file-append network-manager-applet 
                                                  "/bin/nm-applet")))))
                (shepherd-service
                  (documentation "starts the volumeicon applet.")
                  (provision (list volumeicon
                                   'volumeicon-applet))
                  (start #~(make-forkexec-constructor
                             (list #$(file-append volumeicon
                                                  "/bin/volumeicon")))))))
        (simple-service 'picom-service
          home-shepherd-service-type
          (list (shepherd-service
                  (documentation "Starts the picom compositor.")
                  (provision (list picom))
                  (start #~(make-forkexec-constructor
                             (list #$(file-append picom "/bin/picom")))))))
        (simple-service 'unclutter-service
          home-shepherd-service-type
          (list (shepherd-service
                  (documentation "Starts unclutter.")
                  (provision (list unclutter))
                  (start #~(make-forkexec-constructor
                             (list #$(file-append unclutter "/bin/unclutter")
                                   "--timeout 10"))))))
        (simple-service 'xss-lock-service
          home-shepherd-service-type
          (list (shepherd-service
                  (documentation "Starts xss-lock.")
                  (provision (list xss-lock))
                  (start #~(make-forkexec-constructor
                             (list #$(file-append xss-lock "/bin/xss-lock")
                                   #$(file-append slock "/bin/slock")))))))
        (simple-service 'xsetroot-service 
          home-shepherd-service-type
          (list (shepherd-service
                  (documentation "Runs xsetroot for the left pointer.")
                  (provision (list xsetroot))
                  (one-shot? #t)
                  (start #~(make-forkexec-constructor
                             (list #$(file-append xsetroot "/bin/xsetroot")
                                   "-cursor-name left_ptr"))))))))

