  local custom_lsp_attach = function(_, bufnr)
    print('LSP attached')
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

  require'lspconfig'.yamlls.setup {
    settings = {
      yaml = {
        schemaStore = {
          url = "https://www.schemastore.org/api/json/catalog.json",
          enable = true,
        }
      }
    },
    on_attach = custom_lsp_attach
  }
