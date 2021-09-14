# Neovim

Neovim is a terminal based text editor with a f

## Dependencies

- I use the nightly version of neovim. However, currently I think the version
  0.5 will also do fine.
- All dependencies and plugins will be installed automatically except tools
  called from within neovim. Such tools are:
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [fd](https://github.com/sharkdp/fd)
  - LSP servers:
    - [bashls](https://github.com/bash-lsp/bash-language-server)
    - [cmake](https://github.com/regen100/cmake-language-server)
    - [clangd](https://github.com/clangd/clangd)
    - [dockerls](https://github.com/rcjsuen/dockerfile-language-server-nodejs)
    - [hls](https://github.com/haskell/haskell-language-server)
    - [python-lsp-server](https://github.com/python-lsp/python-lsp-server)
      - [python-lsp-black](https://github.com/python-lsp/python-lsp-black)
      - [python-lsp-flake8](https://github.com/emanspeaks/pyls-flake8/)
    - [lua-language-server](https://github.com/sumneko/lua-language-server)
    - [texlab](https://github.com/latex-lsp/texlab)
    - [vimls](https://github.com/iamcco/vim-language-server)
  - Code formatters
    - [black](https://github.com/psf/black)
    - [clang-format](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
    - [hindent](https://hackage.haskell.org/package/hindent)
    - [prettier](https://prettier.io/)
    - [scalafmt](https://scalameta.org/scalafmt/)
    - [shfmt](https://github.com/mvdan/sh)
    - [stylua](https://github.com/johnnymorganz/stylua)

## References

- [Neovim](https://neovim.io/)
