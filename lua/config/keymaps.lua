-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open diagnostic quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '-', 'o<Esc>p', { desc = 'New line and paste below' })
vim.keymap.set('n', '_', 'O<Esc>p', { desc = 'New line and paste above' })

-- Move lines/block up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>:silent! normal! gv=gv<CR>", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>:silent! normal! gv=gv<CR>", { silent = true })

-- Keep cursor in place when joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Page scrolling keeps cursor in middle of screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Don't replace buffer on paste
vim.keymap.set('x', '<leader>p', '"_dP', { desc = '[P]aste' })
vim.keymap.set('n', '<leader>d', '"_d', { desc = '[D]elete' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = '[D]elete' })

-- Convenient visual mode indenting
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent selection right' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Indent selection left' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic' })

-- [[ Plugin Keymaps ]]
--     add to plugin file: require('config.keymaps').setup_()

local M = {}

M.setup_conform = function()
    return {
        {
            '<leader>f',
            function() require('conform').format { async = true, lsp_format = 'fallback' } end,
            mode = 'n',
            desc = '[F]ormat buffer',
        },
    }
end

M.setup_gitsigns = function(gitsigns, bufnr)
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
        else
            gitsigns.nav_hunk 'next'
        end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
        if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
        else
            gitsigns.nav_hunk 'prev'
        end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk' })
    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk' })
    -- normal mode
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
end

M.setup_harpoon = function(harpoon)
    -- keymaps
    vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon add file' })

    -- open harpoon menu
    vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })

    -- jump to files
    vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = '[1] harpoon file' })
    vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = '[2] harpoon file' })
    vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = '[3] harpoon file' })
    vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = '[4] harpoon file' })
    vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end, { desc = '[5] harpoon file' })
    --vim.keymap.set('n', '<leader>hn', function() harpoon:list():next() end, { desc = '[N]ext harpoon file' })
    --vim.keymap.set('n', '<leader>hp', function() harpoon:list():prev() end, { desc = '[P]revious harpoon file' })

    -- telescope integration
    vim.keymap.set('n', '<leader>fh', function() require('telescope').extensions.harpoon.marks() end, { desc = 'Telescope Harpoon' })
end

