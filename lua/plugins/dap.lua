return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require 'dap'

            -- 1. Define the signs for the gutter
            vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
            vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DiagnosticInfo' })
            vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticWarn' })

            -- 2. Define the GDB Adapter
            dap.adapters.gdb = {
                type = 'executable',
                command = 'arm-none-eabi-gdb',
                args = { '-i', 'dap' },
            }

            -- 3. Vitis Configurations
            dap.configurations.cpp = {
                {
                    name = 'Vitis SmartLynq Attach',
                    type = 'gdb',
                    request = 'attach',
                    -- Update this to your SmartLynq IP
                    target = '10.0.0.2:3000',
                    executable = function()
                        -- Automatically find the ELF in your workspace
                        return vim.fn.getcwd() .. '/Vitis/workspace/Module_app/Debug/Module_app.elf'
                    end,
                    cwd = '${workspaceRoot}',
                    -- This matches your VSCode 'autorun'
                    initialize_commands = {
                        'set confirm off',
                        'monitor ps',
                    },
                },
            }
            -- Link C files to use the same config
            dap.configurations.c = dap.configurations.cpp
        end,
    },

    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            local dap, dapui = require 'dap', require 'dapui'
            dapui.setup()
            dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
            dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
            dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
        end,
    },

    {
        'Weissle/persistent-breakpoints.nvim',
        dependencies = { 'mfussenegger/nvim-dap' },
        event = 'BufReadPost',
        config = function()
            require('persistent-breakpoints').setup {
                load_breakpoints_event = { 'BufReadPost' },
            }
        end,
    },
}
