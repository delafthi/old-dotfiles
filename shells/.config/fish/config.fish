######################################################################
# ~/.config/fish/config.fish: executed by fish for non-login shells. #
######################################################################

# Environment
# ~~~~~~~~~~~

# Only export variables if we use systemd, (in Guix the environment is exported
# with a service)
if test (ps -p 1 -o comm=) = systemd
    set -gx PATH "$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
    set -gx GUIX_PROFILE "$HOME/.config/guix/current"
    set -e SSH_AGENT_PID
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
    set -gx EDITOR nvim
    set -gx MANPAGER "nvim +Man! +'set noma'"
    set -gx GCC_COLORS "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
end

# Abbreviations and aliases
# ~~~~~~~~~~~~~~~~~~~~~~~~~

# sudo
alias sudo="sudo -E"

# navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .3 "cd ../../.."
abbr -a .4 "cd ../../../.."
abbr -a .5 "cd ../../../../.."

# vim like exit
abbr -a :q exit

# Adding flags
alias cp="cp -i" # confirm before overwriting something
alias df="df -h" # human-readable sizes
alias free="free -m" # show sizes in MB
alias rm="rm -i"
alias mv="mv -i"
alias minicom="minicom -m -c on"
alias htop="htop -t"
alias gl="lazygit"
alias tn="tmux new -s (pwd | sed 's/.*\///g')"

# General settings
# ~~~~~~~~~~~~~~~~

# Remove greeting message
set fish_greeting

# Set window title
function fish_title
    echo $argv[1]
    pwd
end

# Enable vi bindings and cursor
set -g fish_key_bindings fish_vi_key_bindings

# Set command not found handler to the default one
function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

# Keybindings
# ~~~~~~~~~~~

bind -M insert \cq exit
bind -M insert \ck up-or-search
bind -M insert \cj down-or-search
bind -M insert \cp up-or-search
bind -M insert \cn complete
bind -M insert \cs pager-toggle-search
bind -M insert -k nul accept-autosuggestion
# Rebind <C-c> to clear the input line in all modes
bind -M insert \cc cancel-commandline repaint-mode
bind \cc 'commandline -f cancel-commandline; set fish_bind_mode insert; commandline -f repaint-mode'


# Visuals
# ~~~~~~~

# Load dircolors
test -r ~/.dir_colors && eval (dircolors -c ~/.dir_colors)

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
set fish_vi_force_cursor
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

function nofunc --description "Run command ignoring functions and aliases"
    functions -c $argv[1] functionholder
    functions --erase $argv[1]
    $argv
    functions -c functionholder $argv[1]
    functions --erase functionholder
end

# Settings with dependencies
# ~~~~~~~~~~~~~~~~~~~~~~~~~~

# Use fzf in combination with grep
# fzf colors
if command -v fzf 1>/dev/null 2>&1
    set -gax FZF_DEFAULT_OPTS " \
      --color='fg:#d8dee9,bg:#2e3440,fg+:#81a1c1,bg+:#2e3440,border:#4c566a' \
      --color='info:#81a1c1,spinner:#b48ead,header:#bf616a,prompt:#b48ead' \
      --color='hl:#ebcb8b,hl+:#ebcb8b,pointer:#b48ead,marker:#d08770' \
      --color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' \
      --color='hl:reverse,hl+:reverse'"
end

# Use the ssh kitten of kitty if we ssh from kitty
if test "$TERM" = "xterm-kitty"
  alias ssh="kitty +kitten ssh"
end

# Changing "ls" to "exa"
if command -v exa 1>/dev/null 2>&1
    set -gx EXA_COLORS "xx=02;37"
    alias ls="exa -al --color=always --group-directories-first"
    alias la="exa -a --color=always --group-directories-first"
    alias ll="exa -l --color=always --group-directories-first"
    alias lt="exa -aT --color=always --group-directories-first"
end

# Use nvim as default editor
if command -v nvim 1>/dev/null 2>&1
    alias vim="nvim"
    alias vi="nvim"
end


# Plugins
# ~~~~~~~

if not test -d $HOME/.config/fish/plugins
    mkdir -p $HOME/.config/fish/plugins
end

# Starship prompt
# Change default config directory
if not command -v starship 1>/dev/null 2>&1
    set_color --bold red
    echo -n "=> Error: "
    set_color normal
    echo -e "Starship not installed.\n"
    set_color --bold green
    echo -n "=> Info: "
    set_color normal
    echo "Please install starship through your package manager or manually. An installation guide can be found here: https://starship.rs/guide/#%F0%9F%9A%80-installation"
else
    set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml
    starship init fish | source
end

# foreign-env
if not test -d $HOME/.config/fish/plugins/foreign-env
    mkdir -p $HOME/.config/fish/plugins/foreign-env
    git clone https://github.com/oh-my-fish/plugin-foreign-env $HOME/.config/fish/plugins/foreign-env
end
set fish_function_path $fish_function_path $HOME/.config/fish/plugins/foreign-env/functions

# direnv
if command -v direnv 1>/dev/null 2>&1
    direnv hook fish | source
    direnv reload 2>/dev/null
end

# Guix (only executed if not in a guix system)
if test (cat /etc/os-release | sed -nr 's/^ID=()/\1/p') != guix
    if command -v guix 1>/dev/null 2>&1
        fenv source $GUIX_PROFILE/etc/profile
    end
end