M.setup_lsp = function(event)
    local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, {
            buffer = event.buf,
            desc = 'LSP: ' .. desc,
        })
    end

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('n', 'grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('n', 'grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

M.setup_neotree = function()
    return {
        {
            '\\',
            function()
                -- get Git root if it exists, fallback to cwd
                local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
                local dir = vim.fn.isdirectory(git_root) == 1 and git_root or vim.loop.cwd()
                require('neo-tree.command').execute {
                    toggle = true,
                    dir = dir,
                    reveal = true, -- keeps current file selected
                }
            end,
            desc = 'Toggle NeoTree at Git root',
            silent = true,
        },
    }
end

M.setup_telescope_builtin = function(builtin)
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sf', builtin.git_files, { desc = '[S]earch Git[F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>fh', function() require('telescope').extensions.harpoon.marks() end, { desc = '[F]ind [H]arpoon' })
    vim.keymap.set('n', '<leader>sp', function() builtin.grep_string { search = vim.fn.input 'Grep > ' } end, { desc = '[P]roject [S]earch by [G]rep' })

    -- Override default behavior and theme when searching
    vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set(
        'n',
        '<leader>s/',
        function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end,
        { desc = '[S]earch [/] in Open Files' }
    )

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
end

M.setup_telescope_lsp = function(builtin, buf)
    -- Helper function to set keymaps easier
    local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc }) end

    map('gf', vim.lsp.buf.definition, '[G]oto [F]ile (Definition)')

    -- JUMP TO DEFINITION (The one you were missing!)
    -- This replaces the broken 'gf' behavior.
    map('grd', builtin.lsp_definitions, '[G]oto [D]efinition')

    -- JUMP TO DECLARATION
    -- In C/C++, sometimes you want the .h (declaration) instead of the .cpp (definition).
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- FIND REFERENCES
    map('grr', builtin.lsp_references, '[G]oto [R]eferences')

    -- JUMP TO IMPLEMENTATION
    map('gri', builtin.lsp_implementations, '[G]oto [I]mplementation')

    -- TYPE DEFINITION
    map('grt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')

    -- DOCUMENT SYMBOLS (Fuzzy find functions/structs in current file)
    map('gO', builtin.lsp_document_symbols, 'Document Symbols')

    -- WORKSPACE SYMBOLS (Fuzzy find anything in the WHOLE project + BSP)
    map('gW', builtin.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

    -- RENAME (Rename a variable across ALL files in your project)
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- CODE ACTIONS (Fix-its, like adding missing includes)
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- HOVER DOCUMENTATION (See function signatures and comments)
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
end

M.setup_toggleterm = function(Terminal)
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

    local float_term = Terminal:new {
        direction = 'float',
        float_opts = {
            border = 'curved',
        },
        hidden = true,
    }

    -- Global function so our keymap can find it
    function _TOGGLE_FLOATING_TERM() float_term:toggle() end

    -- New bind for your general floating terminal
    vim.keymap.set('n', '<leader>tf', '<cmd>lua _TOGGLE_FLOATING_TERM()<CR>', { desc = '[T]erminal [F]loat' })
end

M.setup_undotree = function()
    return {
        { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Toggle Undotree' },
    }
end

M.setup_neogit = function()
    return {
        { '<leader>ng', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
        { '<leader>nd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
        { '<leader>nD', '<cmd>DiffviewClose<cr>', desc = 'Close Diffview' },
    }
end

M.setup_rename = function()
    vim.keymap.set('n', '<leader>rn', function() return ':IncRename ' .. vim.fn.expand '<cword>' end, { expr = true, desc = 'Incremental rename' })
end

M.setup_rust_lsp = function(bufnr)
    vim.keymap.set('n', '<leader>db', function()
        local ok, pb = pcall(require, 'persistent-breakpoints.api')
        if ok then
            pb.toggle_breakpoint()
        else
            require('dap').toggle_breakpoint()
        end
    end, { buffer = bufnr, desc = 'Toggle Breakpoint' })

    vim.keymap.set('n', '<leader>dc', require('dap').continue, {
        buffer = bufnr,
        desc = 'Debug Continue',
    })

    vim.keymap.set('n', '<leader>dr', '<cmd>RustLsp run<cr>', {
        buffer = bufnr,
        desc = 'Run Rust',
    })

    vim.keymap.set('n', '<leader>dd', function()
        require('dap').run {
            name = 'Debug current crate',
            type = 'codelldb',
            request = 'launch',
            program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file') end,
            cwd = '${workspaceFolder}',
        }
    end, { buffer = bufnr, desc = 'Debug' })

    vim.keymap.set('n', '<leader>bl', function()
        local dap_bps = require('dap.breakpoints').get()

        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'

        local results = {}

        for file, bps in pairs(dap_bps) do
            for _, bp in ipairs(bps) do
                table.insert(results, {
                    file = file,
                    line = bp.line,
                })
            end
        end

        if vim.tbl_isempty(results) then
            print 'No breakpoints set'
            return
        end

        pickers
            .new({}, {
                prompt_title = 'Breakpoints',
                finder = finders.new_table {
                    results = results,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = string.format('%s:%d', entry.file, entry.line),
                            ordinal = entry.file .. ':' .. entry.line,
                        }
                    end,
                },
                sorter = conf.generic_sorter {},

                -- use safe previewer
                previewer = conf.file_previewer {},

                attach_mappings = function(prompt_bufnr, map)
                    -- ENTER → jump to breakpoint
                    actions.select_default:replace(function()
                        local selection = action_state.get_selected_entry()
                        if not selection or not selection.value then return end

                        actions.close(prompt_bufnr)

                        vim.cmd('edit ' .. selection.value.file)
                        vim.api.nvim_win_set_cursor(0, { selection.value.line, 0 })
                    end)

                    -- dd → delete breakpoint
                    map('n', 'dd', function()
                        local selection = action_state.get_selected_entry()
                        if not selection or not selection.value then return end

                        actions.close(prompt_bufnr)

                        vim.cmd('edit ' .. selection.value.file)
                        vim.api.nvim_win_set_cursor(0, { selection.value.line, 0 })
                        require('dap').toggle_breakpoint()
                    end)

                    return true
                end,
            })
            :find()
    end, { buffer = bufnr, desc = 'List Breakpoints' })
end

M.setup_whichkey = function()
    return {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk/[H]arpoon', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
        { '<leader>c', group = '[C]argo', mode = { 'n' } },
        { 'g', group = '[G]oto' },
        { 'gr', group = '[G]oto [R]eferences/LSP', mode = { 'n' } },
        { 'n', group = '[N]eoGit', mode = { 'n' } },
    }
end

return M
