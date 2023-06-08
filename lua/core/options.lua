local options = {
  opt = {
    breakindent = true,        -- Wrap indent to match  line start
    clipboard = "unnamedplus", -- Connection to the system clipboard
    cmdheight = 0,             -- Hide command line unless needed
    completeopt = { "menu", "menuone", "noselect" },           -- Options for insert mode completion
    copyindent = true,         -- Copy the previous indentation on autoindenting
    cursorline = true,         -- Highlight the text line of the cursor
    errorbells = false,        -- Turn off error bells
    expandtab = true,          -- Enable the use of space in tab
    fileencoding = "utf-8",    -- File content encoding for the buffer
    fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
    foldcolumn = "1",          -- Show foldcolumn in nvim 0.9
    foldenable = true,         -- Enable fold for nvim-ufo
    foldexpr   = "nvim_treesitter#foldexpr()",                 -- Fold expression to use
    foldlevel = 99,            -- Set high foldlevel for nvim-ufo
    foldlevelstart = 99,       -- Start with all code unfolded
    foldmethod = "expr",       -- Fold method
    history = 100,             -- Number of commands to remember in a history table
    hlsearch = true,           -- Highlight search
    ignorecase = true,         -- Case insensitive searching
    incsearch = true,          -- Incremental search
    infercase = true,          -- Infer cases in keyword completion
    laststatus = 3,            -- Globalstatus
    linebreak = true,          -- Wrap lines at 'breakat'
    mouse = "a",               -- Enable mouse support
    number = true,             -- Show numberline
    preserveindent = true,     -- Preserve indent structure as much as possible
    pumheight = 10,            -- Height of the pop up menu
    relativenumber = true,     -- Show relative numberline
    scrolloff = 8,             -- Number of lines to keep above and below the cursor
    shiftwidth = 2,            -- Number of space inserted for indentation
    showmode = false,          -- Disable showing modes in command line
    showtabline = 2,           -- always display tabline
    sidescrolloff = 8,         -- Number of columns to keep at the sides of the cursor
    signcolumn = "yes",        -- Always show the sign column
    smartcase = true,          -- Case sensitivie searching
    smartindent = true,        -- Smarter autoindentation
    splitbelow = true,         -- Splitting a new window below the current one (horiz split)
    splitright = true,         -- Splitting a new window at the right of the current one (vert split)
    tabstop = 2,               -- Number of space in a tab
    termguicolors = true,      -- Enable 24-bit RGB color in the TUI
    timeoutlen = 500,          -- Shorten key timeout length a little bit for which-key
    undofile = true,           -- Enable persistent undo
    updatetime = 300,          -- Length of time to wait before triggering the plugin
    virtualedit = "block",     -- Allow going past end of line in visual block mode
    wrap = false,              -- Disable wrapping of lines longer than the width of window
    writebackup = false,       -- Disable making a backup before overwriting a file
  },
  g = {
    loaded_perl_provider = 0,  -- Turn off Perl plugins
    loaded_ruby_provider = 0,  -- Turn off Ruby plugins
    mapleader = " ",           -- Set leader key
    maplocalleader = ",",      -- Set default local leader key
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

-- Trailing Whitespaces Vacuum Cleaner
function vim.fn.stripTrailingWhitespace()
    local l = vim.fn.line(".")
    local c = vim.fn.col(".")
    vim.cmd("%s/\\s\\+$//e")
    vim.fn.cursor({l, c})
end

vim.cmd("autocmd BufWritePre * :lua vim.fn.stripTrailingWhitespace()")   -- strip all files by default
