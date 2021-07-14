local cmd = vim.cmd -- to execute vim commands without any output
local fn = vim.fn -- to execute vim functions

-- Install packer.nvim, if it is not yet installed {{{1
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  if fn.input('Packer not installed! Download and install packer.nvim? [Y/n] ') == 'n' then
    return
  end
  print(' ')
  local out = fn.system({'git', 'clone',
    'https://github.com/wbthomason/packer.nvim', install_path})
  print(out)
  cmd [[packadd packer.nvim]]
  print('Installation of packer.nvim successfull. Run :PackerSync to download',
    'and install all plugins. In case of failures rerun :PackerSync until the',
    'the installation succeeeds.')
end

-- Run PackerCompile automatically whenever plugins.lua is updated
cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-- Plugin specification {{{1
require('packer').startup {
  function(use)
    -- Packer can manage itself
    use {'wbthomason/packer.nvim'}
    -- Colors
    use {
      'shaunsingh/nord.nvim',
      setup = require('config.nord').setup(),
      config = require('config.nord').config(),
    }
    -- Comment
    use {
      'b3nj5m1n/kommentary',
      setup = require('config.kommentary').setup(),
      config = require('config.kommentary').config(),
    }
    -- Completion
    use {
      'hrsh7th/nvim-compe',
      setup = require('config.nvim-compe').setup(),
      config = require('config.nvim-compe').config(),
    }
    -- Debugging
    use {
      'mfussenegger/nvim-dap',
      -- config = require('config.nvim-dap').config(),
    }
    -- Fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'},
      },
      config = require('config.telescope').config(),
    }
    -- Git
    use {
      'TimUntersberger/neogit',
      requires = {'nvim-lua/plenary.nvim'},
      config = require('config.neogit').config(),
    }
    use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = require('config.gitsigns').config(),
    }
    -- LSP
    use {
      'neovim/nvim-lspconfig',
      requires = {
        {'nvim-lua/lsp-status.nvim'},
        {'nvim-lua/lsp_extensions.nvim'}
      },
      config = require('config.nvim-lspconfig').config(),
    }
    use {
      'folke/trouble.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = require('config.trouble').config(),
    }
    -- Movement
    use {
      'justinmk/vim-sneak',
    }
    -- Note taking
    use {
      'vimwiki/vimwiki',
      setup = require('config.vimwiki').setup(),
    }
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app & yarn install',
      ft = {'markdown', 'vimwiki'},
      setup = require('config.markdown-preview').setup(),
      config = require('config.markdown-preview').config(),
    }
    -- Snippets
    use {
      'norcalli/snippets.nvim',
      config = require('config.snippets').config(),
    }
    -- Start screen
    use {
      'glepnir/dashboard-nvim',
      config = function() vim.g.dashboard_default_executive = 'telescope' end,
    }
    -- Statusline
    use {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      requires = {
        {'kyazdani42/nvim-web-devicons', opt = true},
        'shaunsingh/nord.nvim',
      },
      config = require('config.galaxyline').config()
      }
    -- Syntax highlighting
    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {'p00f/nvim-ts-rainbow'},
      run = ':TSUpdate',
      config = require('config.nvim-treesitter').config(),
    }
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        local ok, colorizer = pcall(function()
          return require('colorizer')
        end)
        if ok then
          colorizer.setup()
        end
      end,
    }
    -- Text editing
    use {
      'godlygeek/tabular',
      cmd = 'Tabularize',
    }
    use {
      'blackCauldron7/surround.nvim',
      setup = require('config.surround').setup(),
      config = require('config.surround').config(),
    }
    -- Visuals/aesthetics
    use {
      'lukas-reineke/indent-blankline.nvim',
      branch = 'master',
      setup = require('config.indent-blankline').setup(),
    }
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
}
