# Fish

Fish in my opinion the best shell. It has great autosuggestion, hightlighting
and completion. The configuration is very similar to the bash configuration.
Therefore, the configuration has nearly the same dependencies.

## Dependencies

- [bat](https://github.com/sharkdp/bat)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [neovim](https://github.com/neovim/neovim) (As a manpager and default editor)
- [exa](https://github.com/ogham/exa)
- [starship](https://starship.rs/)
- [pyenv](https://github.com/pyenv/pyenv) (Suggested to install over the default
  package manager)
  - [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
- [foreign-env](https://github.com/oh-my-fish/plugin-foreign-env): This plugin
  is needed for nix to work in fish. It will be automatically installed to
  `~/.config/fish/plugins`.
- [nix](https://nixos.org/) (As an alternative package manager)

## References

- [Fish](https://fishshell.com/)
- [Arch Wiki](https://wiki.archlinux.org/title/Fish)
