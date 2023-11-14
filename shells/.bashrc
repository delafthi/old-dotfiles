########################################################
# ~/.bashrc: executed by bash(1) for non-login shells. #
########################################################

# General settings
# ~~~~~~~~~~~~~~~~

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

# Enable vi bindings
set editing-mode vi
set keymap vi-command
set show-mode-in-prompt on
set vi-ins-mode-string ">"
set vi-cmd-mode-string "<"
EMBEDDED_PS2='\w $ '

# Set bash specific env vars
export HISTCONTROL=ignoreboth # no duplicate entries
export HISTSIZE=5000
export HISTFILESIZE=10000

# Environment
# ~~~~~~~~~~~

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" --color='fg:#abb2bf,bg:#282c34,fg+:#c8cdd5,bg+:#22262d,border:#3e4451' --color='info:#61afef,spinner:#c678dd,header:#e06c75,prompt:#c678dd' --color='hl:#e5c07b,hl+:#e5c07b,pointer:#c678dd,marker:#d19a66' --color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' --color='hl:reverse,hl+:reverse'"
export GUIX_PROFILE="$HOME/.config/guix/current"
export LS_COLORS="$(vivid generate one-dark)"
export MANPAGER="nvim +Man! +'set noma'"
export PIPENV_VENV_IN_PROJECT=1
export PYENV_SHELL="bash"
export PYTHON_KEYRING_BACKEND="keyring.backends.null.Keyring"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export SSH_AGENT_PID=
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

# Aliases
# ~~~~~~~

alias sudo="sudo -E"
alias ..="cd .."
alias ...="cd ../.."
alias :q="exit"
alias cp="cp -i"
alias df="df -h"
alias free="free -m"
alias ll="ls -al --color=always --group-directories-first"
alias magit="nvim +'lua require(\"neogit\").open({kind=\"replace\"})'"
alias mv="mv -i"
alias htop="htop -t"
alias rm="rm -i"
alias tn="tmux new -s $(pwd | sed 's/.*\///g')"
alias vi="nvim"
alias vim="nvim"

# Plugins
# ~~~~~~~

# Carapace completion
source <(carapace _carapace)

# direnv
eval "$(direnv hook bash)"
direnv reload 2>/dev/null

# Guix (only executed if not in a guix system)
source "$GUIX_PROFILE/etc/profile"

# pyenv
eval "$(pyenv init -)"

# Starship prompt
eval "$(starship init bash)"
