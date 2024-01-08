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

require("lazy").setup({
  {
    "sainnhe/everforest",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.cmd('colorscheme everforest')
      vim.fn.sign_define({
        {
          name = 'DiagnosticSignError',
          text = '',
          texthl = 'DiagnosticSignError',
          linehl = 'ErrorLine',
        },
        {
          name = 'DiagnosticSignWarn',
          text = '',
          texthl = 'DiagnosticSignWarn',
          linehl = 'WarningLine',
        },
        {
          name = 'DiagnosticSignInfo',
          text = '',
          texthl = 'DiagnosticSignInfo',
          linehl = 'InfoLine',
        },
        {
          name = 'DiagnosticSignHint',
          text = '',
          texthl = 'DiagnosticSignHint',
          linehl = 'HintLine',
        },
      })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>f', builtin.find_files, {})
      vim.keymap.set('n', '<leader><leader>g', builtin.live_grep, {})

      local actions = require('telescope.actions')
      require('nvim-web-devicons').setup({
        override = {},
        default = true
      })
      require('telescope').setup {
        defaults = {
          path_display = { 'smart' },
          mappings = {
            i = {
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<esc>"] = actions.close
            }
          }
        },
        layout_config = {
          horizontal = {
            preview_cutoff = 100,
            preview_width = 0.6
          }
        }
      }
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    branch = "v3.x",
    keys = {
      { "<c-e>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = true,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    config = function()
      require 'todo-comments'.setup()
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      map_bs = false,
      map_cr = false
    }
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    lazy = true,
    keys = {
      { "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm" },
    },
    config = function()
      require('toggleterm').setup({
        direction = 'float',
        open_mapping = [[<c-\>]]
      })
    end
  },
  {
    "f-person/git-blame.nvim",
    lazy = true
  },
  {
    "phaazon/hop.nvim",
    lazy = true,
    keys = {
      -- { "<leader><leader>s", "<cmd>HopPattern<CR>",                    mode = { "n" } },
      { "<leader><leader>s", "<cmd>lua require'hop'.hint_char1()<cr>", mode = { "n" } },
      {
        "f",
        function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
        end,
        mode = { "n" }
      },
      {
        "F",
        function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
        end,
        mode = { "n" }
      },
      {
        "t",
        function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
        end,
        mode = { "n" }
      },
      {
        "T",
        function()
          local hop = require('hop')
          local directions = require('hop.hint').HintDirection
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
        end,
        mode = { "n" }
      },
    },
    config = function()
      require 'hop'.setup { term_seq_bias = 0.5 }
    end
  },
  {
    import = "coc"
  },
  {
    "vim-airline/vim-airline",
    lazy = false,
    priority = 1000,
    dependencies = {
      { "vim-airline/vim-airline-themes" },
      { "ryanoasis/vim-devicons" },
    }
  }
})
