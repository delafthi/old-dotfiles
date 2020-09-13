# ~/.bashrc: executed by bash(1) for non-login shells.

# General settings
#----------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist noma' -\""

### Bash options
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob # bash includes filenames beginning with a ‘.’ in the results of filename expansion
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

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
bind "set show-mode-in-prompt on"
bind "set vi-ins-mode-string \1$COLOR_WHITE\2[Insert]\1$COLOR_RESET\2"
bind "set vi-cmd-mode-string \1$COLOR_CYAN\2[Normal]\1$COLOR_RESET\2"

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first" # my preferred listing
alias la="exa -a --color=always --group-directories-first"  # all files and dirs
alias ll="exa -l --color=always --group-directories-first"  # long format
alias lt="exa -aT --color=always --group-directories-first" # tree listing

# Colorize grep output and changing it to ripgrep
alias grep="grep --color=auto"

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
set -o vi

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

# Auto-completion
source /etc/bash_completion
source /etc/bash_completion.d/git-prompt

# Git coloring
function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_CYAN
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_YELLOW
  fi
}
