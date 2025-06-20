local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "bottom",
              preview_width = 0.55,
            },
            vertical = {
              prompt_position = "bottom",
              preview_height = 0.55,
            },
          },
          file_ignore_patterns = { "node_modules" },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
          },
        },
        extensions = {
          { 'nvim-telescope/telescope-ui-select.nvim' },
          { 'nvim-tree/nvim-web-devicons' },
        },
      }

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[F]ind [G]rep" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[F]ind [B]uffers" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function() require("nvim-treesitter.configs").setup {
      ensure_installed = { "bash", "css", "html", "javascript", "lua", "regex", "python" }
    } end },
  { "tpope/vim-fugitive" },
  { "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true
        }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require 'lspconfig'
      require 'mason'
      require 'mason-lspconfig'

      require('mason').setup()
      require('mason-lspconfig').setup({
        -- installing nothing for mobile use case
        -- ensure_installed = { "lua_ls", "pyright" },
      })

      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' },
                },
              },
            },
          }
        end,
      }
    end
  },
})
