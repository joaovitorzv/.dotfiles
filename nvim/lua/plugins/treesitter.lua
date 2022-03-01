require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  autotag = {
    enable = true,
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
    "graphql",
    "html",
    "markdown",
    "comment"
  },
}
