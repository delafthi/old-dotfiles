# Neovim

Neovim is a Vim-based text editor engineered for extensibility and usability, to
encourage new applications and contributions.

## Dependencies

- I use the nightly version of neovim. However, currently I think the version
  0.5 will also do fine.
- All dependencies and plugins will be installed automatically except tools
  called from within neovim. Such tools are:
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [fd](https://github.com/sharkdp/fd)
  - [github-cli](https://cli.github.com/)
  - LSP servers:
    - [bashls](https://github.com/bash-lsp/bash-language-server)
    - [cmakels](https://github.com/regen100/cmake-language-server)
    - [clangd](https://github.com/clangd/clangd)
    - [dockerls](https://github.com/rcjsuen/dockerfile-language-server-nodejs)
    - [hls](https://github.com/haskell/haskell-language-server)
    - [rust_hdl](https://github.com/VHDL-LS/rust_hdl)
    - [python-lsp-server](https://github.com/python-lsp/python-lsp-server)
      - [python-rope](https://github.com/python-rope/rope)
      - [python-pyflakes](https://github.com/PYCQA/pyflakes)
      - [python-mccabe](https://github.com/PYCQA/mccabe)
      - [python-pycodestyle](https://github.com/PYCQA/pycodestyle)
      - [python-lsp-black](https://github.com/python-lsp/python-lsp-black)
      - [python-lsp-flake8](https://github.com/emanspeaks/pyls-flake8)
      - [python-lsp-isort](https://github.com/paradoxxxzero/pyls-isort)
    - [lua-language-server](https://github.com/sumneko/lua-language-server)
    - [texlab](https://github.com/latex-lsp/texlab)
    - [vimls](https://github.com/iamcco/vim-language-server)
  - Code formatters
    - [black](https://github.com/psf/black)
    - [clang-format](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
    - [cmake-format](https://github.com/cheshirekow/cmake_format)
    - [prettier](https://prettier.io/)
    - [rustfmt](https://github.com/rust-lang/rustfmt)
    - [shfmt](https://github.com/mvdan/sh)
    - [emacs](https://www.gnu.org/software/emacs/)

## References

- [Neovim](https://neovim.io/)
