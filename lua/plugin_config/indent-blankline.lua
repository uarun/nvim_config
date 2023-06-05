vim.opt.termguicolors = true
vim.g.indentLine_enabled = 1

vim.g.indent_blankline_context_patterns = {
  "class", "return", "function", "method", "^if", "^while", "jsx_element",
  "^for", "^object", "^table", "block", "arguments", "if_statement",
  "else_clause", "jsx_element", "jsx_self_closing_element",
  "try_statement", "catch_clause", "import_statement", "operation_type"
}

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

require('indent_blankline').setup {
  char = "┊",
  char_highlight = 'LineNr',
  show_current_context = true,
  show_current_context_start = false,          -- Uses underlines, so it doesn't look good unless underlines can be tweaked in the terminal
  use_treesitter = true,
  buftype_exclude = { 'terminal', 'nofile' },
  filetype_exclude = { 'help', 'markdown' },
  show_trailing_blackline_indent = false,
}
