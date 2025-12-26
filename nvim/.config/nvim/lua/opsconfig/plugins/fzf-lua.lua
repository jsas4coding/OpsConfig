-- FZF Lua Plugin
-- Fast fuzzy finder powered by fzf and lua
-- Primary fuzzy finder for OpsConfig (replaces Telescope)

return {
  'ibhagwan/fzf-lua',

  enabled = true,
  cmd = 'FzfLua',
  event = 'VeryLazy',

  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },

  config = function()
    local fzf = require('fzf-lua')

    fzf.setup({
      -- Global settings
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = 'rounded',
        preview = {
          default = 'bat',
          border = 'border',
          wrap = 'nowrap',
          hidden = 'nohidden',
          vertical = 'down:45%',
          horizontal = 'right:50%',
          layout = 'flex',
          flip_columns = 120,
        },
      },

      -- Keybindings within fzf window
      keymap = {
        fzf = {
          ['ctrl-q'] = 'select-all+accept',
          ['ctrl-u'] = 'half-page-up',
          ['ctrl-d'] = 'half-page-down',
          ['ctrl-x'] = 'jump',
        },
        builtin = {
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
      },

      -- File pickers
      files = {
        prompt = 'Files> ',
        cmd = 'rg --files --hidden --follow -g "!.git"',
        git_icons = true,
        file_icons = true,
      },

      -- Grep settings
      grep = {
        prompt = 'Grep> ',
        input_prompt = 'Search: ',
        rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096',
        git_icons = true,
        file_icons = true,
      },

      -- Git settings
      git = {
        files = {
          prompt = 'Git Files> ',
          cmd = 'git ls-files --exclude-standard',
        },
        status = {
          prompt = 'Git Status> ',
        },
        commits = {
          prompt = 'Commits> ',
        },
        branches = {
          prompt = 'Branches> ',
        },
      },

      -- Buffers
      buffers = {
        prompt = 'Buffers> ',
        sort_lastused = true,
        show_unloaded = true,
      },

      -- LSP
      lsp = {
        prompt_postfix = '> ',
        cwd_only = false,
        async_or_timeout = 5000,
        symbols = {
          prompt = 'Symbols> ',
          symbol_icons = {
            File = 'F',
            Module = 'M',
            Namespace = 'N',
            Package = 'P',
            Class = 'C',
            Method = 'm',
            Property = 'p',
            Field = 'f',
            Constructor = 'c',
            Enum = 'E',
            Interface = 'I',
            Function = 'fn',
            Variable = 'v',
            Constant = 'const',
            String = 's',
            Number = 'n',
            Boolean = 'b',
            Array = 'a',
            Object = 'o',
            Key = 'k',
            Null = 'null',
            EnumMember = 'em',
            Struct = 'S',
            Event = 'ev',
            Operator = 'op',
            TypeParameter = 'T',
          },
        },
      },

      -- Diagnostics
      diagnostics = {
        prompt = 'Diagnostics> ',
        cwd_only = false,
        file_icons = true,
        git_icons = false,
      },
    })

    -- Keybindings with which-key integration
    local wk = require('which-key')

    wk.add({
      { '<leader>f', group = 'Find' },
      { '<leader>ff', fzf.files, desc = 'Find files' },
      { '<leader>fg', fzf.live_grep, desc = 'Live grep' },
      { '<leader>fb', fzf.buffers, desc = 'Find buffers' },
      { '<leader>fh', fzf.help_tags, desc = 'Help tags' },
      { '<leader>fr', fzf.oldfiles, desc = 'Recent files' },
      { '<leader>fc', fzf.commands, desc = 'Commands' },
      { '<leader>fk', fzf.keymaps, desc = 'Keymaps' },
      { '<leader>fw', fzf.grep_cword, desc = 'Word under cursor' },
      { '<leader>fW', fzf.grep_cWORD, desc = 'WORD under cursor' },
      { '<leader>fs', fzf.lsp_document_symbols, desc = 'Document symbols' },
      { '<leader>fS', fzf.lsp_workspace_symbols, desc = 'Workspace symbols' },
      { '<leader>fd', fzf.diagnostics_document, desc = 'Document diagnostics' },
      { '<leader>fD', fzf.diagnostics_workspace, desc = 'Workspace diagnostics' },
      { '<leader>fm', fzf.marks, desc = 'Marks' },
      { '<leader>f/', fzf.blines, desc = 'Buffer lines' },
      { '<leader>f?', fzf.lines, desc = 'All lines' },
      -- Git
      { '<leader>gf', fzf.git_files, desc = 'Git files' },
      { '<leader>gs', fzf.git_status, desc = 'Git status' },
      { '<leader>gc', fzf.git_commits, desc = 'Git commits' },
      { '<leader>gb', fzf.git_branches, desc = 'Git branches' },
    })
  end,
}
