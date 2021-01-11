# ~/.zshrc: executed by zsh(1) for non-login shells.

################################################################################
# Initialization
################################################################################
# Path to my oh-my-zsh installation
export ZSH="/home/thierryd/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

################################################################################
# Powerlevel10k
################################################################################

# Instant prompt mode.
#
#   - off:     Disable instant prompt. Choose this if you've tried instant
#              prompt and found it incompatible with your zsh configuration
#              files.
#   - quiet:   Enable instant prompt and don't print warnings
#              when detecting console output during zsh initialization. Choose
#              this if you've read and understood
#              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
#   - verbose: Enable instant prompt and print a warning when detecting console
#              output during zsh initialization. Choose this if you've never
#              tried instant prompt, haven't seen the warning, or if you are
#              unsure what this all means.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

################################################################################
# vi-mode
# Foreground color.
typeset -g POWERLEVEL9K_VI_MODE_FOREGROUND=0
# Text and color for normal (a.k.a. command) vi mode.
typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=2
# Text and color for visual vi mode.
typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
typeset -g POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND=4
# Text and color for overtype (a.k.a. overwrite and replace) vi mode.
typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_BACKGROUND=3
# Text and color for insert vi mode.
typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=
typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=7


################################################################################
# context: user@hostname
# Context color when running with privileges.
typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=178
# Context color in SSH without privileges.
typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=180
# Default context color (no privileges, no SSH).
typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=0
typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=12

# Context format when running with privileges: bold user@hostname.
typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%B%n@%m'
# Context format when in SSH without privileges: user@hostname.
typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
# Default context format (no privileges, no SSH): user@hostname.
typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'

################################################################################
# dir
typeset -g POWERLEVEL9K_DIR_BACKGROUND=3
typeset -g POWERLEVEL9K_DIR_FOREGROUND=0
# If directory is too long, shorten some of its segments to the shortest
# possible unique prefix. The shortened directory can be tab-completed to the
# original.
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
# Replace removed segment suffixes with this symbol.
typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=*
# Color of the shortened directory segments.
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=0
# Color of the anchor directory segments. Anchor segments are never shortened.
# The first segment is always an anchor.
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=0
# Display anchor directory segments in bold.
typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
# Don't shorten directories that contain any of these files. They are anchors.
local anchor_files=(
  .bzr
  .citc
  .git
  .hg
  .node-version
  .python-version
  .go-version
  .ruby-version
  .lua-version
  .java-version
  .perl-version
  .php-version
  .tool-version
  .shorten_folder_marker
  .svn
  .terraform
  CVS
  Cargo.toml
  composer.json
  go.mod
  package.json
  stack.yaml
)
typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
# Don't shorten this many last directory segments. They are anchors.
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# Shorten directory if it's longer than this even if there is space for it.
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=60%
# When `dir` segment is on the last prompt line, try to shorten it enough to
# leave at least this many columns for typing commands.
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
# When `dir` segment is on the last prompt line, try to shorten it enough to
# leave at least COLUMNS * POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT * 0.01
# columns for typing commands.
typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50

################################################################################
# vcs: git status
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=1
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=1
typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=1
typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=8

# Branch icon. Set this parameter to '\uF126 ' for the popular Powerline branch
# icon.
typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=

# Untracked files icon. It's really a question mark, your font isn't broken.
# Change the value of this parameter to show a different icon.
typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

