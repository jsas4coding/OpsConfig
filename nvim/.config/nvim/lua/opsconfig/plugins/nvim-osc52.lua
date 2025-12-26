-- OSC52 Copy/Paste Plugin
-- Enables copying to system clipboard over SSH using OSC52 sequences

return {
  'ojroques/nvim-osc52',

  event = 'VeryLazy',

  config = function()
    local osc52 = require('osc52')

    -- Enhanced OSC52 configuration for multiple environments
    osc52.setup({
      max_length = 0,           -- Maximum length of selection (0 for no limit)
      silent = false,           -- Disable message on successful copy
      trim = false,             -- Don't trim whitespace from copied text
      tmux_passthrough = true,  -- Enable Tmux passthrough support
    })

    -- Function to detect environment and copy accordingly
    local function smart_copy(lines, regtype)
      -- Check if we're in SSH session (running NeoVim on remote server)
      local ssh_connection = vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY
      
      if ssh_connection then
        -- We're on a remote server accessed via SSH
        -- Always use OSC52, which will work with or without local TMUX
        -- The local TMUX (if present) will pass through OSC52 to terminal
        osc52.copy(table.concat(lines, '\n'))
      else
        -- Local session: Try system clipboard first, fallback to OSC52
        local success = pcall(function()
          vim.fn.setreg('+', lines, regtype)
        end)
        
        if not success then
          -- Fallback to OSC52 if system clipboard fails
          osc52.copy(table.concat(lines, '\n'))
        end
      end
    end

    -- Enhanced autocmd for automatic copying
    vim.api.nvim_create_autocmd('TextYankPost', {
      group = vim.api.nvim_create_augroup('OSC52_AutoCopy', { clear = true }),
      callback = function()
        -- Only auto-copy if using default register or + register
        local regname = vim.v.event.regname
        if vim.v.event.operator == 'y' and (regname == '' or regname == '+') then
          local lines = vim.v.event.regcontents or {}
          local regtype = vim.v.event.regtype or 'v'
          
          if #lines > 0 then
            smart_copy(lines, regtype)
          end
        end
      end,
    })

    -- Create manual copy command
    vim.api.nvim_create_user_command('OSC52Copy', function(opts)
      local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
      smart_copy(lines, 'V')
    end, {
      range = true,
      desc = 'Copy selection using OSC52'
    })

    -- Keymap for manual OSC52 copy
    vim.keymap.set('v', '<leader>c', function()
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
      
      -- Handle partial line selection
      if #lines > 0 then
        if #lines == 1 then
          lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
        else
          lines[1] = string.sub(lines[1], start_pos[3])
          lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
        end
        smart_copy(lines, vim.fn.visualmode())
      end
    end, { desc = 'Copy selection using OSC52' })
  end,
}