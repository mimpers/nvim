-- toggleterm.nvim plugin configuration
return {
    'akinsho/toggleterm.nvim',
    version = '*', -- Use the latest stable release
    config = function()
        local toggleterm = require 'toggleterm'

        -- [[ Basic toggleterm setup ]]
        -- See `:help toggleterm.nvim`
        toggleterm.setup {
            size = 15, -- Height of horizontal terminal
            open_mapping = [[<c-\>]], -- Ctrl+\ toggles the terminal
            shading_factor = 2, -- Darken the terminal background
            direction = 'horizontal', -- Default terminal orientation
            close_on_exit = true, -- Automatically close when command exits
            start_in_insert = true, -- Start terminal in insert mode
        }

        -- [[ Custom floating terminals ]]
        -- We can define multiple terminal presets for common commands
        local Terminal = require('toggleterm.terminal').Terminal
        require('config.keymaps').setup_toggleterm(Terminal)
        require('config.vitis').setup(Terminal)
    end,
}
