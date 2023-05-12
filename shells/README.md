# Shells

A shell is a program that helps you operate your computer by starting other
programs. fish offers a command-line interface focused on usability and
interactive use.

## Fish

fish is a smart and user-friendly command line shell for Linux, macOS, and the
rest of the family.

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

Bash is the GNU Project's shell—the Bourne Again SHell. This is an sh-compatible
shell that incorporates useful features from the Korn shell (ksh) and the C
shell (csh). It is intended to conform to the IEEE POSIX P1003.2/ISO 9945.2
Shell and Tools standard. It offers functional improvements over sh for both
programming and interactive use. In addition, most sh scripts can be run by Bash
without modification.

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

## Starship

An easily configurable and nice looking shell prompt.

### Dependencies

- [Victor Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts) based on
  [Victor Mono](https://github.com/rubjo/victor-mono)
- Emoji font like
  [noto-fonts-emoji](https://archlinux.org/packages/extra/any/noto-fonts-emoji/)
  or [openmoji](https://openmoji.org/)

### References

- [Starship](https://starship.rs/)
