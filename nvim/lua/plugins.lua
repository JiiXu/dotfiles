require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

  -- Monokai theme
  use 'tanvirtin/monokai.nvim'
--
  -- Gitgutter shows git information in the margin
  use 'airblade/vim-gitgutter'

  -- Abolish is a case-matching substitute command (:S/)
  use 'tpope/vim-abolish'

  -- Barbar is a tab bar
  use {
  'romgrk/barbar.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons'
    }
  }

  -- Vimtree is a great file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- LuaLine is an info line shown on the bottom
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 
      'kyazdani42/nvim-web-devicons', opt = true 
    }
  }

  -- nvim-lsp helps us set up language servers
  use 'neovim/nvim-lspconfig'

  -- nvim-dap is a debugging adapter, allowing us to attach debuggers to neovim
  -- here it is installed together with some helper plugins;
    -- nvim-dap-virtual-text, nvim-dap-ui, and telescope-dap.nvim are UI/UX extensions for nvim-dap that provide a better user experience.
    -- nvim-dap-python is the language extension providing default debug configurations for Python.
    -- one-small-step-for-vimkind is a debugger adapter that allows us to debug any Lua code running in a Neovim instance.
    -- which-key is a plugin which displays possible keybindings
    --
    -- Mason is a package manager for lsp and dap configurations, linters and the like
    -- mason-lspconfig is an extension for mason which integrates with nvim-lspconfig
    -- mason-tool-installer is a plugin that helps configure mason

   -- Note that the setup is run here, as it requires a returned
   -- dict of some sort - I'm not 100% sure how to integrate this
   -- with the setup scheme I've used for other plugins.
  use 'williamboman/mason.nvim'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui'
  use 'mfussenegger/nvim-dap-python'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'folke/which-key.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'WhoIsSethDaniel/mason-tool-installer.nvim'
  use {
    'mfussenegger/nvim-dap',
    opt = true,
    event = 'BufReadPre',
    module = { 'dap' },
    wants = { 
      'nvim-dap-virtual-text', 
      'nvim-dap-ui', 
      'nvim-dap-python', 
      'which-key.nvim',
      'mason.nvim',
      'mason-lspconfig.nvim',
      'mason-tool-installer.nvim'
    },
    requires = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
      'nvim-telescope/telescope-dap.nvim',
      'folke/which-key.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'jbyuki/one-small-step-for-vimkind', module = 'osv' },
    },
    config = function()
      require('nvim-dap-cfg').setup()
    end,
  }

  -- ...what a nightmare. Now onto something more fun; nvim-cmp is an autocompletion tool!
  use 'hrsh7th/nvim-cmp'          -- nvim-cmp itself
  use 'hrsh7th/cmp-nvim-lsp'      -- plugin to interact with lsp
  use 'hrsh7th/cmp-buffer'        -- a buffer plugin, used by nvim-cmp but not included >:(
  use 'hrsh7th/cmp-path'          -- path completion
  use 'hrsh7th/cmp-cmdline'       -- command line completion
  use 'L3MON4D3/LuaSnip'          -- nvim-cmp requires a snip engine; we use luasnip because why not
  use 'saadparwaiz1/cmp_luasnip'  -- this is a luasnip completion source, I honestly don't know why I need/wanted it

  -- lspkind gives us cool icons in nvim-cmp
  use 'onsails/lspkind.nvim'


end)

