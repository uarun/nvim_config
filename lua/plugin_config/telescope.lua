local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local builtin = require('telescope.builtin')

keymap('n', '<C-f>',      builtin.find_files, opts)
keymap('n', '<leader>ff', builtin.find_files, opts)
keymap('n', '<leader>fg', builtin.live_grep, opts)
keymap('n', '<leader>fb', builtin.buffers, opts)
keymap('n', '<leader>fh', builtin.help_tags, opts)

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
telescope.load_extension("fzf")
