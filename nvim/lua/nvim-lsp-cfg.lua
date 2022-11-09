
-- define a function to be run each time neovim attaches an LSP
local custom_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings which are only set on attach
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=false, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<space>d', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<space>K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set('n', '<Leader>wl', function()
  --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>rf', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>=', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- Functionality to highlight the symbol under the cursor
  vim.cmd [[
    hi! LspReferenceRead cterm=bold ctermbg=235 guibg=Purple
    hi! LspReferenceText cterm=bold ctermbg=235 guibg=Purple
    hi! LspReferenceWrite cterm=bold ctermbg=235 guibg=Purple
  ]]
  vim.api.nvim_create_augroup('lsp_document_highlight', {})
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = 'lsp_document_highlight',
    buffer = 0,
    callback = vim.lsp.buf.document_highlight,
  })
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = 'lsp_document_highlight',
    buffer = 0,
    callback = vim.lsp.buf.clear_references,
  })
end

-- list of installed language servers
local servers = { 'pyright', 'clangd' }

-- set require statement as local variable
-- (basically an alias)
local nvim_lsp = require( 'lspconfig' )

-- run setup for each listed language server
for _, lsp in ipairs( servers ) do
  nvim_lsp[lsp].setup {
    on_attach = custom_attach,
    root_dir = nvim_lsp.util.root_pattern('foo', 'bar', 'baz')
  }
end

-- Mappings which are always set
-- I feel like <space> as a modifier is pretty unique to LSP so I
-- remap prev error and next error to <space>j/k to make it vim-y
-- Also, <space>q is easy to remember as a menu opener since it's what I use
-- for vimtree.
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>k', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<space>j', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

