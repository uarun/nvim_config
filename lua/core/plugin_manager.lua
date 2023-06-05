local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

  -- Color Schemes
  "tanvirtin/monokai.nvim",
  "ellisonleao/gruvbox.nvim",

  -- File Explorer
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",

  -- Git
  "lewis6991/gitsigns.nvim",

  -- Syntax Highlighting
  "nvim-treesitter/nvim-treesitter",
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  -- LSP related plugins
  {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',

    'hrsh7th/nvim-cmp',                      -- Completion plugin
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',                     -- Snippets
    'hrsh7th/vim-vsnip',
  },

  "lukas-reineke/indent-blankline.nvim",     -- Indentation guidelines

}

local opts = {}

require("lazy").setup(plugins, opts)

