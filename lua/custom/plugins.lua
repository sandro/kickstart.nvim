-- Custom plugins using vim.pack
-- This file contains all custom plugins converted from lazy.nvim to vim.pack format

local M = {}

function M.setup()
  -- Simple plugins (no configuration needed)
  vim.pack.add { gh 'tpope/vim-speeddating' }
  vim.pack.add { gh 'tpope/vim-sensible' }
  vim.pack.add { gh 'tpope/vim-unimpaired' }
  vim.pack.add { gh 'tpope/vim-rsi' }
  vim.pack.add { gh 'sindrets/diffview.nvim' }

  -- Colorschemes
  vim.pack.add { gh 'rebelot/kanagawa.nvim' }
  vim.pack.add { gh 'EdenEast/nightfox.nvim' }
  vim.pack.add { gh 'catppuccin/nvim' }

  -- Oil.nvim - file explorer
  if vim.g.have_nerd_font then
    vim.pack.add { gh 'echasnovski/mini.icons' }
    require('mini.icons').setup {}
  end
  vim.pack.add { gh 'stevearc/oil.nvim' }
  require('oil').setup {
    view_options = {
      show_hidden = true,
    },
  }
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

  -- Yanky.nvim - better yank/paste
  vim.pack.add { gh 'gbprod/yanky.nvim' }
  require('yanky').setup {}
  -- Set up keymaps
  vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
  vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
  vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
  vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
  vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
  vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')

  -- Bufjump.nvim - better buffer jump list
  vim.pack.add { gh 'kwkarlwang/bufjump.nvim' }
  vim.opt.jumpoptions = 'stack'
  require('bufjump').setup {
    forward_key = ']b',
    backward_key = '[b',
  }

  -- CodeCompanion.nvim - AI assistant
  vim.pack.add {
    gh 'nvim-lua/plenary.nvim',
    gh 'olimorris/codecompanion.nvim',
  }
  require('codecompanion').setup {
    strategies = {
      chat = {
        adapter = 'ollama',
      },
      inline = {
        adapter = 'ollama',
      },
    },
  }
end

return M
