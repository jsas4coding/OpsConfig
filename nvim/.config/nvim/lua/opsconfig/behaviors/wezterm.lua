local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('opsconfig-wezterm', { clear = true })

autocmd('VimEnter', {
  group = augroup,
  callback = function()
    --NOTE: Set the environment variable NVIM_ENTER to 1
    vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MQ==\007")]])
  end,
})

autocmd('VimLeavePre', {
  group = augroup,
  callback = function()
    --NOTE: Set the environment variable NVIM_ENTER to 0
    vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MA==\007")]])
  end,
})
