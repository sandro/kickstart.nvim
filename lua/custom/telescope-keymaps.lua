-- Custom Telescope keymaps
-- This file contains custom telescope pickers and keymaps
-- Must be loaded after telescope is configured

local M = {}

function M.setup()
  local builtin = require 'telescope.builtin'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local previewers = require 'telescope.previewers'
  local utils = require 'telescope.utils'

  -- Grep in directory picker
  vim.keymap.set('n', '<leader>sG', function()
    local path = vim.fn.expand '%:.:h'
    local out = vim.system({ 'fd', '-H', '--type', 'd', '--color', 'never' }, { text = true }):wait()

    local results = {}
    for line in string.gmatch(out.stdout, '[^\r\n]+') do
      table.insert(results, line)
    end

    local colors = function(opts)
      opts = opts or {}
      pickers
        .new(opts, {
          prompt_title = 'Grep in dir',
          finder = finders.new_table {
            results = results,
          },
          sorter = conf.file_sorter(opts),
          default_text = path,
          attach_mappings = function(prompt_bufnr, map)
            map('i', '<c-space>', function(prompt_bufnr)
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              current_picker:reset_prompt ''
            end)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              -- print(vim.inspect(selection))
              local abs_path = vim.fn.fnamemodify(selection[1], ':p')
              builtin.live_grep {
                search_dirs = { abs_path },
                prompt_title = 'Live Grep in ' .. abs_path,
              }
            end)
            return true
          end,
        })
        :find()
    end

    colors()
  end, { desc = '[S]earch [G]rep directory' })

  -- Grep git diff
  vim.keymap.set('n', '<leader>dd', function()
    local opts = {
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }
    opts.cwd = opts.cwd and utils.path_expand(opts.cwd) or vim.loop.cwd()

    local live_grepper = finders.new_job(function(prompt)
      local term = prompt == '' and '.' or prompt
      local git_cmd = utils.__git_command { 'diff-index', '-U0', '--name-only', '-G', term, 'HEAD' }
      return git_cmd
    end, opts.entry_maker, opts.max_results, opts.cwd)

    pickers
      .new(opts, {
        prompt_title = 'grep git diff',
        finder = live_grepper,
        previewer = previewers.git_file_diff.new(opts),
      })
      :find()
  end, { desc = 'Grep git diff' })

  -- Git last commit
  vim.keymap.set('n', '<leader>dr', function()
    local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]

    local opts = {
      cwd = git_root,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
          path = git_root .. '/' .. entry,
        }
      end,
    }

    local live_grepper = finders.new_job(function(prompt)
      local term = prompt == '' and '.' or prompt
      local git_cmd = utils.__git_command { 'diff-tree', '--no-commit-id', '--name-only', '-r', 'HEAD', term }
      return git_cmd
    end, opts.entry_maker, opts.max_results, git_root)

    pickers
      .new(opts, {
        prompt_title = 'git last commit',
        finder = live_grepper,
        previewer = previewers.new_buffer_previewer {
          title = 'Git Diff',
          define_preview = function(self, entry)
            local cmd = { 'git', 'diff', 'HEAD~1', 'HEAD', '--', entry.value }
            vim.fn.jobstart(cmd, {
              cwd = git_root,
              stdout_buffered = true,
              on_stdout = function(_, data)
                if data then
                  vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, data)
                  vim.api.nvim_set_option_value('filetype', 'diff', { buf = self.state.bufnr })
                end
              end,
            })
          end,
        },
        sorter = conf.generic_sorter(opts),
      })
      :find()
  end, { desc = 'git last commit' })

  -- Diff against main
  vim.keymap.set('n', '<leader>do', function()
    local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]

    local opts = {
      cwd = git_root,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
          path = git_root .. '/' .. entry,
        }
      end,
    }

    local live_grepper = finders.new_job(function(prompt)
      local term = prompt == '' and '.' or prompt
      local git_cmd = utils.__git_command { 'diff', '--name-only', 'main...HEAD', '--', term }
      return git_cmd
    end, opts.entry_maker, opts.max_results, git_root)

    pickers
      .new(opts, {
        prompt_title = 'git diff main',
        finder = live_grepper,
        previewer = previewers.new_buffer_previewer {
          title = 'Git Diff',
          define_preview = function(self, entry)
            local cmd = { 'git', 'diff', 'main...HEAD', '--', entry.value }
            vim.fn.jobstart(cmd, {
              cwd = git_root,
              stdout_buffered = true,
              on_stdout = function(_, data)
                if data then
                  vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, data)
                  vim.api.nvim_set_option_value('filetype', 'diff', { buf = self.state.bufnr })
                end
              end,
            })
          end,
        },
        sorter = conf.generic_sorter(opts),
      })
      :find()
  end, { desc = 'diff against main' })
end

return M
