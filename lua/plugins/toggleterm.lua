-- toggleterm.nvim plugin configuration
return {
    'akinsho/toggleterm.nvim',
    version = '*', -- Use the latest stable release
    config = function()
        local toggleterm = require('toggleterm')

        -- [[ Basic toggleterm setup ]]
        -- See `:help toggleterm.nvim`
        toggleterm.setup {
            size = 15,                   -- Height of horizontal terminal
            open_mapping = [[<c-\>]],    -- Ctrl+\ toggles the terminal
            shading_factor = 2,          -- Darken the terminal background
            direction = 'horizontal',    -- Default terminal orientation
            close_on_exit = true,         -- Automatically close when command exits
            start_in_insert = true,       -- Start terminal in insert mode
        }

        -- [[ Custom floating terminals ]]
        -- We can define multiple terminal presets for common commands
        local Terminal = require('toggleterm.terminal').Terminal

        -- Cargo run terminal
        local cargo_run = Terminal:new {
            cmd = 'cargo run',
            direction = 'float',
            close_on_exit = true,
        }
        function _CARGO_RUN_TOGGLE() cargo_run:toggle() end

        -- Cargo build terminal
        local cargo_build = Terminal:new {
            cmd = 'cargo build',
            direction = 'float',
            close_on_exit = false,
        }
        function _CARGO_BUILD_TOGGLE() cargo_build:toggle() end

        -- [[ Keymaps ]]
        -- Toggle Cargo terminals with leader shortcuts
        vim.keymap.set('n', '<leader>cr', '<cmd>lua _CARGO_RUN_TOGGLE()<CR>', { desc = 'Cargo Run' })
        vim.keymap.set('n', '<leader>cb', '<cmd>lua _CARGO_BUILD_TOGGLE()<CR>', { desc = 'Cargo Build' })

        -- Convenient visual mode indenting
        vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent selection right' })
        vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Indent selection left' })
    end,
}

