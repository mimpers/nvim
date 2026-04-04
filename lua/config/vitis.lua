local M = {}

function M.setup(Terminal)
    -- Vmake: Full Build
    vim.api.nvim_create_user_command('Vmake', function()
        local vitis_build = Terminal:new {
            cmd = 'bash ~/scripts/vitis-make.sh',
            direction = 'float',
            close_on_exit = false,
            on_open = function(term)
                vim.api.nvim_set_current_win(term.window)
                vim.cmd 'stopinsert'
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
            on_close = function(term) term:shutdown() end,
        }
        vitis_build:toggle()
    end, {})

    -- Vclean: Project Cleanup
    vim.api.nvim_create_user_command('Vclean', function()
        local vitis_clean = Terminal:new {
            cmd = 'bash ~/scripts/vitis-clean.sh',
            direction = 'float',
            close_on_exit = false,
            on_open = function(term)
                vim.api.nvim_set_current_win(term.window)
                vim.cmd 'stopinsert'
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
            on_close = function(term) term:shutdown() end,
        }
        vitis_clean:toggle()
    end, {})

    -- Vxsa: Update Hardware Specification (Takes 1 File Argument)
    vim.api.nvim_create_user_command('Vxsa', function(opts)
        if opts.args == '' then
            print 'Error: Please provide a path to the XSA file.'
            return
        end
        local vitis_xsa = Terminal:new {
            cmd = 'bash ~/scripts/vitis-xsa.sh ' .. opts.args,
            direction = 'float',
            close_on_exit = false,
            on_open = function(term)
                vim.api.nvim_set_current_win(term.window)
                vim.cmd 'stopinsert'
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
            on_close = function(term) term:shutdown() end,
        }
        vitis_xsa:toggle()
    end, { nargs = 1, complete = 'file' })

    -- Vinit: Initialize Hardware via SmartLynq (Optional IP Argument)
    vim.api.nvim_create_user_command('Vinit', function(opts)
        local ip = (opts.args ~= '') and opts.args or '10.0.0.2'
        local vitis_init = Terminal:new {
            cmd = 'xsdb -interactive ./.vscode/dbg_init.tcl ' .. ip,
            direction = 'float',
            close_on_exit = false,
            on_open = function(term)
                vim.api.nvim_set_current_win(term.window)
                vim.cmd 'stopinsert'
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
            end,
            on_close = function(term) term:shutdown() end,
        }
        vitis_init:toggle()
    end, { nargs = '?' })
end

return M
