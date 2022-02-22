require("indent_blankline").setup {
  filetype_exclude = { 'help', 'packer' },
  buftype_exclude = { 'terminal', 'nofile' },
  char_highlight = 'LineNr',
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}
