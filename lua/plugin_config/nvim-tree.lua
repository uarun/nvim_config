local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.keymap.set('n', '<C-.>', ':NvimTreeToggle<CR>')

local function nvim_tree_on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr, noremap = true, silent = true, nowait = true
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'h', api.tree.toggle_help, opts('Help'))
end

nvim_tree.setup {
  on_attach = nvim_tree_on_attach,

  sort_by = "case_sensitive",
  view = {
    width = 30,
    mappings = {
      custom_only = false,
    }
  },
  filters = {
    dotfiles = true,
  }
}
