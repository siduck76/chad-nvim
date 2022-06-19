-- Just an example, supposed to be placed in /lua/custom/


local M = {}

print("hello")
-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
M.options = {
    user = function()
        local options_ok, options = pcall(require, "custom.options")
        if not options_ok then print(options) return end
    end
}


-- safe load plugins
local plugins_configs_ok, plugins_configs = pcall(require, "custom.plugins")
if not plugins_configs_ok then print(plugins_configs) return end

M.plugins = {
    user = plugins_configs.additional_plugins,
    options = {
        lspconfig = {
            setup_lspconf = "custom.plugins.configs.lspconfig"
        }
    },
    override = {
        ["kyazdani42/nvim-tree.lua"] = plugins_configs.custom_nvimtree_config,
        ["lewis6991/gitsigns.nvim"] = plugins_configs.custom_gitsigns_config,
    }
}


-- safe load highlights
local highlights_add_ok, highlights_add = pcall(require, "custom.highlights_add")
local highlights_override_ok, highlights_override = pcall(require, "custom.highlights_override")
if not highlights_add_ok then print(highlights_add) return end
if not highlights_override_ok then print(highlights_override) return end

M.ui = {
    theme = "onedark",
    hl_override = highlights_override,
    hl_add = highlights_add,
    statusline = {
        separator_style = "block"
    }
}

M.mappings = require("custom.mappings")

return M
