--------------------------------------------------------------------------------
-- Xmonad config file.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Imports:

-- Base
import XMonad
import System.IO (hPutStrLn, Handle)
import System.Exit
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.PhysicalScreens

-- Data
import Data.Monoid
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops

-- Layout
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane

-- Layout modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.Magnifier as Mag

-- Prompt

-- Utilities
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad

--------------------------------------------------------------------------------
-- Default applications

-- The preferred terminal program
myTerminal :: String
myTerminal = "alacritty"

-- The preferred browser
myBrowser :: String
myBrowser = "brave"

-- The preferred file manager
myFileBrowser :: String
myFileBrowser = "pcmanfm"

--------------------------------------------------------------------------------
-- Visual settings:

-- Default font
myFont :: String
myFont = "xft:Roboto Mono Nerd Font:regular:size=11:antialias=true:hinting=true"

-- Onehalf Colors
black :: String
black = "#282c34"
red :: String
red = "#e06c75"
green :: String
green = "#98c379"
yellow :: String
yellow = "#e5c07b"
blue :: String
blue = "#61afef"
magenta :: String
magenta = "#c678dd"
cyan :: String
cyan  = "#56b6c2"
white :: String
white  = "#dcdfe4"
blackLite :: String
blackLite = "#5c6370"

-- Width of the window border in pixels.
myBorderWidth :: Dimension
myBorderWidth = 3

-- Spacing between windows
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Border color for unfocused windows
myNormalBorderColor :: String
myNormalBorderColor = black

-- Border color for focused windows
myFocusedBorderColor :: String
myFocusedBorderColor = blue

-- Name of workspaces
xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
    where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable. (map xmobarEscape)
                $ ["www","dev","chat","virt","sys","mus","doc","vis"]
    where
        clickable l = ["<action=xdotool key super+" ++ show(n) ++ ">" ++ ws ++ "</action>"
                      | (i,ws) <- zip [1 .. 9] l,
                      let n = i
                      ]

-- Count windows
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

--------------------------------------------------------------------------------
-- Window rules:

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
    [ className =? "Gimp" --> doShift( myWorkspaces !! 7 )
    , className =? "Blender" --> doShift( myWorkspaces !! 7 )
    , className =? "Virt-manager" --> doShift( myWorkspaces !! 3 )
    , className =? "libreoffice-startcenter" --> doShift( myWorkspaces !! 6 )
    , resource =? "Dialog" --> doFloat
    , className =? "Pavucontrol" --> doFloat
    , className =? "Xmessage" --> doFloat
    , title =? "Microsoft Teams Notification" --> doFloat
    ] <+> namedScratchpadManageHook myNamedScratchpads

--------------------------------------------------------------------------------
-- Scratchpads

myNamedScratchpads :: [NamedScratchpad]
myNamedScratchpads = [ NS "terminal" spawnTerm findTerm manageTerm]
    where
        spawnTerm = myTerminal ++ " -t scratchpad"
        findTerm = (title =? "scratchpad")
        manageTerm = customFloating $ W.RationalRect l t w h
            where
                h = 0.9
                w = 0.9
                t = 0.95 - h
                l = 0.95 - w

--------------------------------------------------------------------------------
-- Layouts:

myLayoutHook = avoidStruts $
    tall
    ||| twopane
    ||| noBorders tabs
    where
        -- Tall layout
        tall = renamed[Replace "tall"]
            $ Mag.magnifierOff
            $ mySpacing spacing
            $ ResizableTall nmaster delta ratio []
        -- TwoPane layout
        twopane = renamed[Replace "twopane"]
            $ Mag.magnifierOff
            $ mySpacing spacing
            $ TwoPane delta ratio
        -- Tabbed full screen layout
        tabs = renamed[Replace "tabs"]
            $ tabbed shrinkText myTabConfig
        -- Spacing between windows
        spacing = 5
        -- Number of initial windows in the master pane
        nmaster = 1
        -- Default ratio between master and stack
        ratio = 1/2
        -- Delta value when increasing or decreasing window size
        delta = 3/100
        -- Config for tabbed layout
        myTabConfig = def { fontName = "xft:Roboto Mono Nerd Font:regular:size=11"
                          , activeColor = blue
                          , inactiveColor = black
                          , activeBorderColor = blue
                          , inactiveBorderColor = blackLite
                          , activeTextColor = black
                          , inactiveTextColor = blackLite
                          }

--------------------------------------------------------------------------------
-- Controls:

-- modMask lets you specify which modkey you want to use.
-- mod1Mask ("left alt")
-- mod3Mask ("right alt")
-- mod4Mask ("windows key")
myModMask :: KeyMask
myModMask = mod4Mask

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

