-- FixCursorHold Plugin
-- Fix CursorHold performance bug in neovim

return {
  'antoinemadec/FixCursorHold.nvim',

  enabled = true,

  config = function()
    vim.g.cursorhold_updatetime = 100
  end,
}