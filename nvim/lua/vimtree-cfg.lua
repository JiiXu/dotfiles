-- === Configuration for vimtree ===

require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  sync_root_with_cwd = true,
  view = {
    side = 'right',
    adaptive_size = true,
    mappings = {
      list = {
        { key = 'u', action = 'dir_up' },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

