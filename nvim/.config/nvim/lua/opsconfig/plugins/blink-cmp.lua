-- Blink Completion Plugin
-- High-performance completion engine for Neovim
-- Replaces nvim-cmp with faster, more responsive completion

return {
  'saghen/blink.cmp',

  enabled = true,
  lazy = false,
  version = '*', -- Use latest release

  dependencies = {
    { 'rafamadriz/friendly-snippets', enabled = true },
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Keymap configuration
    keymap = {
      preset = 'default',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },

    -- Appearance settings
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono', -- Fallback to text if no nerd font
    },

    -- Completion sources
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      cmdline = {},
    },

    -- Signature help
    signature = {
      enabled = true,
    },

    -- Completion menu configuration
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        border = 'rounded',
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = 'rounded',
        },
      },
      ghost_text = {
        enabled = false, -- Can enable for inline preview
      },
    },
  },

  -- Provides LSP capabilities to nvim-lspconfig
  opts_extend = { 'sources.default' },
}
