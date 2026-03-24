-- lua/plugins/which-key.lua
-- Shows pending keybinds and helps document existing keychains

---@type LazyPluginSpec
return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    dependencies = { 'lewis6991/gitsigns.nvim' }, -- ensures gitsigns loads first
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        -- Delay between pressing a key and opening which-key (milliseconds)
        delay = 0,
        icons = { mappings = vim.g.have_nerd_font },

        -- Document existing key chains
        spec = require('config.keymaps').setup_whichkey(),
    },
}
