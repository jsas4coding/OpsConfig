# OpsConfig

**OpsConfig** is a curated and modular dotfiles collection built for operational excellence, focusing on maintainability, extensibility, and productivity — especially for developers, sysadmins, and power users who rely heavily on terminal and Neovim workflows.

> **Warning**: This repository does not accept contributions. It is tailored for personal use and internal deployment.
>
> **Disclaimer**: This configuration is designed for personal use. It **overwrites existing configurations** during installation.

---

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [System Requirements](#system-requirements)
- [Directory Structure](#directory-structure)
- [Neovim Configuration](#neovim-configuration)
  - [Plugins](#neovim-plugins)
  - [Keybindings](#neovim-keybindings)
  - [Color Scheme](#color-scheme)
- [Bash Configuration](#bash-configuration)
  - [Aliases](#bash-aliases)
  - [Functions](#bash-functions)
  - [Shell Options](#shell-options)
- [TMUX Configuration](#tmux-configuration)
- [Clipboard Integration](#clipboard-integration)
- [SSH Remote Management](#ssh-remote-management)
- [Update System](#update-system)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Security](#security)
- [License](#license)

---

## Features

### Neovim
- **Fast Completion**: blink.cmp with 0.5-4ms response time
- **Fuzzy Finding**: fzf-lua for fast file and content search
- **LSP Integration**: Mason-managed language servers (Bash, JSON, YAML, Lua)
- **Modern Theme**: Catppuccin Frappe with transparent background
- **ASCII-Compatible Icons**: Works on any terminal without NerdFonts
- **Auto-Save**: Intelligent debounced saving with visual feedback
- **Treesitter**: Syntax highlighting for 40+ languages

### Bash
- **Enhanced History**: 10,000 commands with timestamps and deduplication
- **Smart Navigation**: Auto-cd, directory spell correction, globstar
- **SSH-Aware Clipboard**: OSC52 passthrough for remote copy operations
- **Dynamic Prompt**: Git status, virtualenv, server name indicators
- **System Update**: Single command (`u`) updates everything

### TMUX
- **Vi Mode**: Vim-style keybindings for copy mode
- **OSC52 Passthrough**: Clipboard works through SSH tunnels
- **True Color**: Full 256-color and true color support
- **Optimized Settings**: Zero escape-time for fast SSH response

---

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/jsas4coding/ops-config/main/install | bash
```

### What Gets Installed

| Component | Location | Description |
|-----------|----------|-------------|
| Neovim | `/opt/nvim` | Latest stable release |
| Neovim Wrapper | `/var/scripts/neovim` | Python environment activation |
| Python venv | `~/.config/opsconfig/lib/python` | pynvim and utilities |
| Node.js | `~/.nvm` | NVM with Node v22 |
| Fonts | `~/.local/share/fonts` | JetBrains Mono, Fira Code |
| Bash configs | `~/.bashrc`, etc. | Via GNU Stow |
| Neovim configs | `~/.config/nvim` | Via GNU Stow |

### Installation Options

```bash
# Standard installation
curl -fsSL https://raw.githubusercontent.com/jsas4coding/ops-config/main/install | bash

# Force Python environment rebuild
curl -fsSL https://raw.githubusercontent.com/jsas4coding/ops-config/main/install | bash -s -- --force
```

---

## System Requirements

### Minimum Requirements
- **OS**: Ubuntu 20.04+, Debian 11+, Fedora 36+, Alpine 3.16+
- **RAM**: 512MB (1GB recommended)
- **Disk**: 500MB free space
- **Terminal**: Any terminal with UTF-8 support

### Recommended
- **Terminal**: WezTerm, Gnome Terminal, or any OSC52-compatible terminal
- **TMUX**: 3.2+ for full clipboard passthrough support
- **Font**: Any monospace font (NerdFonts optional)

### Dependencies (Auto-Installed)
```
git curl jq stow ripgrep perl ruby-full build-essential clang python3-venv
```

---

## Directory Structure

```
opsconfig/
├── bash/                          # Bash configuration
│   ├── .bashrc                    # Main shell initialization
│   ├── .bash_custom               # Aliases, functions, enhanced options
│   ├── .bash_ps1                  # Dynamic prompt with git status
│   ├── .bash_env                  # Global environment variables
│   ├── .bash_env_local            # Server-specific overrides (template)
│   ├── .bash_logout               # Cleanup on exit
│   └── .tmux.conf                 # TMUX configuration
├── nvim/                          # Neovim configuration
│   └── .config/nvim/
│       ├── init.lua               # Entry point
│       ├── lua/opsconfig/
│       │   ├── core/              # Core settings
│       │   │   ├── options.lua    # Editor options
│       │   │   ├── keymaps.lua    # Key bindings
│       │   │   └── plugins.lua    # Plugin loader
│       │   ├── plugins/           # Plugin configurations
│       │   │   ├── blink-cmp.lua  # Completion engine
│       │   │   ├── fzf-lua.lua    # Fuzzy finder
│       │   │   ├── catppuccin.lua # Color scheme
│       │   │   ├── nvim-tree.lua  # File explorer
│       │   │   ├── lspconfig.lua  # LSP configuration
│       │   │   └── ...            # Other plugins
│       │   └── behaviors/         # Terminal integrations
│       └── lazy.lua               # Plugin manager bootstrap
├── scripts/                       # Utility scripts
│   └── neovim                     # Neovim wrapper with Python env
├── install                        # Installation script
├── LICENSE                        # MIT License
└── SECURITY.md                    # Security policy
```

---

## Neovim Configuration

### Neovim Plugins

| Plugin | Purpose | Loading |
|--------|---------|---------|
| **lazy.nvim** | Plugin manager | Always |
| **catppuccin** | Frappe color scheme | Priority |
| **blink.cmp** | Fast completion (0.5-4ms) | Insert mode |
| **fzf-lua** | Fuzzy finder | On command |
| **nvim-lspconfig** | LSP client | On attach |
| **mason.nvim** | LSP/formatter installer | Lazy |
| **nvim-treesitter** | Syntax highlighting | BufRead |
| **nvim-tree** | File explorer | On command |
| **lualine** | Statusline | Always |
| **which-key** | Keybinding help | VeryLazy |
| **conform.nvim** | Code formatting | On format |
| **auto-save** | Automatic saving | Insert/TextChanged |
| **nvim-osc52** | SSH clipboard | Always |
| **noice.nvim** | UI improvements | VeryLazy |
| **alpha** | Dashboard | VimEnter |
| **fidget** | LSP progress | LSP attach |

### Neovim Keybindings

Leader key: `<Space>`

#### File Navigation
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fr` | Recent files |
| `<leader>fh` | Help tags |
| `<leader>fc` | Commands |
| `<leader>fk` | Keymaps |

#### Buffer Management
| Key | Action |
|-----|--------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Close all except current |

#### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gI` | Go to implementation |
| `<leader>lrn` | Rename symbol |
| `<leader>lca` | Code action |
| `<leader>cf` | Format code |

#### File Explorer
| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle explorer |
| `<leader>er` | Refresh explorer |
| `<leader>ec` | Collapse explorer |

#### Clipboard
| Key | Action |
|-----|--------|
| `<leader>yp` | Copy full path |
| `<leader>yn` | Copy filename |
| `<leader>yr` | Copy relative path |
| `<leader>yl` | Copy path:line |

#### Windows & Tabs
| Key | Action |
|-----|--------|
| `<leader>wv` | Split vertical |
| `<leader>wh` | Split horizontal |
| `<leader>wx` | Close split |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |

### Color Scheme

OpsConfig uses **Catppuccin Frappe** with transparent background:

- **Flavor**: Frappe (subdued, muted colors)
- **Background**: Transparent
- **Integrations**: LSP, Treesitter, Git signs, Completion

Colors are optimized for remote server terminals without NerdFont dependencies.

---

## Bash Configuration

### Bash Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `c` | `clear` | Clear screen |
| `q`, `e`, `quit` | `exit` | Exit shell |
| `v`, `vi`, `vim` | Neovim wrapper | Edit with Neovim |
| `..`, `...`, `....` | `cd ..`, etc. | Quick navigation |
| `l`, `ls`, `ll` | Enhanced ls | Sorted, colored listing |
| `u` | `update_system` | Full system update |
| `clip`, `copy` | `remote-copy` | Copy to clipboard |
| `reload` | `source ~/.bashrc` | Reload configuration |

### Bash Functions

#### `update_system` / `u`
Comprehensive system update:
1. Runs `before_install` hook (if exists)
2. Updates OpsConfig from GitHub
3. Updates system packages (apt/dnf/yum/apk)
4. Updates Composer (if PHP available)
5. Runs `after_install` hook (if exists)
6. Reloads bash configuration

#### `remote-copy`
SSH-aware clipboard function:
- **SSH sessions**: Uses OSC52 escape sequence
- **Local (Wayland)**: Uses wl-copy
- **Local (X11)**: Uses xclip or xsel
- **macOS**: Uses pbcopy
- **Fallback**: OSC52 for any terminal

#### `detect_distro`
Returns current Linux distribution:
- ubuntu, debian, fedora, centos, rhel, rocky, almalinux, alpine, unknown

### Shell Options

```bash
HISTCONTROL=ignoreboth:erasedups  # Ignore duplicates
HISTSIZE=10000                     # Commands in memory
HISTFILESIZE=20000                 # Commands in file
HISTTIMEFORMAT="%F %T "            # Timestamps

shopt -s histappend    # Append to history
shopt -s cdspell       # Auto-correct cd typos
shopt -s dirspell      # Directory spell correction
shopt -s autocd        # cd without typing cd
shopt -s globstar      # Enable ** globbing
shopt -s nocaseglob    # Case-insensitive globbing
```

---

## TMUX Configuration

### Prefix Key
`Ctrl-Space` (not default `Ctrl-b`)

### Key Bindings

| Key | Action |
|-----|--------|
| `prefix + \|` | Vertical split |
| `prefix + -` | Horizontal split |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + Enter` | Enter copy mode |
| `v` (copy mode) | Begin selection |
| `y` (copy mode) | Copy selection |

### Features
- **Vi Mode**: Vim-style copy mode navigation
- **Mouse Support**: Click, scroll, resize
- **True Color**: Full 256/true color support
- **OSC52**: Clipboard passthrough for SSH
- **Zero Escape Time**: No delay for SSH sessions

---

## Clipboard Integration

OpsConfig provides seamless clipboard integration across environments:

### How It Works

1. **Local Terminal**: Uses native clipboard tools (wl-copy, xclip, pbcopy)
2. **SSH Session**: Uses OSC52 escape sequence
3. **SSH + TMUX**: TMUX passes OSC52 through to local terminal
4. **Nested TMUX**: Proper escape sequence wrapping

### Supported Terminals
- WezTerm (full OSC52 support)
- Gnome Terminal (OSC52 support)
- iTerm2 (OSC52 support)
- Alacritty (OSC52 support)
- kitty (OSC52 support)

### Usage
```bash
# Copy text
echo "text" | clip
cat file.txt | copy

# Copy in Neovim
<leader>yp  # Copy full path
<leader>yn  # Copy filename
```

---

## SSH Remote Management

### Best Practices

#### Connection Multiplexing
Add to `~/.ssh/config`:
```ssh
Host *
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p
    ControlPersist 600
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

#### SSH Agent Auto-Start
OpsConfig automatically starts ssh-agent if not running.

#### Mosh Support
For unstable connections, use Mosh:
```bash
mosh user@server
```

### Clipboard Over SSH
1. Ensure your local terminal supports OSC52
2. Use TMUX on the remote server
3. Copy operations will work transparently

---

## Update System

### Single Command Update
```bash
u  # or 'update_system'
```

### What Gets Updated
1. **OpsConfig**: Latest from GitHub
2. **System Packages**: Via apt/dnf/yum/apk
3. **Composer**: PHP package manager (if available)
4. **PHP Version**: Default CLI version (if configured)

### Custom Hooks
Create scripts in `~/.config/opsconfig/`:
- `before_install`: Runs before OpsConfig update
- `after_install`: Runs after update completes

---

## Customization

### Server Name
Set during installation or edit:
```bash
echo 'SERVER_NAME="my-server"' > ~/.config/opsconfig/.bash_env_local
```

### PHP Version
```bash
echo '8.2' > ~/.config/opsconfig/.php
```

### Environment Variables
Edit `~/.config/opsconfig/.bash_env_local` for server-specific overrides.

### Python Path
```bash
export OPSCONFIG_PYTHON_LIB_PATH="/custom/path/python"
```

---

## Troubleshooting

### Common Issues

#### Neovim: Plugin errors
```bash
# Clear plugin cache
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
nvim  # Reinstalls plugins
```

#### Clipboard not working over SSH
1. Check terminal OSC52 support
2. Verify TMUX has `set -g set-clipboard on`
3. Ensure `set -g allow-passthrough on`

#### Slow startup
1. Check LSP server health: `:checkhealth`
2. Review lazy-loaded plugins: `:Lazy profile`

#### Font issues
Icons display as boxes:
- OpsConfig uses ASCII-compatible icons by default
- NerdFonts are optional enhancements

---

## Security

See [SECURITY.md](SECURITY.md) for:
- Reporting vulnerabilities
- Security considerations
- What the install script modifies
- File permissions

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- [Neovim](https://neovim.io/) - Hyperextensible Vim-based text editor
- [Catppuccin](https://github.com/catppuccin/nvim) - Soothing pastel theme
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- [blink.cmp](https://github.com/saghen/blink.cmp) - Fast completion engine
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) - Fast fuzzy finder
