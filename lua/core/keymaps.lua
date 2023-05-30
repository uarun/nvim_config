-- Keybinds
local keymap = vim.api.nvim_set_keymap
local opts   = { silent = true, noremap = true }

vim.g.mapleader      = ' '
vim.g.mapleaderlocal = ' '

keymap("n", '<C-n>', ':Telescope live_grep <CR>',  opts)
keymap("n", '<C-f>', ':Telescope find_files <CR>', opts)
