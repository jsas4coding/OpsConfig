# Security Policy

## Reporting Vulnerabilities

If you discover a security vulnerability in OpsConfig, please report it privately:

1. **Do not** create a public GitHub issue
2. Email the maintainer directly with details
3. Include steps to reproduce the vulnerability
4. Allow reasonable time for a fix before public disclosure

## Security Considerations

### Installation Script

The `install` script performs the following privileged operations when run as root:

| Operation | Purpose | Risk Level |
|-----------|---------|------------|
| `apt install` | Install system packages | Low |
| Download Neovim | Install from GitHub releases | Low |
| Modify `/etc/environment` | Add PATH entries | Medium |
| Create `/var/scripts/` | Wrapper script location | Low |
| Install fonts | User font directory | Low |

### File Modifications

| File/Directory | Operation | Notes |
|----------------|-----------|-------|
| `~/.bashrc` | Replaced | Via stow symlink |
| `~/.bash_*` | Replaced | Via stow symlink |
| `~/.config/nvim/` | Replaced | Via stow symlink |
| `~/.tmux.conf` | Replaced | Via stow symlink |
| `/opt/nvim/` | Created | Neovim installation |
| `/var/scripts/neovim` | Created | Wrapper script |
| `/etc/environment` | Modified | PATH additions |

### Network Operations

The install script downloads from:

| Source | Purpose | Verification |
|--------|---------|--------------|
| `github.com/neovim` | Neovim binary | HTTPS |
| `github.com/nerd-fonts` | Font files | SHA256 hash |
| `github.com/nvm-sh` | Node Version Manager | HTTPS |
| `getcomposer.org` | Composer installer | SHA384 checksum |
| `raw.githubusercontent.com` | OpsConfig files | HTTPS |

### Credentials

OpsConfig does **not**:
- Store any passwords or secrets
- Access external APIs with credentials
- Modify SSH keys or configurations
- Send telemetry or analytics

### User-Specific Files

Configuration files stored in `~/.config/opsconfig/`:

| File | Contents | Sensitivity |
|------|----------|-------------|
| `.bash_env_local` | Server name | Low |
| `.php` | PHP version number | Low |
| `*.hash` | Font file hashes | None |

## Best Practices

### Before Installation

1. **Backup** existing configurations:
   ```bash
   cp -r ~/.bashrc ~/.config/nvim ~/backup/
   ```

2. **Review** the install script:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/jsas4coding/ops-config/main/install | less
   ```

3. **Test** in a non-production environment first

### After Installation

1. **Review** installed configurations
2. **Customize** `~/.config/opsconfig/.bash_env_local` with server name
3. **Verify** no sensitive data in configuration files

### SSH Security

When using OpsConfig on remote servers:

1. Use **key-based authentication** (not passwords)
2. Configure **SSH agent forwarding** carefully
3. Review TMUX clipboard settings if handling sensitive data
4. Consider disabling OSC52 clipboard if not needed:
   ```bash
   # In .tmux.conf
   set -g set-clipboard off
   ```

## Supported Versions

Only the latest version of OpsConfig receives security updates.

| Version | Supported |
|---------|-----------|
| Latest (main branch) | Yes |
| Older versions | No |

## Dependencies

OpsConfig relies on third-party software. Security updates for these should be applied through your system's package manager:

- Neovim
- Node.js / NVM
- Python / pip packages
- GNU Stow
- ripgrep
- curl / jq / git

## Permissions

### File Permissions

| Location | Default Mode | Notes |
|----------|--------------|-------|
| Scripts (`/var/scripts/`) | 755 | Executable by all |
| Config files | 644 | Readable by all |
| `.bash_env_local` | 644 | Consider 600 for sensitive |

### Recommendations

For servers with sensitive data:

```bash
# Restrict local environment file
chmod 600 ~/.config/opsconfig/.bash_env_local

# Restrict SSH config if present
chmod 600 ~/.ssh/config
```

## Acknowledgments

Security improvements and vulnerability reports are appreciated. Thank you for helping keep OpsConfig secure.
