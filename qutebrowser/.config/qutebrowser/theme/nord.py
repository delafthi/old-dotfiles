c = c  # noqa: F821 pylint: disable=E0602,C0103

nord = {
    "nord0": "#2e3440",
    "nord1": "#3b4252",
    "nord2": "#434c5e",
    "nord3": "#4c566a",
    "nord4": "#d8dee9",
    "nord5": "#e5e9f0",
    "nord6": "#eceff4",
    "nord7": "#8fbcbb",
    "nord8": "#88c0d0",
    "nord9": "#81a1c1",
    "nord10": "#5e81ac",
    "nord11": "#bf616a",
    "nord12": "#d08770",
    "nord13": "#ebcb8b",
    "nord14": "#a3be8c",
    "nord15": "#b48ead",
}

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = nord["nord1"]

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = nord["nord1"]

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = nord["nord1"]

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = nord["nord15"]

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = nord["nord2"]

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = nord["nord2"]

# Text color of the completion widget.
# Type: QtColor
c.colors.completion.fg = nord["nord4"]

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = nord["nord3"]

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = nord["nord3"]

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.item.selected.border.top = nord["nord3"]

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = nord["nord8"]

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.match.fg = nord["nord13"]

# Foreground color of the matched text in the completion.
# Type: QssColor
c.colors.completion.match.fg = nord["nord13"]

# Color of the scrollbar in completion view
# Type: QssColor
c.colors.completion.scrollbar.bg = nord["nord2"]

# Color of the scrollbar handle in completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = nord["nord3"]

# Background color of disabled items in the context menu. If set to
# null, the Qt default is used.
# Type: QssColor
c.colors.contextmenu.disabled.bg = nord["nord2"]

# Foreground color of disabled items in the context menu. If set to
# null, the Qt default is used.
# Type: QssColor
c.colors.contextmenu.disabled.fg = nord["nord3"]

# Background color of the context menu. If set to null, the Qt default
# is used.
# Type: QssColor
c.colors.contextmenu.menu.bg = nord["nord2"]

# Foreground color of the context menu. If set to null, the Qt default
# is used.
# Type: QssColor
c.colors.contextmenu.menu.fg = nord["nord4"]

# Background color of the context menu's selected item. If set to null,
# the Qt default is used.
# Type: QssColor
c.colors.contextmenu.selected.bg = nord["nord9"]

# Foreground color of the context menu's selected item. If set to null,
# the Qt default is used.
# Type: QssColor
c.colors.contextmenu.selected.fg = nord["nord0"]

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = nord["nord15"]

# Background color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.bg = nord["nord11"]

# Foreground color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.fg = nord["nord0"]

# Color gradient start for download backgrounds.
# Type: QtColor
c.colors.downloads.start.bg = nord["nord10"]

# Color gradient start for download text.
# Type: QtColor
c.colors.downloads.start.fg = nord["nord0"]

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = nord["nord12"]

# Color gradient end for download text.
# Type: QtColor
c.colors.downloads.stop.fg = nord["nord0"]

# Color gradient interpolation system for download backgrounds.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.downloads.system.bg = "rgb"

# Color gradient interpolation system for download text.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.downloads.system.fg = "rgb"


# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = nord["nord9"]

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = nord["nord0"]

# CSS border value for hints.
# Type: String
c.hints.border = "1px solid " + nord["nord9"]

# Font color for the matched part of hints.
# Type: QssColor
c.colors.hints.match.fg = nord["nord13"]

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = nord["nord2"]

# Text color for the keyhint widget.
# Type: QssColor
c.colors.keyhint.fg = nord["nord4"]

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = nord["nord8"]

# Background color of an error message.
# Type: QssColor
c.colors.messages.error.bg = nord["nord11"]

# Border color of an error message.
# Type: QssColor
c.colors.messages.error.border = nord["nord11"]

# Foreground color of an error message.
# Type: QssColor
c.colors.messages.error.fg = nord["nord0"]

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = nord["nord9"]

# Border color of an info message.
# Type: QssColor
c.colors.messages.info.border = nord["nord9"]

# Foreground color an info message.
# Type: QssColor
c.colors.messages.info.fg = nord["nord0"]

# Background color of a warning message.
# Type: QssColor
c.colors.messages.warning.bg = nord["nord12"]

# Border color of a warning message.
# Type: QssColor
c.colors.messages.warning.border = nord["nord12"]

# Foreground color a warning message.
# Type: QssColor
c.colors.messages.warning.fg = nord["nord0"]

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = nord["nord0"]

# # Border used around UI elements in prompts.
# # Type: String
c.colors.prompts.border = "1px solid " + nord["nord0"]

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = nord["nord4"]

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = nord["nord3"]

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.fg = nord["nord4"]

# Background color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.bg = nord["nord1"]

# Foreground color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.fg = nord["nord15"]

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = nord["nord1"]

# Foreground color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.fg = nord["nord15"]

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = nord["nord0"]

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = nord["nord4"]

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = nord["nord0"]

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = nord["nord15"]

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = nord["nord1"]

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = nord["nord14"]

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = nord["nord1"]

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = nord["nord4"]

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = nord["nord1"]

# Foreground color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.fg = nord["nord10"]

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = nord["nord1"]

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = nord["nord15"]

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = nord["nord7"]

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = nord["nord11"]

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = nord["nord4"]

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = nord["nord8"]

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = nord["nord4"]

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = nord["nord14"]

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = nord["nord12"]

# Background color of the tab bar.
# Type: QtColor
c.colors.tabs.bar.bg = nord["nord0"]

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = nord["nord0"]

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = nord["nord4"]

# Color for the tab indicator on errors.
# Type: QtColor
c.colors.tabs.indicator.error = nord["nord11"]

# Color gradient start for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.start = nord["nord15"]

# Color gradient end for the tab indicator.
# Type: QtColor
c.colors.tabs.indicator.stop = nord["nord12"]

# Color gradient interpolation system for the tab indicator.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.tabs.indicator.system = "rgb"

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = nord["nord0"]

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = nord["nord4"]

# Background color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.bg = nord["nord0"]

# Foreground color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.fg = nord["nord8"]

# Background color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.bg = nord["nord0"]

# Foreground color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.fg = nord["nord8"]

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = nord["nord1"]

# Foreground color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.fg = nord["nord8"]

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = nord["nord1"]

# Foreground color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.fg = nord["nord8"]

# # Background color of selected even tabs.
# # Type: QtColor
c.colors.tabs.selected.even.bg = nord["nord1"]

# # Foreground color of selected even tabs.
# # Type: QtColor
c.colors.tabs.selected.even.fg = nord["nord4"]

# # Background color of selected odd tabs.
# # Type: QtColor
c.colors.tabs.selected.odd.bg = nord["nord1"]

# # Foreground color of selected odd tabs.
# # Type: QtColor
c.colors.tabs.selected.odd.fg = nord["nord4"]

# Background color for webpages if unset (or empty to use the theme's
# color)
# Type: QtColor
# c.colors.webpage.bg = "none"
