-- OpsConfig Plugin Definitions
-- Modular plugin system - loads individual plugin configurations

local plugin_loader = require('opsconfig.plugins')

-- Load all plugins from individual files
local plugins = plugin_loader.load_plugins()

-- Validate plugin configuration integrity
plugin_loader.validate_plugins()

return plugins