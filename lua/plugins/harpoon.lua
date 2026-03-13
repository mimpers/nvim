-- Harpoon 2 quick file navigation
---@type LazySpec
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        -- keymaps
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon add file" })

        -- open harpoon menu
        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon menu" })

        -- jump to files
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = '[1] harpoon file' })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = '[2] harpoon file' })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = '[3] harpoon file' })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = '[4] harpoon file' })
        vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end, { desc = '[N]ext harpoon file' })
        vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end, { desc = '[P]revious harpoon file' })

        -- telescope integration
        vim.keymap.set("n", "<leader>fh", function()
            require("telescope").extensions.harpoon.marks()
        end, { desc = "Telescope Harpoon" })
    end,
}
