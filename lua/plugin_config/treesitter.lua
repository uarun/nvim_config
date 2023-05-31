local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
	return
end

treesitter.setup {
  ensure_installed = { "c", "haskell", "java", "lua", "scala", "sql", "perl", "python", "rust", "vim" },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
		additional_vim_regex_highlighting = false,
  },
}
