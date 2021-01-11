Config { font = "xft:Victor Mono Nerd Font:regular:size=11:antialias=true"
        , additionalFonts = [ "xft:Victor Mono Nerd Font:regular:size=13:antialias=true"
                            , "xft:Victor Mono Nerd Font:regular:size=12:antialias=true"
                            ]
        , bgColor = "#282c34"
        , fgColor = "#abb2bf"
        , position = Static {xpos = 4, ypos = 4, width = 2552, height = 24 }
        , sepChar =  "%"   -- delineator between plugin names and straight text
        , alignSep = "}{"  -- separator between left-right alignment
        , lowerOnStart =     True    -- send to bottom of window stack on start
        , hideOnStart =      False   -- start with window unmapped (hidden)
        , allDesktops =      True    -- show on all desktops
        , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
        , pickBroadest =     False   -- choose widest display (multi-monitor)
        , persistent =       True    -- enable/disable hiding (True = disabled)
        , template = "<action=xdotool key super+shift+Return><fc=#c678dd><fn=1>  </fn></fc></action><fc=#5c6370><fn=2>|</fn></fc><fc=#98c379> %UnsafeStdinReader% </fc>}{<fc=#5c6370><fn=2>|</fn></fc><fc=#e06c75> %multicpu% </fc><fc=#5c6370><fn=2>|</fn></fc><fc=#e5c07b> %memory% </fc><fc=#5c6370><fn=2>|</fn></fc><fc=#c678dd> %date% </fc><fc=#5c6370><fn=2>|</fn></fc>%trayerpad%"
        , commands =
                    -- Allows xmonad to feed strings to xmobar
                    [ Run UnsafeStdinReader

                    -- network activity monitor (dynamic interface resolution)
                    , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                                         , "--Low"      , "1000"       -- units: B/s
                                         , "--High"     , "5000"       -- units: B/s
                                         --, "--low"      , "#98c379"
                                         --, "--normal"   , "#d19a66"
                                         --, "--high"     , "#e06c75"
                                         ] 10

                    -- cpu activity monitor
                    , Run MultiCpu       [ "--template" , " <nice>%"
                                         , "--Low"      , "50"         -- units: %
                                         , "--High"     , "85"         -- units: %
                                         --, "--low"      , "#98c379"
                                         --, "--normal"   , "#d19a66"
                                         --, "--high"     , "#e06c75"
                                         ] 10

                    -- cpu core temperature monitor
                    , Run MultiCoreTemp  [ "--template" , " <max>°C"
                                         , "--Low"      , "70"        -- units: °C
                                         , "--High"     , "80"        -- units: °C
                                         --, "--low"      , "#98c379"
                                         --, "--normal"   , "#d19a66"
                                         --, "--high"     , "#e06c75"
                                         ] 50

                    -- memory usage monitor
                    , Run Memory         [ "--template" , " <usedratio>%"
                                         , "--Low"      , "20"        -- units: %
                                         , "--High"     , "90"        -- units: %
                                         --, "--low"      , "#98c379"
                                         --, "--normal"   , "#d19a66"
                                         --, "--high"     , "#e06c75"
                                         ] 10

                    -- battery monitor
                    , Run Battery        [ "--template" , "<acstatus>"
                                         , "--Low"      , "20"        -- units: %
                                         , "--High"     , "80"        -- units: %
                                         , "--low"      , "#e06c75"
                                         , "--normal"   , "#d19a66"
                                         , "--high"     , "#98c379"

                                         , "--" -- battery specific options
                                                   -- discharging
                                                   , "-o"         , "<left>% (<timeleft>)"
                                                   -- discharging status high status
                                                   , "--highs"    , " "
                                                   -- discharging status medium status
                                                   , "--mediums"  , " "
                                                   -- discharging status low status
                                                   , "--lows"     , " "
                                                   -- AC "on" status
                                                   , "-O"	        , "<fc=#d19a66> Charging</fc>"
                                                   -- charged status
                                                   , "-i"	        , "<fc=#98c379> Charged</fc>"
                                                   -- Action to execute when battery falls under 10%
                                                   , "-A"         , "10"
                                                   , "-a"         , "notify-send -u critical 'Battery running out!!'"
                                         ] 50

                    -- time and date indicator
                    --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
                    , Run Date            " %a %_d.%m.%y %H:%M" "date" 10
                    -- Dynamically adjusts xmobar depending on the trayer size
                    , Run Com "/home/thierryd/.xmonad/trayer-padding-icon.sh" [] "trayerpad" 20
                    ]
        }
