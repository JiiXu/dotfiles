local lspconfig = require 'lspconfig'
local icons = require 'icons'

require('mason').setup {
  ui = {
    icons = {
      package_installed = icons.server_installed,
      package_pending = icons.server_pending,
      package_uninstalled = icons.server_uninstalled,
    },
  },
}

require('mason-tool-installer').setup {
  ensure_installed = { },
  auto_update = false,
  run_on_start = true,
}

require('mason-lspconfig').setup {
--    ensure_installed = vim.tbl_keys(servers),
  automatic_installation = false,
}

-- Package installation folder
local install_root_dir = vim.fn.stdpath 'data' .. '/mason'

require('mason-lspconfig').setup_handlers {
  function(server_name)
    local opts = vim.tbl_deep_extend('force', options, servers[server_name] or {})
    lspconfig[server_name].setup { opts }
  end,
}
