--------------------------------------------------------------------------------
-- Xmonad config file.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Imports:

-- Base
import XMonad
import System.IO (hPutStrLn)
import System.Exit
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.WindowGo (runOrRaise)

-- Data
import Data.Monoid
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName

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

-- Prompt

-- Utilities
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

--------------------------------------------------------------------------------
-- Default applications

-- The preferred terminal program
myTerminal :: String
myTerminal = "alacritty"

-- The preferred browser
myBrowser :: String
myBrowser = "firefox"

-- The preferred GUI editor
myEditor :: String
myEditor = "emacsclient -c -a 'emacs'"

-- The preferred file manager
myFileBrowser :: String
myFileBrowser = "pcmanfm"

--------------------------------------------------------------------------------
-- Visual settings:

-- Default font
myFont :: String
myFont = "xft:Roboto Mono Nerd Font:regular:size=11:antialias=true:hinting=true"

-- Width of the window border in pixels.
myBorderWidth :: Dimension
myBorderWidth = 3

-- Spacing between windows
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Border color for unfocused windows
myNormalBorderColor :: String
myNormalBorderColor = "#282c34"

-- Border color for focused windows
myFocusedBorderColor :: String
myFocusedBorderColor = "#61afef"

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
    [ className =? "mpv" --> doShift( myWorkspaces !! 7 )
    , className =? "Gimp" --> doShift( myWorkspaces !! 7 )
    , className =? "Darktable" --> doShift( myWorkspaces !! 7 )
    , className =? "Blender" --> doShift( myWorkspaces !! 7 )
    , className =? "Virt-manager" --> doShift( myWorkspaces !! 3 )
    , className =? "libreoffice-startcenter" --> doShift( myWorkspaces !! 6 )
    , resource =? "Dialog" --> doFloat
    , className =? "Pavucontrol" --> doFloat
    , className =? "Xmessage" --> doFloat
    ]

--------------------------------------------------------------------------------
-- Layouts:

myLayoutHook = avoidStruts $ 
    tall
    ||| twopane
    ||| noBorders tabs
    where
        -- Tall layout
        tall = renamed[Replace "tall"]
            $ mySpacing spacing
            $ ResizableTall nmaster delta ratio []
        -- TwoPane layout
        twopane = renamed[Replace "twopane"]
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
                          , activeColor = "#61afef"
                          , inactiveColor = "#282c34"
                          , activeBorderColor = "#61afef"
                          , inactiveBorderColor = "#5c6370"
                          , activeTextColor = "#282c34"
                          , inactiveTextColor = "#5c6370"
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

    -- launch dmenu
    , ((modm .|. shiftMask, xK_Return), spawn "dmenu_run -p 'Run: '")

    -- launch browser 
    , ((modm              , xK_b     ), spawn myBrowser)

    -- launch file browser
    , ((modm              , xK_f     ), spawn myFileBrowser)

    -- launch emacs
    , ((modm              , xK_e     ), spawn myEditor)

    -- close focused window
    , ((modm              , xK_q     ), kill)

    -- Lock the session
    , ((modm              , xK_Escape), spawn "light-locker-command -l")

    -- Quit xmonad
    , ((modm .|. controlMask, xK_q   ), io (exitWith ExitSuccess))

     -- Rotate through the available layout
    , ((modm              , xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm              , xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm              , xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm              , xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm              , xK_k     ), windows W.focusUp  )

    -- Swap the focused window and the master window
    , ((modm              , xK_m     ), windows W.swapMaster)

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
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_y, xK_x, xK_c] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


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

myLogHook :: X ()
myLogHook = return ()

--------------------------------------------------------------------------------
-- Startup hooks:

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "light-locker &"
    spawnOnce "xss-lock -- light-locker -n &"
    spawnOnce "udiskie &"
    spawnOnce "picom &"
    spawnOnce "nm-applet &"
    spawnOnce "volumeicon &"
    spawnOnce "blueman-applet &"
    spawnOnce "trayer --edge top --align right --widthtype request --transparent true --height 22 --alpha 0 --tint 0x282c34 --padding 5 --monitor 0,1 &"
    spawnOnce "dunst &"
    spawnOnce "~/.fehbg &"
    spawnOnce "emacs --daemon &"
    spawnOnce "pcmanfm -d &"
    setWMName "LG3D"

--------------------------------------------------------------------------------
-- main:

main :: IO ()
main = do 
    xmproc0 <- spawnPipe "xmobar -x 0 ~/.xmonad/.xmobarrc"
    xmproc1 <- spawnPipe "xmobar -x 1 ~/.xmonad/.xmobarrc"
    xmonad $ def
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
        , logHook            = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
            { ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x
            , ppCurrent = xmobarColor "#61afef" "" . wrap "[" "]"
            , ppVisible = xmobarColor "#c678dd" ""
            , ppHidden = xmobarColor "#d19a66" "" . wrap "'" "'"
            , ppHiddenNoWindows = xmobarColor "#5c6370" ""
            , ppWsSep = " "
            , ppTitle = xmobarColor "#61afef" "" . shorten 60
            , ppSep = "<fc=#5c6370><fn=2> | </fn></fc>"
            , ppUrgent = xmobarColor "#e06c75" "" . wrap "!" "!"
            , ppExtras = [windowCount]
            , ppOrder = \(ws:l:t:ex) -> [ws]++ex++[l,t]
            }
        , startupHook        = myStartupHook
    }

--------------------------------------------------------------------------------
-- help
help :: String
help = unlines ["The default modifier key is 'Super'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Return       Launch the terminal",
    "mod-Shift-Return Launch dmenu",
    "mod-b            Launch Firefox",
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
    "mod-comma  (mod-,)   Deincrement the number of windows in the master area",
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
    "mod-button3  Set the window to floating mode and resize by dragging"]
