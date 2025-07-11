-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame = true,
      linehl = true,
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        -- map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        -- map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
        -- map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>htb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>htD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
        -- map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
        -- map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        -- map('v', '<leader>hr', function()
        --   gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        -- end, { desc = 'Reset hunk' })
        -- map('n', '<leader>hS', gitsigns.stage_buffer)
        -- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        -- map('n', '<leader>hR', gitsigns.reset_buffer)

        -- map('n', '<leader>hp', gitsigns.preview_hunk_inline, { desc = 'Preview inline hunk' })
        -- map('n', '<leader>htw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })
        -- map('n', '<leader>htd', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })
        -- -- map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
        -- map('n', '<leader>htb', gitsigns.toggle_current_line_blame, { desc = 'toggle blame' })
        -- map('n', '<leader>hd', gitsigns.diffthis, { desc = 'diff this' })
        -- map('n', '<leader>hD', function()
        --   gitsigns.diffthis '~'
        -- end, { desc = 'diff this ~' })

        -- map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
}
