local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
	return
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
  }
}
