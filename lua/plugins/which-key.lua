-- lua/plugins/which-key.lua
-- Shows pending keybinds and helps document existing keychains

---@type LazyPluginSpec
return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    dependencies = { 'lewis6991/gitsigns.nvim' },  -- ensures gitsigns loads first
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        -- Delay between pressing a key and opening which-key (milliseconds)
        delay = 0,
        icons = { mappings = vim.g.have_nerd_font },

        -- Document existing key chains
        spec = {
            { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
            { '<leader>t', group = '[T]oggle' },
            { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
            { '<leader>c', group = '[C]argo', mode = { 'n' } },
            { 'g', group = '[G]oto' },
            { 'gr', group = '[G]oto [R]eferences/LSP', mode = { 'n' } },
        },
    },
}
