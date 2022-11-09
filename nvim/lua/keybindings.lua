-- === Keybindings ===
-- This file contains all new keybindings

-- This function defines a somewhat more readable scheme to set keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-q>', ':NvimTreeToggle<CR>')
