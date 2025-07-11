-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-speeddating' },
  -- { 'tpope/vim-surround' },
  { 'tpope/vim-sensible' },
  -- { 'tpope/vim-sleuth' },
  -- { 'tpope/vim-endwise' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-rsi' },
  { 'sindrets/diffview.nvim' },
  { 'rebelot/kanagawa.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
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
  --   'nvim-telescope/telescope-frecency.nvim',
  --   config = function()
  --     require('telescope').load_extension 'frecency'
  --   end,
  -- },
  {
    'kwkarlwang/bufjump.nvim',
    config = function()
      vim.opt.jumpoptions = 'stack'
      require('bufjump').setup {
        forward_key = ']b',
        backward_key = '[b',
      }
    end,
  },
  -- {
  --   'yetone/avante.nvim',
  --   event = 'VeryLazy',
  --   version = false, -- Never set this value to "*"! Never!
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --     -- provider = 'openai',
  --     -- openai = {
  --     --   endpoint = 'https://api.openai.com/v1',
  --     --   model = 'gpt-4o', -- your desired model (or use gpt-4o, etc.)
  --     --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
  --     --   temperature = 0,
  --     --   max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
  --     --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
  --     -- },
  --     provider = 'ollama',
  --     ollama = {
  --       model = 'qwq:32b',
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = 'make',
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'stevearc/dressing.nvim',
  --     'nvim-lua/plenary.nvim',
  --     'MunifTanjim/nui.nvim',
  --     --- The below dependencies are optional,
  --     'echasnovski/mini.pick', -- for file_selector provider mini.pick
  --     'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
  --     'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
  --     'ibhagwan/fzf-lua', -- for file_selector provider fzf
  --     'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
  --     'zbirenbaum/copilot.lua', -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       'HakonHarnes/img-clip.nvim',
  --       event = 'VeryLazy',
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { 'markdown', 'Avante' },
  --       },
  --       ft = { 'markdown', 'Avante' },
  --     },
  --   },
  -- },
  -- {
  --   'hat0uma/csvview.nvim',
  --   ---@module "csvview"
  --   ---@type CsvView.Options
  --   opts = {
  --     parser = { comments = { '#', '//' } },
  --     keymaps = {
  --       -- Text objects for selecting fields
  --       textobject_field_inner = { 'if', mode = { 'o', 'x' } },
  --       textobject_field_outer = { 'af', mode = { 'o', 'x' } },
  --       -- Excel-like navigation:
  --       -- Use <Tab> and <S-Tab> to move horizontally between fields.
  --       -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
  --       -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
  --       jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
  --       jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
  --       jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
  --       jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
  --     },
  --   },
  --   cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
  -- },
  -- {
  --   'David-Kunz/gen.nvim',
  --   opts = {
  --     model = 'mistral', -- The default model to use.
  --     quit_map = 'q', -- set keymap to close the response window
  --     retry_map = '<c-r>', -- set keymap to re-send the current prompt
  --     accept_map = '<c-cr>', -- set keymap to replace the previous selection with the last result
  --     host = 'localhost', -- The host running the Ollama service.
  --     port = '11434', -- The port on which the Ollama service is listening.
  --     display_mode = 'float', -- The display mode. Can be "float" or "split" or "horizontal-split".
  --     show_prompt = false, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
  --     show_model = false, -- Displays which model you are using at the beginning of your chat session.
  --     no_auto_close = false, -- Never closes the window automatically.
  --     file = false, -- Write the payload to a temporary file to keep the command short.
  --     hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
  --     init = function(options)
  --       pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
  --     end,
  --     -- Function to initialize Ollama
  --     command = function(options)
  --       local body = { model = options.model, stream = true }
  --       return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
  --     end,
  --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  --     -- This can also be a command string.
  --     -- The executed command must return a JSON object with { response, context }
  --     -- (context property is optional).
  --     -- list_models = '<omitted lua function>', -- Retrieves a list of model names
  --     result_filetype = 'markdown', -- Configure filetype of the result buffer
  --     debug = false, -- Prints errors and the command which is run.
  --   },
  -- },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   config = function()
  --     require('codecompanion').setup {
  --       strategies = {
  --         chat = {
  --           adapter = 'ollama',
  --         },
  --         inline = {
  --           adapter = 'ollama',
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   dir = 'lua',
  --   name = 'mybufjump',
  --   config = function()
  --     require 'mybufjump'
  --   end,
  -- },
  -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- {
  --   'ray-x/starry.nvim',
  --   config = function()
  --     require('starry').setup()
  --     -- require('starry.functions').change_style 'palenight'
  --   end,
  -- },
  -- {
  --   'luckasRanarison/nvim-devdocs',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   opts = {},
  -- },
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
