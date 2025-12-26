-- Conform Plugin
-- Lightweight yet powerful formatter plugin for Neovim

return {
  'stevearc/conform.nvim',

  enabled = true,

  event = {
    'BufWritePre',
  },

  config = function()
    local conform = require('conform')
    local format_opts = { lsp_fallback = true, async = false, timeout_ms = 1000 }

    local formatters = {}

    formatters.shfmt = {
      inherit = false,
      command = 'shfmt',
      args = {
        '-i',
        '2',
        '-ci',
        '-s',
      },
      stdin = true,
    }

    formatters.systemd_analyze = {
      command = 'systemd-analyze',
      args = {
        'verify',
      },
      stdin = false,
    }

    formatters.nginxfmt = {
      inherit = false,
      command = 'nginxfmt',
      args = {
        '--indent',
        '2',
        '$FILENAME',
      },
      stdin = false,
    }

    local formatters_by_ft = {}

    formatters_by_ft.nginx = { 'nginxfmt' }
    formatters_by_ft.json = { 'prettier' }
    formatters_by_ft.markdown = { 'prettier' }
    formatters_by_ft.graphql = { 'prettier' }
    formatters_by_ft.sh = { 'shfmt' }
    formatters_by_ft.bash = { 'shfmt' }
    formatters_by_ft.zsh = { 'shfmt' }
    formatters_by_ft.systemd = { 'systemd_analyze' }

    conform.setup({
      log_level = vim.log.levels.WARN,
      notify_on_error = true,
      formatters = formatters,
      formatters_by_ft = formatters_by_ft,

      format_on_save = function(bufnr)
        conform.format(vim.tbl_extend('force', { bufnr = bufnr }, format_opts))
      end,
    })
  end,
}