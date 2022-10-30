require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'nanotee/sqls.nvim'
  use 'p00f/clangd_extensions.nvim'
  use 'neovim/nvim-lspconfig'
  use 'tpope/vim-abolish'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
	use 'tanvirtin/monokai.nvim'
  use {
  'romgrk/barbar.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons'
    }
  }
  use {
  'nvim-lualine/lualine.nvim',
    requires = { 
      'kyazdani42/nvim-web-devicons', opt = true 
    }
  }
  use 'airblade/vim-gitgutter'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
end)

require('monokai').setup {}

