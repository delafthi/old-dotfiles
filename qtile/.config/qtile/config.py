################################################################################
# Qtile config file
################################################################################

################################################################################
# Imports:

import os
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy

################################################################################
# Default applications:

# The preferred terminal program
myTerminal = "kitty"

# The preferred browser
myBrowser = "brave"

# The preferred file manager
myFileBrowser = "pcmanfm"

################################################################################
# Visual settings:

# One dark palette
one_dark = ["#282c34",
            "#abb2bf",
            "#e06c75",
            "#be5046",
            "#98c379",
            "#e5c07b",
            "#d19a66",
            "#61afef",
            "#c678dd",
            "#56b6c2",
            "#4b5263",
            "#5c6370",
            ]

# Default font
myFont = "Victor Mono Nerd Font Mono"

# Window border
layout_theme = {"border_width": 3,
                "margin": 4,
                "border_focus": one_dark[7],
                "border_normal": one_dark[0],
                }

# Name of workspaces
group_names = [("www", {'layout': 'monadtall'}),
               ("dev", {'layout': 'monadtall'}),
               ("sys", {'layout': 'monadtall'}),
               ("chat", {'layout': 'monadtall'}),
               ("mus", {'layout': 'monadtall'}),
               ("virt", {'layout': 'monadtall'}),
               ("doc", {'layout': 'monadtall'}),
               ("vis", {'layout': 'monadtall'}),
               ]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

################################################################################
# Window rules:

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

################################################################################
# Layouts:

