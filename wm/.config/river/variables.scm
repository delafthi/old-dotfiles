(define-module (variables)
  #:export (audio-next
            audio-play
            audio-prev
            audio-stop
            brightness-down
            brightness-up
            bib
            browser
            launcher
            lockscreen
            pass
            screenshot-area
            screenshot-full
            term
            volume-down
            volume-mic-mute
            volume-mute
            volume-up
            wob-socket))

(define wob-socket "$XDG_RUNTIME_DIR/wob.sock")
(define term "kitty")
(define launcher "rofi -no-lazy-grab -show drun -modi drun")
(define browser "qutebrowser")
(define lockscreen "swaylock -f")
(define pass "bwmenu --auto-lock 300 -c 15")
(define bib "papis --pick-lib -s picktool rofi open title:*")
(define volume-up (string-join
                   (list "pactl set-sink-volume @DEFAULT_SINK@ +5% &&"
                         "pactl get-sink-volume @DEFAULT_SINK@"
                         "| head -n 1"
                         "| awk '{print substr($5, 1, length($5)-1)}'"
                         ">" wob-socket)))
(define volume-down (string-join
                     (list "pactl set-sink-volume @DEFAULT_SINK@ -5% &&"
                           "pactl get-sink-volume @DEFAULT_SINK@"
                           "| head -n 1"
                           "| awk '{print substr($5, 1, length($5)-1)}'"
                           ">" wob-socket)))
(define volume-mute (string-join
                     (list "pactl set-sink-mute @DEFAULT_SINK@ toggle &&"
                           "pactl get-sink-volume @DEFAULT_SINK@"
                           "| awk '{print substr($5, 1, length($5)-1)}'"
                           ">" wob-socket)))
(define volume-mic-mute (string-join
                         (list "pactl set-sink-mute @DEFAULT_SOURCE@ toggle &&"
                               "pactl get-sink-volume @DEFAULT_SOURCE@"
                               "| awk '{print substr($5, 1, length($5)-1)}'"
                               ">" wob-socket)))
(define audio-play (string-join
                    (list "playerctl play-pause &&"
                          "sleep .1 &&"
                          "notify-send playmusic '$(playerctl status)'")))
(define audio-next (string-join
                    (list "playerctl next &&"
                          "sleep .1 &&"
                          "notify-send playmusic '$(playerctl status)'")))
(define audio-prev (string-join
                    (list "playerctl previous &&"
                          "sleep .1 &&"
                          "notify-send playmusic '$(playerctl status)'")))
(define audio-stop (string-join
                    (list "playerctl stop &&"
                          "sleep .1 &&"
                          "notify-send playmusic '$(playerctl status)'")))
(define brightness-up (string-join
                       (list "light -A 5 &&"
                             "light -G"
                             "| cut -d'.' -f1"
                             ">" wob-socket)))
(define brightness-down (string-join
                         (list "light -U 5 &&"
                               "light -G"
                               "| cut -d'.' -f1"
                               ">" wob-socket)))
(define screenshot-full "grimshot save screen ~/pictures/$(date +%Y%m%d%k%m%S).png")
(define screenshot-area "grimshot save area ~/pictures/$(date +%Y%m%d%k%m%S).png")
