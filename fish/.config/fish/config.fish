# ~/.config/fish/config.fish: executed by fish for non-login shells.

#-------------------------------------------------------------------------------
# General settings

# set vim as the manpager
set -gx MANPAGER "/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma' -\""

# Fish options
# Remove greeting message
set fish_greeting

#-------------------------------------------------------------------------------
# Abbreviations

abbr -a sudo "sudo "

# navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .3 "cd ../../.."
abbr -a .4 "cd ../../../.."
abbr -a .5 "cd ../../../../.."

# vim
abbr -a vim "nvim"
abbr -a vi "nvim"
abbr -a :q "exit"

# Changing "ls" to "exa"
abbr -a ls "exa -al --color=always --group-directories-first" # my preferred listing
abbr -a la "exa -a --color=always --group-directories-first"  # all files and dirs
abbr -a ll "exa -l --color=always --group-directories-first"  # long format
abbr -a lt "exa -aT --color=always --group-directories-first" # tree listing

# Colorize grep output and changing it to ripgrep
abbr -a grep "grep --color=auto"

# adding flags
abbr -a cp "cp -i"                          # confirm before overwriting something
abbr -a df "df -h"                          # human-readable sizes
abbr -a free "free -m"                      # show sizes in MB
abbr -a rm "rm -i"
abbr -a mv "mv -i"
abbr -a minicom "minicom -m -c on"
abbr -a htop "htop -t"

# shutdown or reboot
abbr -a ssn "sudo shutdown now"
abbr -a sr "sudo reboot"

#-------------------------------------------------------------------------------
# Environment variables
set -U EDITOR "nvim"                      # $EDITOR use Neovim in terminal
set -U GCC_COLORS "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if test -d $HOME/.bin
  set -U PATH $HOME/.bin $PATH
end

if test -d $HOME/.local/bin
  set -U PATH $HOME/.local/bin $PATH
end

#-------------------------------------------------------------------------------
# Keybindings

# Set vi mode
fish_vi_key_bindings

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
