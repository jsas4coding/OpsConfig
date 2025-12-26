-- OpsConfig Plugin Loader
-- Loads all individual plugin configurations from the plugins/ directory

local M = {}

-- List of all plugin files to load (in order of dependency and functionality)
local plugin_files = {
  -- Foundation libraries (load first)
  'plenary',              -- Lua utility library
  'web-devicons',         -- File icons
  'fixcursorhold',        -- CursorHold event fix
  
  -- Theme (high priority)
  'catppuccin',          -- Color theme
  
  -- Core UI components
  'alpha',               -- Start screen
  'lualine',             -- Status line
  'which-key',           -- Key binding help
  'dressing',            -- UI improvements
  'noice',               -- UI replacements
  'indent-blankline',    -- Indentation guides
  
  -- File management
  'nvim-tree',           -- File explorer
  'fzf-lua',             -- Fast fuzzy finder
  'telescope-fzf-native', -- FZF integration for telescope
  'telescope-frecency',   -- Frecency algorithm for telescope
  'telescope-ui-select',  -- UI select replacement
  'telescope',           -- Main fuzzy finder
  
  -- Code intelligence and LSP
  'mason',               -- LSP/tool installer
  'nvim-lspconfig',      -- LSP configuration
  'nvim-cmp',            -- Completion engine
  'lazydev',             -- Lua development support
  'fidget',              -- LSP progress notifications
  
  -- Code editing and formatting
  'conform',             -- Code formatting
  'nvim-treesitter',     -- Syntax highlighting
  'treesitter-context',  -- Context display
  'nvim-ts-autotag',     -- Auto tag closing
  'auto-save',           -- Auto-save functionality
  
  -- System integration
  'nvim-osc52',          -- OSC52 clipboard integration
}

-- Load all plugin configurations
function M.load_plugins()
  local plugins = {}
  
  for _, plugin_file in ipairs(plugin_files) do
    local ok, plugin_config = pcall(require, 'opsconfig.plugins.' .. plugin_file)
    
    if ok then
      -- If plugin returns a table, add it to plugins
      if type(plugin_config) == 'table' then
        if plugin_config[1] then
          -- Multiple plugins in one file
          vim.list_extend(plugins, plugin_config)
        else
          -- Single plugin
          table.insert(plugins, plugin_config)
        end
      end
    else
      vim.notify(
        'Failed to load plugin: ' .. plugin_file .. '\nError: ' .. plugin_config,
        vim.log.levels.ERROR,
        { title = 'OpsConfig Plugin Loader' }
      )
    end
  end
  
  return plugins
end

-- Validation function to check plugin integrity
function M.validate_plugins()
  local issues = {}
  
  for _, plugin_file in ipairs(plugin_files) do
    local plugin_path = 'lua/opsconfig/plugins/' .. plugin_file .. '.lua'
    local file_path = vim.fn.stdpath('config') .. '/' .. plugin_path
    
    if vim.fn.filereadable(file_path) ~= 1 then
      table.insert(issues, 'Missing plugin file: ' .. plugin_path)
    end
  end
  
  if #issues > 0 then
    vim.notify(
      'Plugin validation issues found:\n' .. table.concat(issues, '\n'),
      vim.log.levels.WARN,
      { title = 'OpsConfig Plugin Validation' }
    )
    return false
  end
  
  return true
end

-- Health check function for :checkhealth
function M.check()
  vim.health.start('OpsConfig Plugins')
  
  -- Check if all plugin files exist
  local missing_files = {}
  for _, plugin_file in ipairs(plugin_files) do
    local plugin_path = vim.fn.stdpath('config') .. '/lua/opsconfig/plugins/' .. plugin_file .. '.lua'
    if vim.fn.filereadable(plugin_path) ~= 1 then
      table.insert(missing_files, plugin_file .. '.lua')
    end
  end
  
  if #missing_files == 0 then
    vim.health.ok(#plugin_files .. ' plugin files found')
  else
    vim.health.error('Missing plugin files: ' .. table.concat(missing_files, ', '))
  end
  
  -- Check plugin loading
  local load_success = 0
  local load_errors = {}
  
  for _, plugin_file in ipairs(plugin_files) do
    local ok, result = pcall(require, 'opsconfig.plugins.' .. plugin_file)
    if ok then
      load_success = load_success + 1
    else
      table.insert(load_errors, plugin_file .. ': ' .. tostring(result))
    end
  end
  
  vim.health.info('Successfully loaded: ' .. load_success .. '/' .. #plugin_files .. ' plugins')
  
  if #load_errors > 0 then
    for _, error in ipairs(load_errors) do
      vim.health.error(error)
    end
  end
end

return M