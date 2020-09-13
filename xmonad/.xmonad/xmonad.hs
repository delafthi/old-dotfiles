------------------------------------------------------------------------
-- Xmonad config file.
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Imports:

-- Base
import XMonad
import System.Exit
import qualified XMonad.StackSet as W

-- Actions

-- Data
import Data.Monoid
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.ManageDocks

-- Layout
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.BinarySpacePartition

-- Layout modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed (renamed, Rename(Replace))

-- Prompt

-- Utilities
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

------------------------------------------------------------------------
-- Default applications:

-- The preferred terminal program
myTerminal :: String
myTerminal = "alacritty"

-- The preferred browser
myBrowser :: String
myBrowser = "firefox"

-- The prefered GUI editor
myEditor :: String
myEditor = "emacsclient -c -a 'emacs'"

-- The preferred file browser
myFileManager :: String
myFileManager = "alacritty -e vifm"

------------------------------------------------------------------------
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
myNormalBorderColor = "#2E3440"

-- Border color for focused windows
myFocusedBorderColor :: String
myFocusedBorderColor = "#D08770"

-- Name of workspaces
myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3","4","5","6","7","8", "9"]

------------------------------------------------------------------------
-- Layouts:

tall = renamed [Replace "tall"]
    $ mySpacing 8
    $ ResizableTall 1 (3/100) (1/2) []

floats = renamed [Replace "floats"]
    $ Full

bsp = renamed [Replace "emptyBSP"]
    $ mySpacing 8
    $ emptyBSP 

tabs = renamed [Replace "tabs"]
    $ tabbed shrinkText myTabConfig

    where
        myTabConfig = def { fontName = "xft:Roboto Mono Nerd Font:regular:size=11"
                          , activeColor = "#2E3440"
                          , inactiveColor = "#434C5E"
                          , activeBorderColor = "#2E3440"
                          , inactiveBorderColor = "#2E3440"
                          , activeTextColor = "#ECEFF4"
                          , inactiveTextColor = "#D8DEE9"
                      }

myLayoutHook = avoidStruts $  myLayout
    where
        myLayout = bsp
               ||| floats
               ||| noBorders tabs

-------------------------------------------------------------------------
-- Controls:

-- modMask lets you specify which modkey you want to use.
-- mod1Mask ("left alt")
-- mod2Mask ("???")
-- mod3Mask ("right alt")
-- mod4Mask ("windows key")
myModMask :: KeyMask
myModMask = mod4Mask

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

------------------------------------------------------------------------
-- Key bindings:
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm .|. shiftMask, xK_Return), spawn "dmenu_run")

    -- launch browser 
    , ((modm,               xK_b     ), spawn myBrowser)

    -- launch Vifm 
    , ((modm,               xK_f     ), spawn $ XMonad.terminal conf)

    -- close focused window
    , ((modm,               xK_q     ), kill)

    -- Lock the session
    , ((modm,               xK_Escape), spawn "xss-lock")

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Swap the focused window and the master window
    , ((modm,               xK_m     ), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_f     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN (-1)))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN 1))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_h     ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
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
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
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
------------------------------------------------------------------------
-- Window rules:

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
    [ className =? "virt-manager" --> doFloat
    , className =? "Gimp" --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop" --> doIgnore
    ]

------------------------------------------------------------------------
-- Event handling

myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging:

myLogHook :: X ()
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hooks:

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "~/.fehbg &"
    spawnOnce "picom &"
    spawnOnce "nm-applet &"
    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --setParialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x2e3440 --height 22 &"
    spawnOnce "blueman-applet &"
    spawnOnce "emacs --daemon &"

------------------------------------------------------------------------
-- main:

main :: IO ()
main = do 
    xmproc <- spawnPipe "xmobar -x 0 ~/.xmonad/.xmobarrc"
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
        , manageHook         = myManageHook 
        , handleEventHook    = myEventHook
        , logHook            = myLogHook 
        , startupHook        = myStartupHook
    }

------------------------------------------------------------------------
-- help
help :: String
help = unlines ["The default modifier key is 'Super'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Return       Launch the terminal",
    "mod-Shift-Return Launch dmenu",
    "mod-b            Launch Firefox",
    "mod-f            Launch the file manager",
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
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Deincrement the number of windows in the master area",
    "mod-period (mod-.)   Increment the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
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
