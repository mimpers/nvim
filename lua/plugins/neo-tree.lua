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
    keys = {
        {
            '\\',
            function()
                -- get Git root if it exists, fallback to cwd
                local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
                local dir = vim.fn.isdirectory(git_root) == 1 and git_root or vim.loop.cwd()
                require('neo-tree.command').execute({
                    toggle = true,
                    dir = dir,
                    reveal = true,  -- keeps current file selected
                })
            end,
            desc = 'Toggle NeoTree at Git root',
            silent = true,
        },
    },
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
        filesystem = {
            follow_current_file = { enabled = true },
            group_empty_dirs = true,
            hijack_netrw_behavior = 'open_default',
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
