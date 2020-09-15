# ~/.zshrc: executed by zsh(1) for non-login shells.
# Path to my oh-my-zsh installation
export ZSH="/home/thierryd/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Plugins
#----------------------------------------------------------

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# vi_mode
POWERLEVEL9K_VI_INSERT_MODE_STRING='INSERT' 
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='7'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='0'
POWERLEVEL9K_VI_COMMAND_MODE_STRING='NORMAL'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='6'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='0'

# context
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='5'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='0'

# dir
POWERLEVEL9K_DIR_BACKGROUND='3'
POWERLEVEL9K_DIR_FOREGROUND='0'

# git status (vcs)
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='10'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='215'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='1'
POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS='0.05'

# Powerline
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
ZLE_RPROMPT_INDENT=0

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# General settings
#----------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist noma' -\""

# Enable autocompletion for hidden files
_comp_options+=(globdots)
ZSH_AUTOSUGGEST_USE_ASYNC=1
# Remove current and parent dir
zstyle ':completion:*' special-dirs false

# Aiases 
#----------------------------------------------------------

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

# emacs
alias emacs="emacsclient -c -a 'emacs'"

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first" # my preferred listing
alias la="exa -a --color=always --group-directories-first"  # all files and dirs
alias ll="exa -l --color=always --group-directories-first"  # long format
alias lt="exa -aT --color=always --group-directories-first" # tree listing

# Colorize grep output and changing it to ripgrep
alias grep="grep --color=auto"
#alias find="fd --color=auto"

# adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df="df -h"                          # human-readable sizes
alias free="free -m"                      # show sizes in MB
alias rm="rm -i"
alias mv="mv -i"
alias minicom="minicom -m -c on" 

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# git 
alias gs="git status"

# Environment variables
#----------------------------------------------------------
export HISTCONTROL=ignoreboth             # no duplicate entries
export HISTSIZE=5000
export HISTFILESIZE=10000
export EDITOR="nvim"                      # $EDITOR use Neovim in terminal
export VISUAL="emacs"                     # $VISUAL use Emacs in GUI mode
export SSH_KEY_PATH="~/.ssh/rsa_id"       # Set default ssh key path
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# Keybindings
#----------------------------------------------------------

# Set vi mode
bindkey -v

# Visuals
#----------------------------------------------------------

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


# Functions
#----------------------------------------------------------

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
