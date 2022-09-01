# Shells

This folder contains the configuration for the shells I use; Fish as my main
shell and bash as a secondary shell.

## Fish

Fish in my opinion the best shell. It has great autosuggestion, hightlighting
and completion. The configuration is very similar to the bash configuration.
Therefore, the configuration has nearly the same dependencies.

### Dependencies

- [bat](https://github.com/sharkdp/bat)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [neovim](https://github.com/neovim/neovim) (As a manpager and default editor)
- [exa](https://github.com/ogham/exa)
- [starship](https://starship.rs/)
- [direnv](https://github.com/direnv/direnv)
- [foreign-env](https://github.com/oh-my-fish/plugin-foreign-env): This plugin
  will be automatically installed to `~/.config/fish/plugins`.

### References

- [Fish](https://fishshell.com/)
- [Arch Wiki](https://wiki.archlinux.org/title/Fish)

## Bash

Probably the most popular shell, which is widely used in the industry.

### Dependencies

The only hard dependency of this configuration is `bash_completion`, which is in
my opinion a necessity for bash. The following dependency are not required.
However, I highly suggest you to install them.

- [bat](https://github.com/sharkdp/bat)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [neovim](https://github.com/neovim/neovim) (As a manpager and default editor)
- [exa](https://github.com/ogham/exa)
- [starship](https://starship.rs/)
- [direnv](https://github.com/direnv/direnv)

### References

- [Arch Wiki](https://wiki.archlinux.org/title/Bash)

## Dircolors

The dircolors configuration sets the `LS_COLORS` variable, which defines colors
in the shell and parts of the highlighting.

### References

- [Arch Wiki](https://wiki.archlinux.org/title/Color_output_in_console)

## Starship

An easily configurable and nice looking shell prompt.

### Dependencies

- [Nerd Fonts](https://www.nerdfonts.com/#home)
- Emoji font like [noto-fonts-emoji](https://archlinux.org/packages/extra/any/noto-fonts-emoji/)

### References

- [Starship](https://starship.rs/)

## Bat

A cat(1) clone with syntax highlighting and Git integration.

### References

- [bat](https://github.com/sharkdp/bat)
