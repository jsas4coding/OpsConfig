# Unreleased

Changes that are merged but not yet released.

## Added

- ARM architecture (aarch64) support for Neovim and fnm downloads
- Version constants (`OPSCONFIG_VERSION`) to all scripts
- `--version` flag to install and update scripts
- `--help` flag to install script
- Shared library (`bin/lib/common.sh`) for colors, icons, and msg function
- Trap handlers for cleanup on exit in all scripts
- Download integrity checks (SHA256 verification for Neovim)
- Input validation for config values (package names, font names, FPM values)
- `IFS=$'\n\t'` to install and update scripts
- `apt-get update -y` before `apt install` in install script
- Augroup with `clear = true` for wezterm behavior autocommands
- Treesitter-based folding (`foldexpr`)
- `yamlls` LSP server setup
- `column_width = 120` to stylua.toml

## Changed

- Moved all scripts from root to `bin/` directory
- Removed stale `docs/` directory
- Updated all script references across README, SECURITY, bash config, and docs
- Config file permissions changed from 644 to 600
- `vim.loop.fs_stat()` replaced with `vim.uv.fs_stat()`
- `vim.api.nvim_win_set_option()` replaced with `vim.wo[]`
- `vim.lsp.get_active_clients()` replaced with `vim.lsp.get_clients()`
- Noice treesitter highlights updated to `@markup.link`/`@markup.heading`
- Mason no longer depends on nvim-lspconfig (removed circular dependency)
- `foldmethod` changed from `marker` to `expr` with treesitter
- Removed `timeoutlen = 1000` from options (which-key sets 500)
- `nerd_font_variant` in blink-cmp now conditional on `vim.g.have_nerd_font`
- `reload_bash()` in update script replaced with user message
- `stow` commands use explicit `--dir`/`--target` flags
- `.bash_env`/`.bash_env_local` sourcing moved after interactive check in .bashrc
- Hook file contents shown to user before sourcing in update script
- EditorConfig header fixed from "Go projects" to "OpsConfig"
- Portuguese comment in auto-save.lua translated to English
- Tabs converted to 2 spaces in ftdetect/global.lua

## Fixed

- Removed 5 non-existent plugin entries from init.lua (telescope-\*, nvim-cmp)
- Removed SessionRestore button from alpha dashboard (no session plugin)
- Removed 6 Trouble keymaps (plugin not installed)
- Added missing `return` to conform.nvim `format_on_save` callback
- Fixed `remote-copy()` SSH detection operator precedence bug
- Removed duplicate `shopt` calls in .bash_custom (already in .bashrc)
- Removed duplicate history/alias settings in .bashrc
- Removed duplicate `escape-time` and `focus-events` in .tmux.conf
- Fixed inverted comment for `silent = false` in nvim-osc52
- Wrapped `require('which-key')` in pcall in fzf-lua
- Wrapped `require('noice')` in pcall in lualine

## Security

- Safe key-value parser for config file sourcing (replaces raw `source`)
- Input sanitization for wizard functions (strips dangerous characters)
- Hardcoded `NVM_DIR` path (ignores environment override)
- Secure curl flags (`-f --proto '=https' --tlsv1.2`) for all downloads
- Temporary directory (`mktemp -d`) for downloads instead of CWD
- Package name validation against `^[a-zA-Z0-9_.-]+$`
- Font name validation against `^[a-zA-Z0-9_-]+$`
- FPM value validation with strict regexes in install-php

## Removed

- `docs/` directory (stale reports)
- `@redocly/cli` dependency from package.json
- `detect_distro` documentation from README (Ubuntu/Debian only)
