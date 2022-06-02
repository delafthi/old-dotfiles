########################################################
# ~/.bashrc: executed by bash(1) for non-login shells. #
########################################################

############################################################
# General settings {{{1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# Bash options
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # bash includes filenames beginning with a ‘.’ in the results of filename expansion
shopt -s histappend     # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control

# Auto-completion
source /usr/share/bash-completion/bash_completion

# Enable vi bindings
set -o vi

############################################################
# Aliases {{{1

alias sudo="sudo -E"

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# vim
alias :q="exit"

# Adding flags
alias cp="cp -i"     # confirm before overwriting something
alias df="df -h"     # human-readable sizes
alias free="free -m" # show sizes in MB
alias rm="rm -i"
alias mv="mv -i"
alias minicom="minicom -m -c on"
alias htop="htop -t"
alias feh="feh --auto-zoom --scale-down"
alias gl="lazygit"

############################################################
# Environment variables {{{1

export HISTCONTROL=ignoreboth # no duplicate entries
export HISTSIZE=5000
export HISTFILESIZE=10000
# Set the default editor, this variable is overwritten in case neovim is
# installed
export EDITOR="vi"
export SSH_KEY_PATH="~/.ssh/rsa_id" # Set default ssh key path
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if [ -d "$HOME/.bin" ]; then
  PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

############################################################
# Visuals {{{1

# Load dircolors
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

###########################################################
# Settings with dependencies {{{1

# Set defaults for bat
if command -v bat 1> /dev/null 2>&1 && command -v rg 1> /dev/null 2>&1; then
  alias bat="bat --italic-text=always --color=always --theme Nord"
  alias grep="batgrep"
fi

# Use fzf in combination with grep
# fzf colors
if command -v fzf 1> /dev/null 2>&1 && command -v rg 1> /dev/null 2>&1; then
  alias fzf="fzf \
    --color='fg:#d8dee9,bg:#2e3440,fg+:#81a1c1,bg+:#2e3440,border:#4c566a' \
    --color='info:#81a1c1,spinner:#b48ead,header:#bf616a,prompt:#b48ead' \
    --color='hl:#ebcb8b,hl+:#ebcb8b,pointer:#b48ead,marker:#d08770' \
    --color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' \
    --color='hl:reverse,hl+:reverse'"
fi

if command -v nvim 1> /dev/null 2>&1; then
  alias vim="nvim"
  alias vi="nvim"
  # set vim as manpager
  export MANPAGER="nvim +Man!"
  export EDITOR="nvim"
fi

# Changing "ls" to "exa"
if command -v exa 1> /dev/null 2>&1; then
  alias ls="exa -al --color=always --group-directories-first" # my preferred listing
  alias la="exa -a --color=always --group-directories-first"  # all files and dirs
  alias ll="exa -l --color=always --group-directories-first"  # long format
  alias lt="exa -aT --color=always --group-directories-first" # tree listing
fi

# kitty specific aliases
if [ $TERM == "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi

# Exit ranger rather than opening a new instance if we are already in an
# instance
if command -v ranger 1> /dev/null 2>&1; then
  ranger()
  {
    if [ -z "$RANGER_LEVEL" ]; then
      /usr/bin/ranger "$@"
    else
      exit
    fi
  }
fi

############################################################
# Plugins {{{1

# Starship prompt
if ! command -v starship 1> /dev/null 2>&1; then
  echo -e "$COLOR_RED $BOLD => Error: $COLOR_RESET $NORMAL Starship not installed.\n"
  echo -e "$COLOR_GREEN $BOLD => Info: $COLOR_RESET $NORMAL Please install starship through your package manager or manually. An installation guide can be found here: https://starship.rs/guide/#%F0%9F%9A%80-installation"
else
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init bash)"
fi

# direnv
if command -v direnv 1> /dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# }}}1
