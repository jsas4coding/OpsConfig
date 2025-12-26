-- NvimTree File Explorer Plugin
-- Modern file explorer with Git integration and custom icons

return {
  'nvim-tree/nvim-tree.lua',

  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },

  config = function()
    local nvimtree = require('nvim-tree')

    -- Disable netrw (replaced by nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      respect_buf_cwd = true,
      sync_root_with_cwd = true,

      view = {
        side = 'left',
        width = 60,
        relativenumber = false,
        cursorline = true,
        preserve_window_proportions = true,
      },

      update_focused_file = {
        enable = true,
        update_root = false,
        update_cwd = true,
        ignore_list = {},
      },

      renderer = {
        highlight_git = true,
        highlight_opened_files = 'all',
        root_folder_label = false,
        symlink_destination = false,

        indent_markers = {
          enable = false,
        },

        icons = {
          git_placement = 'after',
          webdev_colors = true,
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },

          glyphs = {
            default = '',
            symlink = '',
            folder = {
              arrow_closed = '   ',
              arrow_open = '   ',
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
              symlink_open = '',
            },
            git = {
              unstaged = '',
              staged = '',
              unmerged = '',
              renamed = '➜',
              untracked = '',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },

      actions = {
        open_file = {
          quit_on_open = false,
          window_picker = {
            enable = false,
          },
        },
      },

      git = {
        enable = true,
        ignore = false,
        timeout = 10000,
      },

      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Apply default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom mappings
        vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      end,
    })
  end,
}