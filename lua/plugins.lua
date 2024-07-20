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
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      { 'BurntSushi/ripgrep' },
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "debugloop/telescope-undo.nvim" },
      { "jvgrootveld/telescope-zoxide" },
      { "nvim-telescope/telescope-frecency.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
    },
    config = function()
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local z_utils = require("telescope._extensions.zoxide.utils")

      vim.keymap.set('n', '<leader><leader>f', builtin.find_files, {})
      vim.keymap.set('n', '<leader><leader>g', builtin.live_grep, {})
      vim.keymap.set('n', '<leader><leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<leader><leader>h', builtin.help_tags, {})

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
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
          zoxide = {
            mappings = {
              default = {
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
                after_action = function(selection)
                  print("Directory changed to " .. selection.path)
                end
              },
              ["<C-s>"] = { action = z_utils.create_basic_command("split") },
              ["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
              ["<C-e>"] = { action = z_utils.create_basic_command("edit") },
              ["<C-b>"] = {
                keepinsert = true,
                action = function(selection)
                  builtin.file_browser({ cwd = selection.path })
                end
              },
              ["<C-f>"] = {
                keepinsert = true,
                action = function(selection)
                  builtin.find_files({ cwd = selection.path })
                end
              },
              ["<C-t>"] = {
                action = function(selection)
                  vim.cmd.tcd(selection.path)
                end
              }
            }
          }
        }
      }

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('zoxide')
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
    },
    config = function()
      require('neo-tree').setup({
        window = {
          position = "left",
          width = 30,
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
        }
      })
    end
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
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
    lazy = false
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
    "rcarriga/nvim-dap-ui",
    dependencies = { { 'mfussenegger/nvim-dap' } },
  },
  -- {
  --   "vim-airline/vim-airline",
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = {
  --     { "vim-airline/vim-airline-themes" },
  --     { "ryanoasis/vim-devicons" },
  --   }
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
})
