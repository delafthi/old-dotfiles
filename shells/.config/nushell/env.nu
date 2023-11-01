# Nushell Environment Config File
#
# version = "0.86.0"

$env.STARSHIP_SHELL = "nu"
$env.STARSHIP_CONFIG = ($env.HOME | path join ".config/starship/starship.toml")

def create_left_prompt [] {
  (
    ^/usr/bin/starship prompt
      --cmd-duration $env.CMD_DURATION_MS
      $"--status=($env.LAST_EXIT_CODE)"
      --terminal-width (term size).columns
  )
}

def create_right_prompt [] {
  (
    ^/usr/bin/starship prompt --right
      --cmd-duration $env.CMD_DURATION_MS
      $"--status=($env.LAST_EXIT_CODE)"
      --terminal-width (term size).columns
  )
}

def create_multiline_indicator [] {
  (
    ^/usr/bin/starship prompt --continuation
      --terminal-width (term size).columns
  )
}

def create_indicator [vi_mode: string] {
  (
    ^/usr/bin/starship module character --keymap $vi_mode
        --terminal-width (term size).columns
  )
}

def create_right_transient_prompt [] {
  (
    ^/usr/bin/starship module cmd_duration
      --cmd-duration $env.CMD_DURATION_MS
      --terminal-width (term size).columns
  )
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| create_indicator none }
$env.PROMPT_INDICATOR_VI_INSERT = {|| create_indicator viins}
$env.PROMPT_INDICATOR_VI_NORMAL = {|| create_indicator vicmd}
$env.PROMPT_MULTILINE_INDICATOR = {|| create_multiline_indicator }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| create_right_transient_prompt }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
  # FIXME: This default is not implemented in rust code as of 2023-09-06.
  ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
  # FIXME: This default is not implemented in rust code as of 2023-09-06.
  ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# Environment
$env.PATH = ($env.PATH | split row (char esep) | prepend [($env.HOME | path join ".local/bin") ($env.HOME | path join ".pyenv/shims")])
$env.EDITOR = "nvim"
$env.FZF_DEFAULT_OPTS = "--color='fg:#abb2bf,bg:#282c34,fg+:#c8cdd5,bg+:#22262d,border:#3e4451' --color='info:#61afef,spinner:#c678dd,header:#e06c75,prompt:#c678dd' --color='hl:#e5c07b,hl+:#e5c07b,pointer:#c678dd,marker:#d19a66' --color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' --color='hl:reverse,hl+:reverse'"
$env.GUIX_PROFILE = ($env.HOME | path join ".config/guix/current")
$env.LS_COLORS = (vivid generate one-dark | str trim)
$env.MANPAGER = "nvim +Man! +'set noma'"
$env.PIPENV_VENV_IN_PROJECT = 1
$env.PYENV_SHELL = "nu"
$env.SSH_AGENT_PID = ""
$env.SSH_AUTH_SOCK = ($env.XDG_RUNTIME_DIR | path join "gnupg/S.gpg-agent.ssh")
