require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  ensure_installed = {
    "bash",
    "hjson",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "python",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
}
