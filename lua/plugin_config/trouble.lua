local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then
	return
end

trouble.setup {
    position = "bottom",
    padding = true,
    auto_preview = false,
}

local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>xx", "<CMD>TroubleToggle<CR>", opts)
vim.keymap.set("n", "<leader>xw", "<CMD>TroubleToggle workspace_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>xd", "<CMD>TroubleToggle document_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>xl", "<CMD>TroubleToggle loclist<CR>", opts)
vim.keymap.set("n", "<leader>xq", "<CMD>TroubleToggle quickfix<CR>", opts)
vim.keymap.set("n", "gR", "<CMD>TroubleToggle lsp_references<CR>", opts)
