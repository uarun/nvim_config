local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local builtin = require('telescope.builtin')

keymap('n', '<leader>ff', builtin.find_files, opts)
keymap('n', '<leader>fg', builtin.live_grep, opts)
keymap('n', '<leader>fb', builtin.buffers, opts)
keymap('n', '<leader>fh', builtin.help_tags, opts)

telescope.setup({})
telescope.load_extension("fzf")
