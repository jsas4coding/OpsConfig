-- Nvim Treesitter Plugin
-- Treesitter configurations and abstraction layer for Neovim

return {
  'nvim-treesitter/nvim-treesitter',

  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',

  dependencies = {
    { 'windwp/nvim-ts-autotag', enabled = true },
  },

  config = function()
    local treesitter = require('nvim-treesitter.configs')

    local available = {
      'bash',
      'c',
      'cmake',
      'comment',
      'desktop',
      'dockerfile',
      'editorconfig',
      'git_config',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'goctl',
      'gotmpl',
      'graphql',
      'html',
      'http',
      'ini',
      'java',
      'javadoc',
      'javascript',
      'jinja',
      'jq',
      'jsdoc',
      'json',
      'json5',
      'kotlin',
      'lua',
      'luadoc',
      'luap',
      'make',
      'markdown',
      'markdown_inline',
      'nginx',
      'perl',
      'prisma',
      'query',
      'regex',
      'robots',
      'scss',
      'sql',
      'svelte',
      'tsx',
      'twig',
      'typescript',
      'typespec',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    }

    treesitter.setup({
      modules = {},
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      fold = { enable = true },
      injection = { enable = true },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      ensure_installed = available,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    })
  end,
}