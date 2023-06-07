local fterm_ok, fterm = pcall(require, "FTerm")
if not fterm_ok then
	return
end

fterm.setup({
  border = 'single',
  cmd = os.getenv('SHELL'),
  blend = 0,
  dimensions = {
    height = 0.8,
    width  = 0.8,
  }
})

vim.keymap.set('n', 't', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
