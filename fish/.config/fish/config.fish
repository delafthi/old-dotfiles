# ~/.config/fish/config.fish: executed by fish for non-login shells.

#-------------------------------------------------------------------------------
# General settings

# set vim as the manpager
set -gx MANPAGER "/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""

# Fish options
# Remove greeting message
set fish_greeting

#-------------------------------------------------------------------------------
# Abbreviations and aliases

# sudo
alias sudo="sudo "

# navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .3 "cd ../../.."
abbr -a .4 "cd ../../../.."
abbr -a .5 "cd ../../../../.."

# vim like exit
abbr -a :q "exit"

# neovim
alias vim="nvim"
alias vi="nvim"

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first"
alias la="exa -a --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first"

# Colorize grep output
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

#-------------------------------------------------------------------------------
# Environment variables
set -gx EDITOR "nvim" # $EDITOR use Neovim in terminal
set -gx SSH_KEY_PATH "~/.ssh/rsa_id" # Set default ssh key path
set -gx GCC_COLORS "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if test -d $HOME/.bin
  set -gx PATH $HOME/.bin $PATH
end

if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

#-------------------------------------------------------------------------------
# Visuals

# Set the fish syntax highlighting colors
set fish_color_normal white
set fish_color_command magenta
set fish_color_quote green
set fish_color_redirection blue
set fish_color_end white
set fish_color_error red --bold
set fish_color_param white
set fish_color_comment brblack --italics
set fish_color_match cyan --bold
set fish_color_selection --reverse
set fish_color_search_match --reverse
set fish_color_operator yellow
set fish_color_escape yellow
set fish_color_cwd yellow
set fish_color_autosuggestion brblack --italics
set fish_color_user blue
set fish_color_host blue
set fish_color_host_remote purple
set fish_color_cancel red

# Vi cursor style
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

# VCS config
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_color green
set __fish_git_prompt_color_prefix green
set __fish_git_prompt_color_suffix green
set __fish_git_prompt_color_bare yellow
set __fish_git_prompt_color_merging brred
set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_char_dirtystate ''
set __fish_git_prompt_color_stagedstate cyan
set __fish_git_prompt_char_stagedstate ''
set __fish_git_prompt_color_untrackedfiles yellow
set __fish_git_prompt_color_upstream magenta
set __fish_git_prompt_color_branch green
set __fish_git_prompt_color_branch_detached red --bold
