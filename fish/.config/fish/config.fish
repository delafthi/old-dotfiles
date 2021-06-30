######################################################################
# ~/.config/fish/config.fish: executed by fish for non-login shells. #
######################################################################

############################################################
# General settings {{{1

# Remove greeting message
set fish_greeting

# Set window title
function fish_title
  echo $argv[1]
  pwd
end

# Set vim keybinding
function fish_user_key_bindings
  fish_vi_cursor
  fish_vi_key_bindings
end

# Set command not found handler to the default one
function fish_command_not_found
  __fish_default_command_not_found_handler $argv
end

############################################################
# Abbreviations and aliases {{{1

# sudo
alias sudo="sudo -s"

# navigation
abbr -a .. "cd .."
abbr -a ... "cd ../.."
abbr -a .3 "cd ../../.."
abbr -a .4 "cd ../../../.."
abbr -a .5 "cd ../../../../.."

# vim like exit
abbr -a :q "exit"

# Adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df="df -h"                          # human-readable sizes
alias free="free -m"                      # show sizes in MB
alias rm="rm -i"
alias mv="mv -i"
alias minicom="minicom -m -c on"
alias htop="htop -t"

############################################################
# Environment variables {{{1

# Set the default editor, this variable is overwritten in case neovim is
# installed
set -gx EDITOR "vi"
set -gx SSH_KEY_PATH "~/.ssh/rsa_id" # Set default ssh key path
set -gx GCC_COLORS "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Path
if test -d $HOME/.bin
  set -gx PATH $HOME/.bin $PATH
end

if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

############################################################
# Visuals {{{1

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
set fish_cursor_default block
set fish_cursor_visual block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

############################################################
# Functions {{{1

function ex --description "Function to extract most types of archives"
  if test -f $argv
    switch $argv
      case --help
        echo "usage: ex <file>"
      case '*.tar.bz2'
        tar xjf $argv
      case '*.tar.gz'
        tar xzf $argv
      case '*.bz2'
        bunzip2 $argv
      case '*.rar'
        unrar x $argv
      case '*.gz'
        gunzip $argv
      case '*.tar'
        tar xf $argv
      case '*.tbz2'
        tar xjf $argv
      case '*.tgz'
        tar xzf $argv
      case '*.zip'
        unzip $argv
      case '*.Z'
        uncompress $argv
      case '*.7z'
        7z x $argv
      case '*.deb'
        tar x $argv
      case '*.tar.xz'
        tar xf $argv
      case '*.tar.zst'
        unzstd $argv
      case '*'
        echo "'$argv' cannot be extracted via ex"
    end
  else
    echo "'$argv' is not a valid file"
  end
end

function nofunc --description "Run command ignoring functions and aliases"
  functions -c $argv[1] functionholder
  functions --erase $argv[1]
  $argv
  functions -c functionholder $argv[1]
  functions --erase functionholder
end

############################################################
# Settings with dependencies {{{1

# Set defaults for bat
if command -v bat 1>/dev/null 2>&1 and command -v rg 1>/dev/null 2>&1
  alias bat="bat --italic-text=always --color=always --theme Nord"

  function batgrep --description "Uses ripgrep instead of grep and outputs via bat"
    rg $argv --hidden --color always | bat --paging=never
  end
  alias grep="batgrep"

  function batfind --description "Uses ripgrep --files instead of find and outputs via bat"
    rg $argv --ignore --color=always --smart-case --hidden --files | bat
  end
  alias find="batfind"

  function batdiff --description "Uses bat for a nicer git diff"
    git diff $argv --name-only --diff-filter=d | xargs bat --diff
  end
end

# Use fzf in combination with grep
# fzf colors
if command -v bat 1>/dev/null 2>&1 and command -v rg 1>/dev/null 2>&1
  alias fzf="fzf \
    --color='fg:#d8dee9,bg:#2e3440,fg+:#81a1c1,bg+:#2e3440,border:#4c566a' \
    --color='info:#81a1c1,spinner:#b48ead,header:#bf616a,prompt:#b48ead' \
    --color='hl:#ebcb8b,hl+:#ebcb8b,pointer:#b48ead,marker:#d08770' \
    --color='fg+:reverse,header:bold,pointer:bold,marker:bold,prompt:bold' \
    --color='hl:reverse,hl+:reverse'"

  set INITIAL_QUERY ""
  set RG_PREFIX "rg --ignore --hidden --column --line-number --with-filename --no-heading --color=always --smart-case "
  set FZF_DEFAULT_COMMAND "$RG_PREFIX '$INITIAL_QUERY'"
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
    --style=numbers \
    --line-range :500 {}'"
end

# Forward term info in kitty when connection via ssh
if string match -q "xterm-kitty" -- $TERM
  alias ssh="kitty +kitten ssh"
end

# Changing "ls" to "exa"
if command -v exa 1>/dev/null 2>&1
  alias ls="exa -al --color=always --group-directories-first"
  alias la="exa -a --color=always --group-directories-first"
  alias ll="exa -l --color=always --group-directories-first"
  alias lt="exa -aT --color=always --group-directories-first"
end

# Use nvim as default editor
if command -v nvim 1>/dev/null 2>&1
  alias vim="nvim"
  alias vi="nvim"
  # set vim as the manpager
  set -gx MANPAGER "nvim +Man!"
  set -gx EDITOR "nvim" # $EDITOR use Neovim in terminal
end

# Check if the shell was opened from ranger before opening a new ranger
function ranger --description "Check the ranger level before opening ranger."
  if test "$RANGER_LEVEL"
    exit
  else
    /usr/bin/ranger $argv
  end
end

############################################################
# Plugins {{{1

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

# Nix
# has to be defined after foreign-env
if test -f /etc/profile.d/nix.sh
  fenv source /etc/profile.d/nix.sh
end

# pyenv
if command -v pyenv 1>/dev/null 2>&1
  pyenv init --path | source
  pyenv init - | source
  if not test -d $PYENV_ROOT/plugins/pyenv-virtualenv
    set_color --bold red
    echo -n "=> Error: "
    set_color normal
    echo -e "pyenv-virtualenv not installed.\n"
    set_color --bold green
    echo -n "=> Info: "
    set_color normal
    echo "Please install pyenv-virtualenv through your package manager or manually. An installation guide can be found here: https://github.com/pyenv/pyenv-virtualenv#installation"
  else
    pyenv virtualenv-init - | source
  end
end

# }}}1
