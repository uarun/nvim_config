local o = vim.opt
local g = vim.g

g.loaded_perl_provider = 0  -- Turn off Perl plugins
g.loaded_ruby_provider = 0  -- Turn off Ruby plugins

-- Indentation
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.scrolloff = 3

-- Set clipboard to use system clipboard
o.clipboard = "unnamedplus"

-- Use Mouse
o.mouse = "a"

-- UI Settings
o.cursorline = true
o.relativenumber = true
o.number = true

-- Misc
o.ignorecase = true
o.incsearch = true
o.hlsearch = true
o.wrap = false
o.backup = false
o.writebackup = false
o.swapfile = false
o.errorbells = false


-- Trailing Whitespaces Vacuum Cleaner
function vim.fn.stripTrailingWhitespace()
    local l = vim.fn.line(".")
    local c = vim.fn.col(".")
    vim.cmd("%s/\\s\\+$//e")
    vim.fn.cursor(l, c)
end

vim.cmd("autocmd BufWritePre * :lua vim.fn.stripTrailingWhitespace()")   -- strip all files by default
