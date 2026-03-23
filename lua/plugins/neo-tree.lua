-- Neo-tree file explorer
---@module 'lazy'
---@type LazySpec
return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*', -- use latest stable
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = require('config.keymaps').setup_neotree(),

    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
        filesystem = {
            follow_current_file = { enabled = true },
            group_empty_dirs = true,
            hijack_netrw_behavior = 'disabled',
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                never_show = {},
                hide_by_name = {},
            },
            use_libuv_file_watcher = true,
            window = {
                mappings = {
                    ['\\'] = 'close_window', -- also closes tree
                },
            },
            git_status = {
                enabled = true,
                show_on_dirs = true,
                show_on_open_dirs = true,
                symbols = {
                    added     = "✚",
                    modified  = "",
                    deleted   = "✖",
                    renamed   = "➜",
                    untracked = "★",
                    ignored   = "◌",
                    unstaged  = "✗",
                    staged    = "✓",
                    conflict  = "",
                },
            },
        },
    },
}
