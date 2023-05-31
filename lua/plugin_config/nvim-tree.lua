local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

nvim_tree.setup()

vim.keymap.set('n', '<c-.>', ':NvimTreeFindFileToggle<CR>')
