-- Alpha Dashboard Plugin
-- Fast and customizable greeter for Neovim

return {
  'goolord/alpha-nvim',

  event = 'VimEnter',
  enabled = true,

  dependencies = {
    { 'nvim-lua/plenary.nvim', enabled = true },
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },

  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }

    -- ASCII-compatible icons for maximum terminal support
    dashboard.section.buttons.val = {
      dashboard.button('e', '[+] New File', '<cmd>ene<CR>'),
      dashboard.button('SPC ee', '[E] File Explorer', '<cmd>NvimTreeToggle<CR>'),
      dashboard.button('SPC wr', '[R] Restore Session', '<cmd>SessionRestore<CR>'),
      dashboard.button('q', '[X] Quit NVIM', '<cmd>qa<CR>'),
    }

    alpha.setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}