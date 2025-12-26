-- Mason Plugin
-- Portable package manager for Neovim that runs everywhere Neovim runs

return {
  'williamboman/mason.nvim',

  enabled = true,

  dependencies = {
    { 'neovim/nvim-lspconfig', enabled = true },
    { 'williamboman/mason-lspconfig.nvim', enabled = true },
    { 'nvimtools/none-ls.nvim', enabled = true },
    { 'jay-babu/mason-null-ls.nvim', enabled = true },
  },

  config = function()
    local mason = require('mason')

    mason.setup()

    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup({
      ensure_installed = {
        'bashls',
        'jsonls',
        'yamlls',
      },
      automatic_installation = true,
      automatic_enable = true,
    })

    local mason_null_ls = require('mason-null-ls')

    mason_null_ls.setup({
      ensure_installed = {
        'stylua',
        'prettier',
        'shfmt',
        'systemd_analyze',
        'jq',
      },
      automatic_installation = true,
    })
  end,
}