-- lua/plugins/gitsigns.lua
-- Adds git related signs to the gutter and utilities for managing changes

---@type LazyPluginSpec
-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.

---@module 'lazy'
---@type LazySpec
return {
    'lewis6991/gitsigns.nvim',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require 'gitsigns'

            require('config.keymaps').setup_gitsigns(gitsigns, bufnr)
        end,
    },
}
