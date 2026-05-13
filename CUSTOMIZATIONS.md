# Kickstart.nvim Customizations (vim.pack edition)

This document tracks customizations to the fresh kickstart.nvim using native `vim.pack` plugin management.

**Migration date**: 2026-05-13
**Upstream commit**: cfdc17b (Merge pull request #1982)

## Strategy

Kickstart.nvim uses Neovim's built-in `vim.pack` for plugin management (no lazy.nvim). Customizations are kept modular in `lua/custom/`.

1. **Keep customizations in `lua/custom/` directory**
2. **Minimal changes to core `init.lua`**
3. **Track what's modified** - this document serves as the reference

## Custom Modules

### `lua/custom/options.lua`
User-specific options and settings:
- Custom grep settings (ripgrep with exclusions)
- Tab and background settings
- Visual mode indent/dedent mappings
- Clipboard integration (Y, YY, + mappings)
- Auto-save on focus lost
- Go LSP formatting on save
- Rg command for quickfix integration

**Integration**: Add inside the SECTION 1 `do...end` block, right after `vim.o.confirm = true`:
```lua
  -- Load custom options
  require('custom.options')
```

### `lua/custom/telescope-keymaps.lua`
Custom Telescope pickers and keymaps:
- `<leader>sG` - Grep in directory (select dir, then live_grep in it)
- `<leader>dd` - Grep git diff (search in files changed vs HEAD)
- `<leader>dr` - Git last commit (browse/search files in last commit)
- `<leader>do` - Diff against main (files changed vs main branch)

**Integration**: Add after the Telescope `vim.pack.add` and setup calls:
```lua
  -- Load custom telescope keymaps
  require('custom.telescope-keymaps').setup()
```

### `lua/custom/plugins.lua`
Custom plugins converted to vim.pack format:
- tpope plugins (speeddating, sensible, unimpaired, rsi)
- Colorschemes (kanagawa, nightfox, catppuccin)
- oil.nvim - file explorer (mapped to `-`)
- yanky.nvim - enhanced yank/paste ring
- bufjump.nvim - better buffer jump list
- codecompanion.nvim - AI assistant with Ollama

**Integration**: Already loaded at the end of init.lua:
```lua
require('custom.plugins').setup()
```

**Old lazy.nvim file**: Backed up to `lua/custom/plugins/init.lua.lazy-backup`

## Core File Modifications

### `init.lua` (Section 1 - Foundation)

**Lines to modify**:

1. **Line ~92-93**: Change leader key from space to backslash
   ```lua
   vim.g.mapleader = '\\'
   vim.g.maplocalleader = '\\'
   ```

2. **Line ~96**: Enable Nerd Font
   ```lua
   vim.g.have_nerd_font = true
   ```

3. **After `vim.o.confirm = true` (~167)**: Load custom options
   ```lua
   -- Load custom options
   require('custom.options')
   ```

### `init.lua` (Section 2 - Telescope)

**After Telescope setup (~line 300-350)**:
```lua
  -- Load custom telescope keymaps
  require('custom.telescope-keymaps').setup()
```

Look for after these lines:
```lua
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')
```

### Gitsigns Configuration

The new kickstart doesn't use `lua/kickstart/plugins/gitsigns.lua` - it's inline in `init.lua`.

**To add toggle_deleted support**:

Find the gitsigns keymaps section (search for `'lewis6991/gitsigns.nvim'`), and add:
```lua
map('n', '<leader>htD', gs.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
```

## File Structure

```
~/.config/nvim/
├── init.lua                              # Main config (vim.pack, with custom requires)
├── lua/
│   ├── custom/                           # ✅ Your customizations
│   │   ├── options.lua                   # Custom options and keymaps
│   │   ├── telescope-keymaps.lua         # Custom telescope pickers
│   │   ├── plugins.lua                   # Custom plugins (vim.pack format)
│   │   └── plugins/
│   │       └── init.lua.lazy-backup      # Old lazy.nvim file (backup)
│   └── kickstart/
│       └── plugins/
│           └── gitsigns.lua              # Modified with toggle_deleted
├── CUSTOMIZATIONS.md                     # This file
└── .git/
```

## Updating from Upstream

```bash
cd ~/.config/nvim

# Check what changed upstream
git fetch src
git log HEAD..src/master --oneline

# Option 1: Merge (keeps history)
git merge src/master

# Option 2: Reset and reapply (clean)
git reset --hard src/master
# Then manually reapply customizations listed above

# Restore from backup if needed
git checkout backup-before-vim-pack-migration
```

## Backup Branch

Before this migration, created backup branch: `backup-before-vim-pack-migration`

To view old config:
```bash
git checkout backup-before-vim-pack-migration
```

To return to new config:
```bash
git checkout master
```

## Notes

- **vim.pack** is Neovim's built-in plugin manager (Neovim 0.10+)
- Plugins are installed to `~/.local/share/nvim/site/pack/*/start/`
- No lock file (removed lazy-lock.json)
- Faster startup with `vim.loader.enable()`
- The new structure uses `do...end` blocks for sections
