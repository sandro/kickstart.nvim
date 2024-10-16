-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-speeddating' },
  -- { 'tpope/vim-surround' },
  { 'tpope/vim-sensible' },
  { 'tpope/vim-sleuth' },
  -- { 'tpope/vim-endwise' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-rsi' },
  { 'sindrets/diffview.nvim' },
  -- { 'tpope/vim-fugitive' },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      require('oil').setup {
        view_options = {
          show_hidden = true,
        },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
  -- {
  --   'ray-x/starry.nvim',
  --   config = function()
  --     require('starry').setup()
  --     -- require('starry.functions').change_style 'palenight'
  --   end,
  -- },
  {
    'luckasRanarison/nvim-devdocs',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
  {
    'gbprod/yanky.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    init = function()
      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

      vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')
    end,
  },
  -- {
  --   'mangelozzi/nvim-rgflow.lua',
  --   config = function()
  --     require('rgflow').setup {
  --       -- Set the default rip grep flags and options for when running a search via
  --       -- RgFlow. Once changed via the UI, the previous search flags are used for
  --       -- each subsequent search (until Neovim restarts).
  --       cmd_flags = '--smart-case --fixed-strings --ignore --max-columns 200',
  --
  --       -- Mappings to trigger RgFlow functions
  --       default_trigger_mappings = true,
  --       -- These mappings are only active when the RgFlow UI (panel) is open
  --       default_ui_mappings = true,
  --       -- QuickFix window only mapping
  --       default_quickfix_mappings = true,
  --
  --       batch_size = 5000,
  --     }
  --   end,
  -- },
}
