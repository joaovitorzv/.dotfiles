vim.notify('very kekw fodasee lol lol')
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins/init.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup(function()
  use('wbthomason/packer.nvim') -- Package manager

  local config = function(config)
    return string.format("require('plugins.%s')", config)
  end

  local use_with_config = function(path, name)
    use({path, config = config(name)})
  end

  use({'tpope/vim-fugitive'}) -- Git commands in nvim
  use({'tpope/vim-rhubarb'}) -- Fugitive-companion to interact with github
  use({'tpope/vim-commentary'}) -- "gc" to comment visual regions/lines
  use({'tpope/vim-vinegar'})
  -- UI to select things (files, grep results, open buffers...)
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = config('telescope')
  })
  use({'morhetz/gruvbox'})
  use({'projekt0n/github-nvim-theme',
    config = config('theme')
  })
  -- use({
  --   'nvim-lualine/lualine.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons', opt = true},
  --   config = config('lualine'),
  -- })
  use({ 'vim-airline/vim-airline' })
  -- Add indentation guides even on blank lines
  use_with_config("lukas-reineke/indent-blankline.nvim", "blankline")
  -- Add git related info in the signs columns and popups
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = config('gitsigns')
  })
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config('treesitter'),
  })
  use({'jiangmiao/auto-pairs'})
  -- Additional textobjects for treesitter
  use({'nvim-treesitter/nvim-treesitter-textobjects'})
  use({'neovim/nvim-lspconfig'}) -- Collection of configurations for built-in LSP client
  use_with_config("hrsh7th/nvim-cmp", "cmp") -- Autocompletion plugin
  use("hrsh7th/cmp-nvim-lsp")
  use({'saadparwaiz1/cmp_luasnip'})
  use({'L3MON4D3/LuaSnip'}) -- Snippets plugin
  -- Surround
  use({'tpope/vim-surround'})
	-- Formatting
	use({ 'prettier/vim-prettier', run = 'yarn install' })
	use({ "jose-elias-alvarez/null-ls.nvim",
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  })
  use({'jose-elias-alvarez/nvim-lsp-ts-utils'})

  use({'ap/vim-css-color'}) -- Css color highlight
  use({'editorconfig/editorconfig-vim'}) -- Editor config support
  use({'arjunmahishi/run-code.nvim'}) -- Run codeblock

  use({'kyazdani42/nvim-web-devicons'}) -- ?? Icons ??
  use({'windwp/nvim-ts-autotag'}) -- Close tags

  use({'andweeb/presence.nvim'}) -- Discord rich presence

  use({ 'rafamadriz/friendly-snippets' }) -- Yes snippets but friendly

  -- use({'github/copilot.vim'}) -- Copilot
  use({'kassio/neoterm'}) -- Terminal integrated

  use({'nvim-neo-tree/neo-tree.nvim',
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    },
    config = config('neotree')
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
