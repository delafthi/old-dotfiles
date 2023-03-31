(define-module (river)
  #:use-module (ice-9 format)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-171)
  #:export (river))

(define* (river #:key
                (startup-commands
                 '(("dbus-update-activation-environment"
                    "DISPLAY"
                    "WAYLAND_DISPLAY"
                    "XDG_SESSION_TYPE"
                    "XDG_CURRENT_DESKTOP")))
                (inputs '())
                (options '())
                (keymaps '())
                (mousemaps '())
                (window-rules '())
                (gsettings '())
                (layout-generator '()))
  (for-each  system
             (append
              (serialize-startup-commands startup-commands)
              (serialize-inputs inputs)
              (serialize-options options)
              (serialize-modes (append keymaps mousemaps))
              (serialize-keymaps keymaps)
              (serialize-mousemaps mousemaps)
              (serialize-gsettings gsettings)
              (serialize-layout-generator layout-generator))))

(define (serialize-startup-commands startup-commands)
  (map
   (lambda (cmd)
     (string-join
      (list
       "riverctl"
       "spawn"
       (string-append "\"" (serialize-expr cmd) "\""))))
   startup-commands))

(define (serialize-inputs inputs)
  (list-transduce
   tflatten
   rcons
   (map
    (lambda (input)
      (let ((cmd (car input))
            (settings (cdr input)))
        (map
         (lambda (setting)
           (string-join
            (list
             "riverctl"
             (serialize-expr cmd)
             (serialize-expr setting))))
         settings)))
    inputs)))

(define (serialize-options options)
  (map
   (lambda (option)
     (string-join
      (list
       "riverctl"
       (serialize-expr option))))
   options))

(define (serialize-modes maps)
  (list-transduce
   tflatten
   rcons
   (map
    (lambda (maps)
      (let ((modes (car maps)))
        (map
         (lambda (mode)
           (string-join
            (list
             "riverctl"
             "declare-mode"
             (serialize-expr mode))))
         modes)))
    maps)))

(define (serialize-keymaps keymaps)
  (list-transduce
   tflatten
   rcons
   (map
    (lambda (maps)
      (let ((modes (car maps))
            (bindings (cdr maps)))
        (map
         (lambda (mode)
           (map
            (lambda (binding)
              (string-join
               (cons*
                "riverctl"
                "map"
                (match binding
                       ((or
                         ("release"  expr ..1)
                         ('release  expr ..1))
                        (list
                         "-release"
                         (serialize-expr mode)
                         (serialize-expr expr)))
                       ((or
                         ("repeat" expr ..1)
                         ('repeat expr ..1))
                        (list
                         "-repeat"
                         (serialize-expr mode)
                         (serialize-expr expr)))
                       ((or
                         (("layout" . index) expr ..1)
                         (('layout . index) expr ..1))
                        (list
                         (string-append "-layout" " " (serialize-term index))
                         (serialize-expr mode)
                         (serialize-expr expr)))
                       ((expr ...)
                        (list
                         (serialize-expr mode)
                         (serialize-expr expr)))))))
            bindings))
         modes)))
    keymaps)))

(define (serialize-mousemaps mousemaps)
  (list-transduce
   tflatten
   rcons
   (map
    (lambda (maps)
      (let ((modes (car maps))
            (bindings (cdr maps)))
        (map
         (lambda (mode)
           (map
            (lambda (binding)
              (string-join
               (list
                "riverctl"
                "map-pointer"
                (serialize-expr mode)
                (serialize-expr binding))))
            bindings))
         modes)))
    mousemaps)))

(define (serialize-window-rules window-rules)
  (list-transduce
   tflatten
   rcons
   (map
    (lambda (rules)
      (let ((filtertype (car rules))
            (rules (cdr rules)))
        (map
         (lambda (rule)
           (let ((match-type (car rule))
                 (patterns (cdr rule)))
             (map
              (lambda (pattern)
                (string-join
                 (list
                  "riverctl"
                  (string-append (serialize-expr filtertype) "-add")
                  (serialize-expr match-type)
                  (serialize-expr pattern))))
              patterns)))
         rules)))
    window-rules)))

(define (serialize-gsettings gsettings)
  (list-transduce
   tflatten
   rcons
   (map
    (lambda (settings)
      (let ((schema (car settings))
            (children (cdr settings)))
        (map
         (lambda (child)
           (string-append

            "riverctl"
            " "
            "spawn"
            " "
            "\""
            (string-join
             (list
              "gsettings"
              "set"
              (serialize-expr schema)
              (serialize-expr child)))
            "\""))
         children)))
    gsettings)))

(define (serialize-layout-generator layout-generator)
  (let ((layout-generator (car layout-generator))
        (args (cdr layout-generator)))
    (list
     (string-append
      "riverctl"
      " "
      "spawn"
      " "
      "\""
      (string-join
       (cons
        (serialize-expr layout-generator)
        (map
         (lambda (arg)
           (serialize-expr arg))
         args)))
      "\""))))

(define* (serialize-expr expr . delimiters)
  (let ((delimiters
         (match delimiters
                ((head tail ..1) (cons head tail))
                ((head tail ...) (list head head))
                (_ (list " " " ")))))
    (match expr
           (("spawn" tail ..1)
            (string-append "spawn"
                           " "
                           "\""
                           (apply serialize-expr tail delimiters)
                           "\""))
           (('spawn tail ..1)
            (string-append "spawn"
                           " "
                           "\""
                           (apply serialize-expr tail delimiters)
                           "\""))
           ((head tail ..1)
            (string-join (list (apply serialize-expr head (cdr delimiters))
                               (apply serialize-expr tail delimiters))
                         (car delimiters)))
           ((head) (apply serialize-expr head (cdr delimiters)))
           ((? pair? p)
            (string-join (list (apply serialize-expr (car p) (cdr delimiters))
                               (apply serialize-expr (cdr p) (cdr delimiters)))
                         (car delimiters)))
           (term (serialize-term term)))))

(define (serialize-term term)
  (match term
         (#t "enabled")
         (#f "disabled")
         ((? symbol? e) (symbol->string e))
         ((? number? e) (number->string e))
         ((? string? e) e)
         ((e) (serialize-term e))
         (other
          (raise-exception
           (format #t
                   "'serialize-term' can only process bools, symbols, numbers, and strings. Provided:\n ~a"
                   other)))))

;; Testing
;; =======

(define (test-river)
  (define startup-commands
    '((foo bar baz)
      ("foo" "bar" "baz")
      "foo"
      foo))
  (define inputs
    '(((input . "foo-input") . ((setting-one . #t)
                                (setting-two . "foo")))
      (keyboard-layout . ((-variant intl us)))))
  (define options
    '((option-one . #t)
      ("option-two" . "foo")
      (option-three . 15)))
  (define keymaps
    '((("normal") . ((Mod4 Escape (spawn lockscreen))
                     (Mod4+Shift Enter (spawn rofi))
                     ((layout 5) Mod4 Enter (spawn term))))
      (("locked" "normal") . ((repeat XF86AudioRaiseVolume volume-up)
                              (repeat XF86AudioLowerVolume volume-down)
                              (XF86AudioMute volume-mute)))))
  (define mousemaps
    '((("normal") . ((Mod4 BTN_LEFT move-view)
                     (Mod4 BTN_RIGHT resize-view)))))
  (define window-rules
    '((float-filter . ((app-id . (float
                                  nm-connection-editor))
                       (title . (Picture-in-Picture
                                 "Save File"))))
      (csd-filter . ((app-id . (float
                                nm-connection-editor))
                     (title . (Picture-in-Picture
                               "Save File"))))))
  (define gsettings
    '(("org.gnome.desktop.interface" .
       ((gtk-theme . "Nordic")
        (icon-theme . "Papirus-Dark")
        (cursor-theme . "Breeze_Snow")
        (cursor-size . 24)))))
  (define layout-generator
    '("rivertile" . ((-view-padding . 5)
                     (-outer-padding . 5)
                     (-main-location . left)
                     (-main-count . 1)
                     (-main-ratio . "0.6"))))

  (map
   (lambda (test)
     (let ((is (car test))
           (should (cdr test)))
       (if (not (equal? is should))
           (let ()
             (display is)
             (display "\n")
             (display should))
           (display "Test passed\n"))))
   (list
    `(,(serialize-startup-commands startup-commands) .
      ("riverctl spawn \"foo bar baz\""
       "riverctl spawn \"foo bar baz\""
       "riverctl spawn \"foo\""
       "riverctl spawn \"foo\""))
    `(,(serialize-inputs inputs) .
      ("riverctl input foo-input setting-one enabled"
       "riverctl input foo-input setting-two foo"
       "riverctl keyboard-layout -variant intl us"))
    `(,(serialize-options options) .
      ("riverctl option-one enabled"
       "riverctl option-two foo"
       "riverctl option-three 15"))
    `(,(serialize-modes (append keymaps mousemaps)) .
      ("riverctl declare-mode normal"
       "riverctl declare-mode locked"
       "riverctl declare-mode normal"
       "riverctl declare-mode normal"))
    `(,(serialize-keymaps keymaps) .
      ("riverctl map normal Mod4 Escape spawn \"lockscreen\""
       "riverctl map normal Mod4+Shift Enter spawn \"rofi\""
       "riverctl map -layout 5 normal Mod4 Enter spawn \"term\""
       "riverctl map -repeat locked XF86AudioRaiseVolume volume-up"
       "riverctl map -repeat locked XF86AudioLowerVolume volume-down"
       "riverctl map locked XF86AudioMute volume-mute"
       "riverctl map -repeat normal XF86AudioRaiseVolume volume-up"
       "riverctl map -repeat normal XF86AudioLowerVolume volume-down"
       "riverctl map normal XF86AudioMute volume-mute"))
    `(,(serialize-mousemaps mousemaps) .
      ("riverctl map-pointer normal Mod4 BTN_LEFT move-view"
       "riverctl map-pointer normal Mod4 BTN_RIGHT resize-view"))
    `(,(serialize-window-rules window-rules) .
      ("riverctl float-filter-add app-id float"
       "riverctl float-filter-add app-id nm-connection-editor"
       "riverctl float-filter-add title Picture-in-Picture"
       "riverctl float-filter-add title Save File"
       "riverctl csd-filter-add app-id float"
       "riverctl csd-filter-add app-id nm-connection-editor"
       "riverctl csd-filter-add title Picture-in-Picture"
       "riverctl csd-filter-add title Save File"))
    `(,(serialize-gsettings gsettings) .
      ("riverctl spawn \"gsettings set org.gnome.desktop.interface gtk-theme Nordic\""
       "riverctl spawn \"gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark\""
       "riverctl spawn \"gsettings set org.gnome.desktop.interface cursor-theme Breeze_Snow\""
       "riverctl spawn \"gsettings set org.gnome.desktop.interface cursor-size 24\""))
    `(,(serialize-layout-generator layout-generator) .
      ("riverctl spawn \"rivertile -view-padding 5 -outer-padding 5 -main-location left -main-count 1 -main-ratio 0.6\"")))))
