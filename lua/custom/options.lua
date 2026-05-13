-- Custom options and settings
-- This file contains all user-specific options that override or extend kickstart.nvim defaults

-- Grep settings
vim.o.grepprg = 'rg --vimgrep --glob !seed_data/'
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.tabstop = 4
vim.o.background = 'dark'

-- visual indent/dedent
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Use # to search forward
vim.keymap.set('n', '#', '*')

-- enable cfilter package
vim.cmd 'packadd cfilter'

-- Auto-save on focus lost
vim.api.nvim_create_autocmd('FocusLost', {
  callback = function(ev)
    vim.cmd.stopinsert()
    vim.cmd.wall { mods = { emsg_silent = true } }
  end,
})

-- Go: organize imports and format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format { async = false }
  end,
})

-- Clipboard mappings
-- yank selection to system clipboard
vim.keymap.set('v', 'Y', '"+y')
-- yank line to system clipboard without trailing newline
vim.keymap.set('n', 'Y', '^"+y$')
-- yank line to system clipboard
vim.keymap.set('n', 'YY', '"+yy')
-- paste from system clipboard
vim.keymap.set('n', '+', '"+p')

-- Rg command
vim.api.nvim_create_user_command('Rg', function(arg)
  vim.cmd { cmd = 'grep', args = arg.fargs, bang = arg.bang, mods = { silent = not arg.bang } }
  vim.cmd 'copen'
end, { bang = true, nargs = '*' })
