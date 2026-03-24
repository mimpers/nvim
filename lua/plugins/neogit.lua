---@type LazySpec
return {
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim', -- required for Neogit
            'sindrets/diffview.nvim', -- optional, but required for Diffview integration
        },
        cmd = 'Neogit',
        keys = require('config.keymaps').setup_neogit(),
        config = function()
            local neogit = require('neogit')

            neogit.setup {
                integrations = {
                    diffview = true, -- enables Diffview integration
                },
                disable_commit_confirmation = true,
            }

            -- Optional: set up Diffview defaults
            require('diffview').setup {
                enhanced_diff_hl = true,
                use_icons = vim.g.have_nerd_font or false,
            }
        end,
    },
}
