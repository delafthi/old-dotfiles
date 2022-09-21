(define-module (channels)
  #:use-module (guix channels))

(cons* (channel
        (name 'addguix)
        (url "https://github.com/delafthi/addguix")
        (introduction
         (make-channel-introduction
          "1e176ef6e7100b7e0512cc59f392e3a67e54f043"
          (openpgp-fingerprint
           "AD78 A74D D561 FC73 DD2F  9503 3F9D 47D5 0357 5097"))))
       (channel
        (name 'rde)
        (url "https://git.sr.ht/~abcdw/rde")
        (introduction
         (make-channel-introduction
          "257cebd587b66e4d865b3537a9a88cccd7107c95"
          (openpgp-fingerprint
           "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
       (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix.git")
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
        (name 'guix-gaming-games)
        (url "https://gitlab.com/guix-gaming-channels/games.git")
        (introduction
         (make-channel-introduction
          "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
          (openpgp-fingerprint
           "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))
       %default-channels)
