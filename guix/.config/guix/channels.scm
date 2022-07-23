(define-module (channels)
  #:use-module (guix channels))

(cons* (channel
         (name 'personal)
         (url "https://github.com/delafthi/guix-channel.git")
         (introduction
           (make-channel-introduction "1e176ef6e7100b7e0512cc59f392e3a67e54f043"
             (openpgp-fingerprint
               "AD78 A74D D561 FC73 DD2F  9503 3F9D 47D5 0357 5097"))))
       (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix.git")
        (introduction
          (make-channel-introduction "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       %default-channels)
