return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            vim.fn.sign_define('DapBreakpoint', {
                text = '●',
                texthl = 'DiagnosticError',
            })

            vim.fn.sign_define('DapBreakpointCondition', {
                text = '◆',
                texthl = 'DiagnosticWarn',
            })

            vim.fn.sign_define('DapLogPoint', {
                text = '◆',
                texthl = 'DiagnosticInfo',
            })

            vim.fn.sign_define('DapStopped', {
                text = '▶',
                texthl = 'DiagnosticWarn',
            })
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
}
