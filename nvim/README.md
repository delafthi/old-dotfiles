# Neovim

Neovim is a Vim-based text editor engineered for extensibility and usability, to
encourage new applications and contributions.

## Dependencies

- All dependencies and plugins will be installed automatically except tools
  called from within neovim. Such tools are:
  - [fd](https://github.com/sharkdp/fd)
  - [github-cli](https://cli.github.com/)
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [fennel](https://fennel-lang.org/)
  - LSP servers:
    - [bashls](https://github.com/bash-lsp/bash-language-server)
      - [shellcheck](https://github.com/koalaman/shellcheck)
    - [cmakels](https://github.com/regen100/cmake-language-server)
    - [clangd](https://github.com/clangd/clangd)
    - [dockerls](https://github.com/rcjsuen/dockerfile-language-server-nodejs)
    - [lua-language-server](https://github.com/sumneko/lua-language-server)
    - [python-lsp-server](https://github.com/python-lsp/python-lsp-server)
      - [flake8](https://github.com/PyCQA/flake8)
      - [python-mccabe](https://github.com/PYCQA/mccabe)
      - [python-pycodestyle](https://github.com/PYCQA/pycodestyle)
      - [python-pyflakes](https://github.com/PYCQA/pyflakes)
      - [python-rope](https://github.com/python-rope/rope)
    - [rust_hdl](https://github.com/VHDL-LS/rust_hdl)
    - [texlab](https://github.com/latex-lsp/texlab)
    - [vimls](https://github.com/iamcco/vim-language-server)
  - [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md)
    - Code actions
      - [eslint](https://github.com/eslint/eslint)
    - Diagnostics
      - [checkmake](https://github.com/mrtazz/checkmake)
      - [editorconfig_checker](https://github.com/editorconfig-checker/editorconfig-checker)
      - [eslint](https://github.com/eslint/eslint)
      - [selene](https://github.com/Kampfkarren/selene)
    - Formatters
      - [python-black](https://github.com/psf/black)
      - [cbfmt](https://github.com/lukas-reineke/cbfmt)
      - [deno](https://deno.land/)
      - [fnlfmt](https://git.sr.ht/~technomancy/fnlfmt)
      - [isort](https://github.com/PyCQA/isort)
      - [prettier](https://git.sr.ht/~technomancy/fnlfmt)
      - [shfmt](https://github.com/mvdan/sh)
      - [stylua](https://github.com/JohnnyMorganz/StyLua)
      - [emacs](https://www.gnu.org/savannah-checkouts/gnu/emacs/emacs.html)

## References

- [Neovim](https://neovim.io/)
