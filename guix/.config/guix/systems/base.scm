(define-module (delafthi system base)
  #:use-module (gnu)
  #:use-module (gnu packages)
  #:use-module (gnu service xorg)
  #:use-module (gnu system nss)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

;; Package module definition
(use-package-modules bootloaders
                     cups
                     certs
                     emacs
                     fonts
                     gnome
                     shells
                     suckless
                     wm
                     xorg)

;; Service module definition
(use-service-modules cups
                     desktop
                     dns
                     docker
                     networking
                     nfs
                     nix
                     pm
                     sound
                     virtualization
                     xorg)

;; Service definitions
(define %my-nfs-exports
  (exports '('("/srv/nfs" (string-append
                           "192.168.0.100/24(rw,sync,no_root_squash,"
                           "no_all_squash,no_subtree_check)")))))


(define %my-xorg-config
  (string-append
   "\n"
   "Section \"InputClass\"\n"
   "  Identifier \"Touchpads\"\n"
   "  Driver \"libinput\"\n"
   "  MatchDevicePath \"/dev/input/event*\"\n"
   "  MatchIsTouchpad \"on\"\n"
   "\n"
   "  Option \"ClickMethod\" \"clickfinger\"\n"
   "  Option \"DisableWhileTyping\" \"on\"\n"
   "  Option \"NaturalScrolling\" \"on\"\n"
   "  Option \"ScrollMethod\" \"twofinger\"\n"
   "  Option \"Tapping\" \"false\"\n"
   "EndSection\n"
   "Section \"InputClass\"\n"
   "  Identifier \"Keyboards\"\n"
   "  Driver \"libinput\"\n"
   "  MatchDevicePath \"/dev/input/event*\"\n"
   "  MatchIsKeyboard \"on\"\n"
   "EndSection\n"))

(screen-locker-service slock "slock")

(define %my-backlight-rule
  (udev-rule "90-backlight.rules"
             (string-append
              "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
              "RUN+=\"/run/current-system/profile/bin/chgrp video "
              "/sys/class/backlight/%k/brightness\""
              "/n"
              "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
              "RUN+=\"/run/current/system/profile/bin/chmod g+w "
              "/sys/class/backlight/%k/brightness\"")))

;; Base system
(define-public %base-system
  (operating-system
   (kernel linux)
   (keyboard-layout (keyboard-layout "us" "dvorak-altgr-intl"))
   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '( "/boot/efi"))
                (keyboard-layout keyboard-layout)))
   (initrd microcode-initrd)
   (firmware '(linux-firmware))
   (file-systems (cons* (file-system
                          (device "/dev/mapper/cryptroot")
                          (mount-point "/")
                          (type "btrfs")
                          (options "subvol=@,ssd,compress=zstd,noatime,nodiratime")
                          (dependencies mapped-devices))
                        (file-system
                          (device "/dev/mapper/cryptroot")
                          (mount-point "/home")
                          (type "btrfs")
                          (options "subvol=@home,ssd,compress=zstd,noatime,nodiratime")
                          (dependencies mapped-devices))))
   %base-file-systems)
  (swap-devices '((swap-space
                  (target "/swap/swapfile")
                  (dependencies file-systems))))
  (users (cons (user-account
                (name "delafthi")
                (group "users")
                (comment "Thierry Delafontaine")
                (home-directory "/home/thierryd")
                (supplementary-groups '("audio"
                                        "docker"
                                        "kvm"
                                        "lp"
                                        "netdev"
                                        "tty"
                                        "video"
                                        "wheel"))
                (shell (file-append fish "/bin/fish"))))
         %base-user-accounts)
  (packages (cons*
              ;; Base packages
              alsa-utils
              aspell aspell-dict-en aspell-dict-de aspell-dict-fr
              btrfs-progs
              bash bash-completion
              bluez bluez-alsa
              btrfs-progs
              curl
              dosfstools
              exfat-utils
              font-victor-mono
              fontconfig
              git
              gnupg
              guile
              mesa
              nss-certs
              nss-mdns
              openssh
              sshfs
              vulkan-tools
              wget
              xdg-user-dirs
              xdg-utils
              xdotool
              xf86-input-libinput
              xf86-video-amdgpu
              xf86-video-intel
              xf86-video-vesa

              ;; Utilities
              bat
              exa
              fd
              fzf
              fzy
              hexyl
              htop
              minicom
              mlocate
              neofetch
              neovim
              nix
              nmap
              openconnect
              openvpn
              pandoc
              password-store
              ripgrep
              rsync
              stow
              tar
              tmux
              unrar
              unzip
              zip

              ;; GUI packages
              awesome
              blueman
              breeze-icons
              feh
              gtk+
              kitty
              mpv
              nordic-theme
              papirus-icon-theme
              pavucontrol
              pcmanfm
              qutebrowser
              rofi rofi-pass
              unclutter
              virt-manager
              xclip
              xrandr
              xss-lock
              xterm
              zathura zathura-pdf-poppler

              ;; Dev
              cmake
              docker
              emacs emacs-guix
              libvirt
              ninja
              openjdk
              openocd
              subversion
              texlive
              valgrind

              ;; Misc
              blender
              gimp
              inkscape
              libreoffice)
            %base-packages)
  (timezone "Europe/Zurich")
  (locale "en_US.utf8")
  (name-service-switch %mdns-host-lookup-nss)
  (services (cons* (bluetooth-service #:auto-enable? #t)
                   (service cups-service-type (cups-configuration
                                                 (web-interface? #t)
                                                 (extensions '(cups-filters))))
                   (service dnsmasq-service-type (dnsmasq-configuration
                                                   (port 0)
                                                   (tftp-enable? #t)
                                                   (tftp-root "/srv/tftp")
                                                   (tftp-unique-root #t)))
                   (service docker-service-type)
                   (service libvirt-service-type)
                   (service nfs-service-type
                             (nfs-configuration %my-nfs-exports))
                   (service nix-service-type)
                   (service slim-service-type
                             (slim-configuration
                               (xorg-configuration
                                 (keyboard-layout keyboard-layout)
                                 (extra-config '(%my-xorg-config)))))
                   (service thermald-service-type)
                   (modify-services %desktop-services
                                     (delete gdm-service-type)
                                     (network-manager-service-type config =>
                                                                   (network-manager-configuration
                                                                   (inherit config)
                                                                   (vpn-plugins '(network-manager-openvpn
                                                                                   network-manager-openconnect))))
                                     (udev-service-type config =>
                                                       (udev-configuration
                                                         (inherit config)
                                                         (rules (cons %my-backlight-rule
                                                                       (udev-configuration-rules config)))))))))
