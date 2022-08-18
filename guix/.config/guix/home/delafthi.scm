  #:use-module (gnu home)
  #:use-module (home delafthi packages)
  #:use-module (home delafthi services))

(home-environment
  (append
    misc-packages
    utils-packages
    networking-packages
    bluetooth-packages
    extra-utils-packages
    wm-packages
    dev-packages
    python-packages
    cpp-packages
    lang-packages
    gui-packages
    extra-packages)))
  (services services))
