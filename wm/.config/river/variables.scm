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

(define wob-socket "\\$XDG_RUNTIME_DIR/wob.sock")
(define term "kitty")
(define launcher "rofi -no-lazy-grab -show drun -modi drun")
(define browser "qutebrowser")
(define lockscreen "swaylock -f")
(define pass "bwmenu --auto-lock 300 -c 15")
(define bib "papis --pick-lib -s picktool rofi open title:*")
(define display-volume (string-join
                        (list
                         "if [ \\\"\\$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print \\$2}')\\\" == \\\"yes\\\" ];"
                         "then echo 0 >" wob-socket ";"
                         "else pactl get-sink-volume @DEFAULT_SINK@"
                         "| head -n 1"
                         "| awk '{print substr(\\$5, 1, length(\\$5)-1)}'"
                         ">" wob-socket ";"
                         "fi")))
(define volume-up (string-join
                   (list "pactl set-sink-volume @DEFAULT_SINK@ +5% &&"
                         display-volume)))
(define volume-down (string-join
                     (list "pactl set-sink-volume @DEFAULT_SINK@ -5% &&"
                           display-volume)))
(define volume-mute (string-join
                     (list "pactl set-sink-mute @DEFAULT_SINK@ toggle &&"
                           display-volume)))
(define volume-mic-mute (string-join
                         (list "pactl set-sink-mute @DEFAULT_SINK@ toggle &&"
                               display-volume)))
(define audio-play (string-join
                    (list "playerctl play-pause &&"
                          "sleep .1 &&"
                          "notify-send playmusic '\\$(playerctl status)'")))
(define audio-next (string-join
                    (list "playerctl next &&"
                          "sleep .1 &&"
                          "notify-send playmusic '\\$(playerctl status)'")))
(define audio-prev (string-join
                    (list "playerctl previous &&"
                          "sleep .1 &&"
                          "notify-send playmusic '\\$(playerctl status)'")))
(define audio-stop (string-join
                    (list "playerctl stop &&"
                          "sleep .1 &&"
                          "notify-send playmusic '\\$(playerctl status)'")))
(define display-brightness (string-join
                            (list
                             "light -G"
                             "| cut -d'.' -f1"
                             ">" wob-socket)))
(define brightness-up (string-join
                       (list "light -A 5 &&"
                             display-brightness)))
(define brightness-down (string-join
                         (list "light -U 5 &&"
                               display-brightness)))
(define screenshot-full "grimshot save screen ~/pictures/\\$(date +%Y%m%d%k%m%S).png")
(define screenshot-area "grimshot save area ~/pictures/\\$(date +%Y%m%d%k%m%S).png")

(display volume-mute)
