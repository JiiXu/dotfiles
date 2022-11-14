-- === General Settings ===
vim.opt.swapfile = false

vim.g.mapleader = ','

-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Searching
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indentation, folding and styling
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.foldmethod = 'syntax'

-- Vertical bar at 80 chars
vim.cmd [[ set cc=80 ]]

-- Snappier gitgutter
vim.opt.updatetime = 100

-- Autocompletion
vim.opt.completeopt='menu,menuone,noselect,noinsert'

-- Show whitespace
vim.opt.listchars = {eol = '↵',trail='·',extends='◣',precedes='◢',nbsp='○',tab='>-'}
vim.opt.list = true

-- === Plugins and Configurations ===

-- Custom Keybindings
require('keybindings')

-- Plugin management (packer)
require('plugins')

-- Theme management
require('theme')

-- run plugin configurations
require('vimtree-cfg')
require('barbar-cfg')
require('lualine-cfg')
require('nvim-lsp-cfg')
require('nvim-dap-cfg')
require('auto-cmd-cfg')
