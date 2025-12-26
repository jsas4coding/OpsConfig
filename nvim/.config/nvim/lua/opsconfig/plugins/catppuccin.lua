-- Catppuccin Theme Plugin
-- Modern colorscheme with extensive integration support

return {
  'catppuccin/nvim',

  name = 'catppuccin',
  enabled = true,
  priority = 1000, -- Load early for theme application

  config = function()
    require('catppuccin').setup({
      flavour = 'frappe', -- latte, frappe, macchiato, mocha
      background = {
        light = 'latte',
        dark = 'frappe',
      },
      transparent_background = true, -- Disables setting background color
      show_end_of_buffer = false, -- Shows '~' after end of buffers
      term_colors = false, -- Sets terminal colors
      dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        fidget = true,
        harpoon = true,
        telescope = {
          enabled = false, -- Using fzf-lua instead
        },
        which_key = true,
        markdown = true,
        noice = true,
        copilot_vim = false,
        dap = false,
        dap_ui = false,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        lsp_trouble = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    })

    -- Apply the colorscheme
    vim.cmd('colorscheme catppuccin')
  end,
}