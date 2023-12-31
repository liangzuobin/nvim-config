vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use({
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })
  use 'wbthomason/packer.nvim'
  -- LSP 相关的
  -- 准备用 coc 来替换掉一堆其它插件
  use { 'neoclide/coc.nvim', branch = 'release' }
  -- use {
  --   "williamboman/mason.nvim",
  --   "williamboman/mason-lspconfig.nvim",
  --   "neovim/nvim-lspconfig",
  -- }
  -- use 'L3MON4D3/LuaSnip'
  -- use 'saadparwaiz1/cmp_luasnip'
  -- use 'jose-elias-alvarez/null-ls.nvim'
  -- use 'hrsh7th/cmp-nvim-lsp'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-path'
  -- use 'hrsh7th/cmp-cmdline'
  -- use 'hrsh7th/nvim-cmp'
  -- use 'onsails/lspkind-nvim'
  -- use({
  --   "glepnir/lspsaga.nvim",
  --   branch = "main"
  -- })

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  }
  use 'sainnhe/everforest' -- color theme

  use 'rmagatti/alternate-toggler'
  use 'windwp/nvim-autopairs'
  use 'mg979/vim-visual-multi'
  use 'gcmt/wildfire.vim'
  use 'tpope/vim-surround'


  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'MattesGroeger/vim-bookmarks'
  use 'tom-anders/telescope-vim-bookmarks.nvim'


  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use({
    'akinsho/toggleterm.nvim',
    tag = '*'
  })
  -- use 'tpope/vim-obsession'
  -- use 'dhruvasagar/vim-prosession'
  use('f-person/git-blame.nvim')
  -- use('github/copilot.vim')
  --
  use {
    'dnlhc/glance.nvim',
    config = function()
      require('glance').setup {}
    end
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require 'hop'.setup {}
    end
  }
end)
