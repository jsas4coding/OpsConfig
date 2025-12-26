-- Web DevIcons Plugin
-- Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more

return {
  'nvim-tree/nvim-web-devicons',

  enabled = true,

  config = function()
    require('nvim-web-devicons').setup({
      override = {
        nginx = {
          icon = '',
          color = '#009639',
          name = 'Nginx',
        },

        ['*.nginx'] = {
          icon = '',
          color = '#009639',
          name = 'NginxCustom',
        },
      },
    })
  end,
}