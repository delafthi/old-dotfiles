# Neovim

Neovim is a Vim-based text editor engineered for extensibility and usability, to
encourage new applications and contributions.

## Dependencies

- I use the nightly version of neovim. However, currently I think the version
  0.5 will also do fine.
- All dependencies and plugins will be installed automatically except tools
  called from within neovim. Such tools are:
  - [fd](https://github.com/sharkdp/fd)
  - [github-cli](https://cli.github.com/)
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - LSP servers:
    - [bashls](https://github.com/bash-lsp/bash-language-server)
    - [cmakels](https://github.com/regen100/cmake-language-server)
    - [clangd](https://github.com/clangd/clangd)
    - [dockerls](https://github.com/rcjsuen/dockerfile-language-server-nodejs)
    - [lua-language-server](https://github.com/sumneko/lua-language-server)
    - [python-lsp-server](https://github.com/python-lsp/python-lsp-server)
      - [python-rope](https://github.com/python-rope/rope)
      - [python-pyflakes](https://github.com/PYCQA/pyflakes)
      - [python-mccabe](https://github.com/PYCQA/mccabe)
      - [python-pycodestyle](https://github.com/PYCQA/pycodestyle)
      - [yapf](https://github.com/google/yapf)
    - [rust_hdl](https://github.com/VHDL-LS/rust_hdl)
    - [texlab](https://github.com/latex-lsp/texlab)
    - [vimls](https://github.com/iamcco/vim-language-server)
  - Code formatters
    - [emacs](https://www.gnu.org/software/emacs/)
    - [prettier](https://prettier.io/)
    - [shfmt](https://github.com/mvdan/sh)

## References

- [Neovim](https://neovim.io/)
