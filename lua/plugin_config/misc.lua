require('trim').setup {
  ft_blocklist = { "markdown" },
  patterns = {
    [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
  },

  trim_on_write   = true,
  trim_trailing   = true,
  trim_last_line  = true,
  trim_first_line = false,
}
