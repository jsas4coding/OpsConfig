-- Auto Save Plugin
-- Automatically save files on certain events

return {
  'okuuva/auto-save.nvim',

  cmd = 'ASToggle',

  event = {
    'InsertLeave',
    'TextChanged',
  },

  config = function()
    local autosave = require('auto-save')

    autosave.setup({
      enabled = true,
      write_all_buffers = false,
      noautocmd = false,
      lockmarks = false,
      debounce_delay = 2000,
      debug = false,

      trigger_events = {
        immediate_save = { 'BufLeave', 'FocusLost', 'QuitPre', 'VimSuspend' },

        defer_save = {
          'InsertLeave',
          'TextChanged',
          { 'User', pattern = 'VisualLeave' },
          { 'User', pattern = 'FlashJumpEnd' },
          { 'User', pattern = 'SnacksInputLeave' },
          { 'User', pattern = 'SnacksPickerInputLeave' },
        },

        cancel_deferred_save = {
          'InsertEnter',
          { 'User', pattern = 'VisualEnter' },
          { 'User', pattern = 'FlashJumpStart' },
          { 'User', pattern = 'SnacksInputEnter' },
          { 'User', pattern = 'SnacksPickerInputEnter' },
        },
      },

      condition = function(buf)
        if vim.fn.mode() == 'i' then
          return false
        end

        local blocked_filetypes = {
          'neo-tree', -- NeoTree file explorer
          'oil', -- oil.nvim file explorer
          'TelescopePrompt', -- Telescope prompt
          'lazy', -- lazy.nvim UI
          'lazygit', -- lazygit.nvim UI
          'toggleterm', -- toggleterm terminal buffer
          'OverseerList', -- overseer.nvim task manager
          'qf', -- quickfix window
          'diff', -- diff view
          'fugitive', -- fugitive buffers
          'notify', -- nvim-notify (noice)
          'snacks_input', -- input temporário (custom plugin)
          'snacks_picker_input',
          'noice', -- noice.nvim popup
          'dap-repl', -- DAP REPL
          'dapui_watches', -- DAP UI
          'dapui_stacks',
          'dapui_breakpoints',
          'dapui_scopes',
          'dapui_console',
          'copilot-chat', -- copilot-chat
          'gitcommit', -- commit message
          'sql', -- SQL buffers (avoid running accidentally)
          'mysql', -- same as above
          'harpoon', -- harpoon buffer
          'markdown', -- render-markdown with temporary buffer
        }

        local ft = vim.bo[buf].filetype

        if vim.tbl_contains(blocked_filetypes, ft) then
          return false
        end

        return true
      end,

      callbacks = {
        before_saving = function()
          vim.notify('[~] Saving...', vim.log.levels.INFO, { title = 'AutoSave', timeout = 300 })
        end,

        after_saving = function()
          vim.notify('[+] Saved', vim.log.levels.INFO, { title = 'AutoSave', timeout = 1000 })
        end,
      },
    })

    local wk = require('which-key')

    wk.add({
      {
        '<leader>ua',
        '<cmd>AutoSaveToggleNotify<CR>',
        desc = 'Toggle AutoSave',
        icon = { color = 'cyan', icon = '~' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })
  end,
}