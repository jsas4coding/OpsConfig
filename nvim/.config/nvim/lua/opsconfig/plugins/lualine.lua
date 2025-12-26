-- Lualine Plugin
-- A blazing fast and easy to configure neovim statusline plugin written in pure lua

return {
  'nvim-lualine/lualine.nvim',

  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = true },
    { 'catppuccin/nvim', enabled = true },
  },

  config = function()
    local lualine = require('lualine')
    local lazy_status = require('lazy.status')
    local setup = {}
    local plugins_updates_color = '#fab387'

    local noice = require('noice')

    setup.options = {
      theme = 'catppuccin',
    }

    setup.sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
        'diagnostics',
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          file_status = true,
          newfile_status = true,
          shorting_target = 40,
          symbols = {
            modified = ' ✎',
            readonly = ' ',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
          color = function()
            if vim.bo.modified then
              return { fg = '#f38ba8', gui = 'bold' }
            end

            return nil
          end,
        },
      },
      lualine_x = {
        {
          noice.api.statusline.mode.get,
          cond = noice.api.statusline.mode.has,
          color = { fg = '#ff9e64' },
        },
        {
          lazy_status.updates,
          cond = lazy_status.has_updates,
          color = { fg = plugins_updates_color },
        },
        'encoding',
        'fileformat',
        {
          'filetype',
          icon = function()
            local ftype = vim.bo.filetype

            if ftype == 'vim' and vim.fn.expand('%:t') == 'vifmrc' then
              return ''
            else
              return require('nvim-web-devicons').get_icon_by_filetype(ftype, { default = true })
            end
          end,
        },
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    }

    lualine.setup(setup)
  end,
}