layouts = [
    layout.MonadTall(change_ratio=0.03, **layout_theme),
    layout.Tile(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.Floating(name="max", **layout_theme),
]

################################################################################
# Controls:

# Set Super key as mod
mod = "mod4"

# Wheter focus follows the mous pointer
follow_mouse_focus = False

# Whether clicking on a window brings the window to the front
bring_front_click = True

# Curor wraps around
cursor_warp = False

keys = [
        Key([mod], "Return",
            lazy.spawn(myTerminal),
            desc="Launches the terminal",
            ),
        Key([mod], "s",
            lazy.spawn(myTerminal),
            desc="Launches a Scratchpad",
            ),
        Key([mod, "shift"], "Return",
            lazy.spawn("dmenu_run -p 'Run: '"),
             desc="Launches dmenu",
             ),
        Key([mod], "b",
            lazy.spawn(myBrowser),
            desc="Launches the browser",
            ),
        Key([mod], "f",
            lazy.spawn(myFileBrowser),
            desc="Launches the file manager",
            ),
        Key([mod], "q",
            lazy.window.kill(),
            desc="Kill focused window",
            ),
        Key([mod], "Escape",
            lazy.spawn("slock"),
            desc="Lock session",
            ),
        Key([mod, "shift"], "q",
            lazy.restart(),
            desc="Shutdown Qtile",
            ),
        Key([mod], "space",
            lazy.next_layout(),
            desc="Rotate through available layouts",
            ),
        Key([mod, "shift"], "space",
            lazy.layout.rotate(),
            lazy.layout.flip(),
            desc="Switch which side the main pane occupies",
            ),
        Key([mod,], "n",
            lazy.layout.normalize(),
            desc="Rotate to the previous layout",
            ),
        Key([mod,], "Tab",
            lazy.layout.down(),
            desc="Move focus to the next window",
            ),
        Key([mod,], "j",
            lazy.layout.down(),
            desc="Move focus to the next window",
            ),
        Key([mod,], "k",
            lazy.layout.up(),
            desc="Move focus to the previous window",
            ),
        Key([mod, "shift"], "j",
            lazy.layout.shuffle_down(),
            desc="Move focus to the next window",
            ),
        Key([mod, "shift"], "k",
            lazy.layout.shuffle_up(),
            desc="Move focus to the previous window",
            ),
        Key([mod,], "m",
            lazy.layout.maximize(),
            desc="Swap focused window to the master pane",
            ),
        Key([mod, "shift"], "m",
            lazy.layout.maximize(),
            desc="Swap focused window to the master pane",
            ),
        Key([mod,], "h",
            lazy.layout.grow(),
            desc="Shrink master area",
            ),
        Key([mod,], "l",
            lazy.layout.shrink(),
            desc="Expand master area",
            ),
        Key([mod,], "comma",
            lazy.layout.decrease_nmaster(),
            desc="Shrink master area",
            ),
        Key([mod,], "period",
            lazy.layout.increase_nmaster(),
            desc="Shrink master area",
            ),
        Key([mod,], "p",
            lazy.window.toggle_floating(),
            desc="Toggle window to/from floating",
            ),
        Key([mod, "control"], "q",
            lazy.shutdown(),
            desc="Restart Qtile",
            ),
         ### Switch focus to specific monitor (out of three)
         Key([mod], "w",
             lazy.to_screen(0),
             desc="Keyboard focus to monitor 1",
             ),
         Key([mod], "e", lazy.to_screen(1),
             desc="Keyboard focus to monitor 2",
             ),
         Key([mod], "r",
             lazy.to_screen(2),
             desc="Keyboard focus to monitor 3",
             ),
        Key([], "XF86AudioMute",
            lazy.spawn("amixer -q set Master toggle"),
            desc="Mute audio",
            ),
        Key([], "XF86AudioLowerVolume",
            lazy.spawn("amixer -c 0 sset Master 5- unmute"),
            desc="Lower volume",
            ),
        Key([], "XF86AudioRaiseVolume",
            lazy.spawn("amixer -c 0 sset Master 5+ unmute"),
            desc="Lower volume",
            ),
        ]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.extend([
         Key([mod], str(i),
             lazy.group[name].toscreen(),
             desc="Switch to group {}".format(name)
             ),
         Key([mod, "shift"], str(i),
             lazy.window.togroup(name),
             desc="Switch to & move focused window to group {}".format(name)
             )
    ])

################################################################################
# Mouse bindings:

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

###############################################################################
# Start up hooks:

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.Popen([home + "/.config/qtile/autostart.sh"])


################################################################################
# Status bar:

widget_defaults = dict(
    font = "Victor Mono Nerd Font Mono",
    fontsize = 13,
    padding = 3,
    foreground = one_dark[11],
    background = one_dark[0],
)

extension_defaults = widget_defaults.copy()
def init_widgets_list():
    widgets_list = [
            widget.Sep(
                linewidth = 0,
                padding = 3,
            ),
            widget.Image(
                filename = "~/.config/qtile/icons/python.png",
                margin = 3,
                mous_callbacks = {"Button1": lambda qtile:
                    qtile.cmd_spawn("dmenu_run -p 'Run: '")},
            ),
            widget.Sep(
                linewidth = 1,
            ),
            widget.GroupBox(
                active = one_dark[6],
                block_highlight_text_color = one_dark[7],
                center_aligned = False,
                disable_drag = True,
                highlight_color = one_dark[10],
                highlight_method = "line",
                inactive = one_dark[10],
                other_current_screen_border = one_dark[6],
                other_screen_border = one_dark[6],
                rounded = False,
                this_current_screen_border = one_dark[7],
                this_screen_border = one_dark[7],
                urgent_alert_method = "line",
                urgent_border = one_dark[3],
                urgent_text = one_dark[0],
            ),
            widget.Sep(
                linewidth = 1,
            ),
            widget.CurrentLayout(),
            widget.Sep(
                linewidth = 1,
            ),
            widget.WindowName(
                foreground = one_dark[7],
            ),
            widget.Spacer(
                length = bar.STRETCH,
            ),
            widget.Sep(
                linewidth = 1,
            ),
            widget.CPU(
                foreground = one_dark[2],
                format = "  {load_percent}%",
            ),
            widget.Sep(
                linewidth = 1,
            ),
            widget.Memory(
                foreground = one_dark[5],
                format = " {MemUsed}M/{MemTotal}M",
            ),
            widget.Sep(
                linewidth = 1,
            ),
            widget.Clock(
                foreground = one_dark[8],
                format = " %a %d.%m.%y %H:%M",
            ),
            widget.Sep(
                linewidth = 0,
                padding = 3,
            ),
            widget.Systray(
                iconsize=24
            ),
        ]
    return widgets_list

screens = [
    Screen(top=bar.Bar(widgets=init_widgets_list(), size=24, margin=4,)),
    Screen(top=bar.Bar(widgets=init_widgets_list(), size=24, margin=4,)),
    Screen(top=bar.Bar(widgets=init_widgets_list(), size=24, margin=4,)),
]
# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