--------------------------------------------------------------------------------
-- Key bindings:
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm              , xK_Return), spawn $ XMonad.terminal conf)

    -- launch scratchpad
    , ((modm              , xK_s     ), namedScratchpadAction myNamedScratchpads "terminal")

    -- launch dmenu
    , ((modm .|. shiftMask, xK_Return), spawn "dmenu_run -p 'Run: '")

    -- launch browser
    , ((modm              , xK_b     ), spawn myBrowser)

    -- launch file browser
    , ((modm              , xK_f     ), spawn myFileBrowser)

    -- close focused window
    , ((modm              , xK_q     ), kill)

    -- Lock the session
    , ((modm              , xK_Escape), spawn "light-locker-command -l")

    -- Quit xmonad
    , ((modm .|. controlMask, xK_q   ), io (exitWith ExitSuccess))

     -- Rotate through the available layout
    , ((modm              , xK_space ), sendMessage NextLayout)

    -- Resize viewed windows to the correct size
    , ((modm              , xK_n     ), setLayout $ XMonad.layoutHook conf)

    -- Move focus to the next window
    , ((modm              , xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm              , xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm              , xK_k     ), windows W.focusUp  )

    -- swap the focused window and the master window
    , ((modm              , xK_m     ), windows W.swapMaster)

    -- magnify the focused window
    , ((modm .|. shiftMask, xK_m     ), sendMessage Mag.Toggle)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm              , xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm              , xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm              , xK_p     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN (-1)))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN 1))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm              , xK_apostrophe), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- multimedia keys
    --
    -- XF86AudioLowerVolume
    , ((0                 , 0x1008ff11), spawn "amixer -c 0 sset Master 5- unmute")
    -- XF86AudioRaiseVolume
    , ((0                 , 0x1008ff13), spawn "amixer -c 0 sset Master 5+ unmute")
    -- XF86AudioMute
    , ((0                 , 0x1008ff12), spawn "amixer set Master toggle")
    -- XF86AudioMicMute
    , ((0                 , 0x1008ffB2), spawn "")
    -- XF86AudioNext
    , ((0                 , 0x1008ff17), spawn "")
    -- XF86AudioPrev
    , ((0                 , 0x1008ff16), spawn "")
    -- XF86AudioPlay
    , ((0                 , 0x1008ff14), spawn "")
    -- XF86Calculator
    , ((0                 , 0x1008ff1d), runOrRaise "speedcrunch" (resource =? "speedcrunch"))
    -- XF86BrightnessUp
    , ((0                 , 0x1008ff02), spawn "")
    -- XF86BrightnessDown
    , ((0                 , 0x1008ff03), spawn "")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), f sc)
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]]

--------------------------------------------------------------------------------
-- Mouse bindings:

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $


    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

--------------------------------------------------------------------------------
-- Event handling

myEventHook = mempty

--------------------------------------------------------------------------------
-- Status bars and logging:

myLogHook :: Handle -> Handle -> Handle -> X ()
myLogHook xmproc0 xmproc1 xmproc2 = dynamicLogWithPP . namedScratchpadFilterOutWorkspacePP $ xmobarPP
    { ppCurrent = xmobarColor blue "" . wrap "[" "]"
    , ppVisible = xmobarColor magenta "" .wrap "<" ">"
    , ppUrgent = xmobarColor red "" . wrap "!" "!"
    , ppHidden = xmobarColor yellow "" . wrap "(" ")"
    , ppHiddenNoWindows = xmobarColor blackLite ""
    , ppWsSep = " "
    , ppTitle = xmobarColor blue "" . shorten 60
    , ppSep = "<fc=" ++ blackLite ++ "><fn=2> | </fn></fc>"
    , ppExtras = [windowCount]
    , ppOrder = \(ws:l:t:ex) -> [ws]++ex++[l,t]
    , ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x >> hPutStrLn xmproc2 x
    }

--------------------------------------------------------------------------------
-- Startup hooks:

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "xsetroot -cursor_name left_ptr &"
    spawnOnce "xrandr --output HDMI0"
    spawnOnce "light-locker &"
    spawnOnce "xss-lock -- light-locker -n &"
    spawnOnce "udiskie &"
    spawnOnce "picom &"
    spawnOnce "nm-applet &"
    spawnOnce "xfce4-power-manager &"
    spawnOnce "volumeicon &"
    spawnOnce "blueman-applet &"
    spawnOnce "trayer --edge top --align right --widthtype request --transparent true --height 22 --alpha 0 --tint 0x282c34 --padding 5 --monitor 1 --iconspacing 3 &"
    spawnOnce "dunst &"
    spawnOnce "feh --bg-scale --randomize /usr/share/backgrounds/*"
    spawnOnce "pcmanfm -d &"
    spawnOnce "unclutter --timeout 10 &"
    setWMName "LG3D"

--------------------------------------------------------------------------------
-- main:

main :: IO ()
main = do
    xmproc0 <- spawnPipe "xmobar -x 0 ~/.xmonad/.xmobarrc"
    xmproc1 <- spawnPipe "xmobar -x 1 ~/.xmonad/.xmobarrc"
    xmproc2 <- spawnPipe "xmobar -x 2 ~/.xmonad/.xmobarrc"
    xmonad $ ewmh def
        { terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , keys               = myKeys
        , mouseBindings      = myMouseBindings
        , layoutHook         = myLayoutHook
        , manageHook         = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks
        , handleEventHook    = myEventHook <+> docksEventHook
        , logHook            = workspaceHistoryHook <+> myLogHook xmproc0 xmproc1 xmproc2
        , startupHook        = myStartupHook
        }

--------------------------------------------------------------------------------
-- help
help :: String
help = unlines ["The default modifier key is 'Super'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Return       Launch the terminal",
    "mod-s            Launch scratchpads",
    "mod-Shift-Return Launch dmenu",
    "mod-b            Launch brave",
    "mod-f            Launch the file browser",
    "mod-Shift-e      Launch emacs",
    "mod-q            Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-m        Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-p  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Decrement the number of windows in the master area",
    "mod-period (mod-.)   Increment the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q     Restart xmonad",
    "mod-Controll-q  Quit xmonad",
    "mod-[1..9]      Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
   "mod-button2  Raise the window to the top of the stack",
    "mod-button2  Set the window to floating mode and resize by dragging"]
