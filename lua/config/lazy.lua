-- [[ Install `lazy.nvim` plugin manager ]]
--  Lazy.nvim is a modern, fast plugin manager for Neovim.
--  See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

-- Path where lazy.nvim should be installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Check if lazy.nvim exists at the path. If not, clone it from GitHub
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- Git repository URL
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'

    -- Clone the repository into lazypath
    local out = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',  -- avoid downloading full history to save time
        '--branch=stable',     -- use the stable branch
        lazyrepo,
        lazypath,
    })

    -- Check if the clone was successful
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

-- Prepend lazy.nvim to runtime path, so Neovim can load it
---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Load plugins ]]
--  This tells lazy.nvim where to find your plugin configurations.
--  Using `{ import = "plugins" }` automatically loads all Lua files
--  inside `lua/plugins/` folder.
require("lazy").setup(
    require("plugins"), -- your plugin specs from lua/plugins/init.lua
    {
        ui = {
            icons = vim.g.have_nerd_font and {} or {
                cmd     = '⌘',
                config  = '🛠',
                event   = '📅',
                ft      = '📂',
                init    = '⚙',
                keys    = '🗝',
                plugin  = '🔌',
                runtime = '💻',
                require = '🌙',
                source  = '📄',
                start   = '🚀',
                task    = '📌',
                lazy    = '💤 ',
            },
        },
    }
)
