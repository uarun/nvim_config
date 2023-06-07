local opt = vim.opt

vim.g.loaded_perl_provider = 0  -- Turn off Perl plugins
vim.g.loaded_ruby_provider = 0  -- Turn off Ruby plugins

-- Indentation
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.scrolloff = 3

-- Set clipboard to use system clipboard
opt.clipboard = "unnamedplus"

-- Use Mouse
opt.mouse = "a"

-- UI Settings
opt.cursorline = true
opt.relativenumber = true
opt.number = true

-- Misc
opt.ignorecase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrap = false
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.errorbells = false

-- Folds
opt.foldmethod = "expr"
opt.foldexpr   = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- Splits
opt.splitright = true   -- Vertical split will place window to the right
opt.splitbelow = true   -- Horizontal split will place window to the right

-- Trailing Whitespaces Vacuum Cleaner
function vim.fn.stripTrailingWhitespace()
    local l = vim.fn.line(".")
    local c = vim.fn.col(".")
    vim.cmd("%s/\\s\\+$//e")
    vim.fn.cursor({l, c})
end

vim.cmd("autocmd BufWritePre * :lua vim.fn.stripTrailingWhitespace()")   -- strip all files by default