# Formatter for Git status.
#
# Example output: master ⇣42⇡42 *42 merge ~42 +42 !42 ?42.
#
# You can edit the function to customize how Git status looks.
#
# VCS_STATUS_* parameters are set by gitstatus plugin. See reference:
# https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
function my_git_formatter() {
  emulate -L zsh

  if [[ -n $P9K_CONTENT ]]; then
    # If P9K_CONTENT is not empty, use it. It's either "loading" or from
    # vcs_info (not from gitstatus plugin). VCS_STATUS_* parameters are not
    # available in this case.
    typeset -g my_git_format=$P9K_CONTENT
    return
  fi

  # Styling for different parts of Git status.
  local       meta='%7F' # white foreground
  local      clean='%0F' # black foreground
  local   modified='%0F' # black foreground
  local  untracked='%0F' # black foreground
  local conflicted='%1F' # red foreground

  local res
  local where  # branch or tag
  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}"
    where=${(V)VCS_STATUS_LOCAL_BRANCH}
  elif [[ -n $VCS_STATUS_TAG ]]; then
    res+="${meta}#"
    where=${(V)VCS_STATUS_TAG}
  fi

  # If local branch name or tag is at most 32 characters long, show it in full.
  # Otherwise show the first 12 … the last 12.
  # Tip: To always show local branch name in full without truncation, delete the
  # next line.
  (( $#where > 32 )) && where[13,-13]="…"

  res+="${clean}${where//\%/%%}"  # escape %

  # Display the current Git commit if there is no branch or tag.
  # Tip: To always display the current Git commit, remove `[[ -z $where ]] &&`
  # from the next line.
  [[ -z $where ]] && res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

  # Show tracking branch name if it differs from local branch.
  if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
    res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"  # escape %
  fi

  # ⇣42 if behind the remote.
  (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
  # ⇠42 if behind the push remote.
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
  # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  # *42 if have stashes.
  (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
  # 'merge' if the repo is in an unusual state.
  [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
  # ~42 if have merge conflicts.
  (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
  # +42 if have staged changes.
  (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
  # !42 if have unstaged changes.
  (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
  # ?42 if have untracked files. It's really a question mark, your font isn't broken.
  # See POWERLEVEL9K_VCS_UNTRACKED_ICON above if you want to use a different icon.
  # Remove the next line if you don't want to see untracked files at all.
  (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
  # "─" if the number of unstaged files is unknown. This can happen due to
  # POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY (see below) being set to a
  # non-negative number lower than the number of files in the Git index, or due
  # to bash.showDirtyState being set to false
  # in the repository config. The number of staged and untracked files may also
  # be unknown in this case.
  (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"

  typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null

# Don't count the number of unstaged, untracked and conflicted files in Git
# repositories with more than this many files in the index. Negative value means
# infinity.
#
# If you are working in Git repositories with tens of millions of files and
# seeing performance sagging, try setting POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY
# to a number lower than the output of `git ls-files | wc -l`. Alternatively,
# add `bash.showDirtyState = false` to the repository's config: `git config
# bash.showDirtyState false`.
typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1

# Don't show Git status in prompt for repositories whose workdir matches this
# pattern. For example, if set to '~', the Git repository at $HOME/.git will be
# ignored. Multiple patterns can be combined with '|': '~(|/foo)|/bar/baz/*'.
typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

# Disable the default Git status formatting.
typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
# Install our own Git status formatter.
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter()))+${my_git_format}}'
# Enable counters for staged, unstaged, etc.
typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

# Show status of repositories of these types. You can add svn and/or hg if you are
# using them. If you do, your prompt may become slow even when your current directory
# isn't in an svn or hg reposotiry.
typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

################################################################################
# virtualenv
typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=0
typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=4
# Don't show Python version next to the virtual environment name.
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
# If set to "false", won't show virtualenv if pyenv is already shown.
# If set to "if-different", won't show virtualenv if it's the same as pyenv.
typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=if-different
# Separate environment name from Python version only with a space.
typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

################################################################################
# pyenv
typeset -g POWERLEVEL9K_PYENV_FOREGROUND=0
typeset -g POWERLEVEL9K_PYENV_BACKGROUND=4
# Hide python version if it doesn't come from one of these sources.
typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
# If set to false, hide python version if it's the same as global:
# $(pyenv version-name) == $(pyenv global).
typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
# If set to false, hide python version if it's equal to "system".
typeset -g POWERLEVEL9K_PYENV_SHOW_SYSTEM=true

################################################################################
# Powerline
# Add an empty line before each prompt.
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode context dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(pyenv virtualenv)

###############################################################################
# Oh-my-zsh
################################################################################

ZLE_RPROMPT_INDENT=0

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE=true

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE=true

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE=true

# Uncomment the following line to display red dots whilst waiting for
# completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load?
plugins=(
  git
)

source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

################################################################################
# Zsh settings
################################################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set vim as manpager
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""

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

# Colorize grep output and changing it to ripgrep
alias grep="grep --color=auto"

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
