
-- General Settings
vim.opt.swapfile = false

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
vim.opt.foldmethod = "syntax"

-- Vertical bar
vim.cmd [[
  set cc=80
]]

-- Snappier gitgutter
vim.opt.updatetime = 100

-- Autocompletion
vim.opt.completeopt="menu,menuone,noselect,noinsert"

-- Whitespace
vim.opt.listchars = {eol = '↵',trail='·',extends='◣',precedes='◢',nbsp='○',tab='>-'}
vim.opt.list = true
