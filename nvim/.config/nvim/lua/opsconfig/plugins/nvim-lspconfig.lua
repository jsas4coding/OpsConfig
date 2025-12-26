-- Neovim LSPConfig Plugin
-- Quickstart configs for Nvim LSP

return {
  'neovim/nvim-lspconfig',

  enabled = true,

  dependencies = {
    { 'williamboman/mason.nvim', enabled = true },
    { 'williamboman/mason-lspconfig.nvim', enabled = true },
  },

  config = function()
    local lspconfig = require('lspconfig')

    local default_config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Use blink.cmp capabilities if available
      local ok, blink = pcall(require, 'blink.cmp')
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local flags = {
        debounce_text_changes = 150,
      }

      return capabilities, flags
    end

    local capabilities, flags = default_config()

    -- SECTION: LSP Servers
    lspconfig.bashls.setup({
      flags = flags,
      capabilities = capabilities,
    })

    lspconfig.jsonls.setup({
      flags = flags,
      capabilities = capabilities,
    })

    local diagnostic_config = {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    -- ASCII-compatible diagnostic signs for maximum terminal support
    local signs = {
      ERROR = 'E',
      WARN = 'W',
      INFO = 'I',
      HINT = 'H',
    }

    local diagnostic_signs = {}

    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end

    diagnostic_config.signs = { text = diagnostic_signs }

    vim.diagnostic.config(diagnostic_config)

    -- SECTION: Inlay Hints and Client Actions

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('opsconfig-lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client then
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('opsconfig-lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('opsconfig-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'opsconfig-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          client.handlers['textDocument/hover'] = function(_, result, _, _)
            local bufnr, winnr = vim.lsp.util.open_floating_preview(result and result.contents or {}, 'markdown', {
              border = 'rounded',
              focusable = false,
              style = 'minimal',
              relative = 'cursor',
              width = 60,
              max_width = 80,
              max_height = 20,
            })

            if winnr then
              vim.api.nvim_win_set_option(winnr, 'winhighlight', 'Normal:NormalFloat,FloatBorder:FloatBorder')
            end

            return bufnr, winnr
          end

          -- Catppuccin Frappé colors for floating windows
          vim.cmd([[
hi NormalFloat guibg=#303446
hi FloatBorder guibg=#303446 guifg=#8caaee
]])
        end
      end,
    })
  end,
}