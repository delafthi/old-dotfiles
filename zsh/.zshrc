# ~/.zshrc: executed by zsh(1) for non-login shells.

################################################################################
# Zsh settings
################################################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set vim as manpager
export MANPAGER="nvim +Man!"

# Enable autocompletion for hidden files
_comp_options+=(globdots)
ZSH_AUTOSUGGEST_USE_ASYNC=1

################################################################################
# Aiases

alias sudo="sudo "

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# vim
alias vim="nvim"
alias vi="nvim"
alias :q="exit"

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"  # all files and dirs
alias ll="exa -l --color=always --group-directories-first"  # long format
alias lt="exa -aT --color=always --group-directories-first" # tree listing

# Use ripgrep instead of grep and outputs via bat
function batgrep ()
{
  rg $@ --hidden --color always | bat --theme base16 --paging=never --color=always
}
alias grep="batgrep"

# Use ripgrep --files instead of find and use bat for the output
function batfind ()
{
  rg $@ --ignore --color=always --smart-case --hidden --files | bat --theme base16
}
alias find="batfind"

# Use bat for a nicer git diff
function batdiff ()
{
  git diff $@ --name-only --diff-filter=d | xargs bat --diff --theme base16
}

# Use fzf in combination with grep
# fzf colors
alias fzf="fzf \
  --black \
  --color='fg:#dcdfe4,bg:#282c34,fg+:#61afef,bg+:#343944,border:#abb2bf' \
  --color='info:#61afef,spinner:#c678dd,header:#e06c75,prompt:#c678dd' \
  --color='hl:#e5c07b,hl+:#e5c07b,pointer:#c678dd,marker:#e59F70' \
  --color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' \
  --color='hl:reverse,hl+:reverse'"

export INITIAL_QUERY=""
export RG_PREFIX="rg --ignore --hidden --column --line-number --with-filename --no-heading --color=always --smart-case "
export FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'"
alias fg="fzf \
  --bind 'change:reload:$RG_PREFIX {q} || true' \
  --disabled \
  --ansi \
  --query '$INITIAL_QUERY' \
  --height=50% \
  --tabstop=2 \
  --layout=reverse \
  --nth=2 \
  --delimiter : \
  --preview-window '+{2}/2' \
  --preview 'bat \
  --theme TwoDark \
  --italic-text=always \
  --color=always \
  --style=numbers \
  -r {2}: \
  -H {2} \
  --line-range :500 {1}'"
alias ff="rg \
  --ignore \
  --smart-case \
  --hidden \
  --files | fzf \
  --ansi \
  --height=50% \
  --layout=reverse \
  --tabstop=2 \
  --preview 'bat \
  --theme TwoDark \
  --italic-text=always \
  --color=always \
  --style=numbers \
  --line-range :500 {}'"

# adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df="df -h"                          # human-readable sizes
alias free="free -m"                      # show sizes in MB
alias rm="rm -i"
alias mv="mv -i"
alias minicom="minicom -m -c on"
alias htop="htop -t"

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# kitty specific aliases
if [ $TERM == "xterm-kitty" ]
then
    alias ssh="kitty +kitten ssh"
fi

################################################################################
# Environment variables
export HISTCONTROL=ignoreboth             # no duplicate entries
export HISTSIZE=5000
export HISTFILESIZE=10000
export EDITOR="nvim"                      # $EDITOR use Neovim in terminal
export SSH_KEY_PATH="~/.ssh/rsa_id"       # Set default ssh key path
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

################################################################################
# Keybindings

# Set vi mode
bindkey -v

################################################################################
# Visuals

# Colors
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\033[0;34m"
COLOR_YELLOW="\033[0;33m"
COLOR_PURPLE="\033[0;35m"
COLOR_CYAN="\033[0;36m"
COLOR_RESET="\033[0m"

# Prompt
color_prompt=yes
PS1="\[$COLOR_PURPLE\]\u@\h:\[$COLOR_YELLOW\]\w"
if [ -e /etc/bash_completion.d/git-prompt ]; then
    PS1+="\[\$(git_color)\]"        # colors git status
    PS1+="\$(__git_ps1)"            # prints current branch
fi
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'

# Change title of terminals
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND="echo -ne '\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007'" ;;
  screen*)
    PROMPT_COMMAND="echo -ne '\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\'" ;;
esac

################################################################################
# Functions

# Archive extraction
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      --help)      echo "usage: ex <file>" ;;
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

################################################################################
# Plugins

# Starship prompt
if ! command -v starship 1>/dev/null 2>&1; then
    echo -e "$COLOR_RED $BOLD => Error: $COLOR_RESET $NORMAL Starship not installed.\n"
    echo -e "$COLOR_GREEN $BOLD => Info: $COLOR_RESET $NORMAL Starship will be downloaded and installed."
    curl -fsSL https://starship.rs/install.sh | bash
fi
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init bash)"

# Nix
if [ -f /etc/profile.d/nix.sh ]; then
  source /etc/profile.d/nix.sh
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if [ ! -d $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
    echo -e "$COLOR_RED $BOLD => Error: $COLOR_RESET $NORMAL pyenv-virtualenv is not installed.\n"
    echo -e "$COLOR_GREEN $BOLD => Info: $COLOR_RESET $NORMAL pyenv-virtualenv will be downloaded and installed."
    mkdir -p $PYENV_ROOT/plugins/pyenv-virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
  fi
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
