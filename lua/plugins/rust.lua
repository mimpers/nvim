---@type LazySpec
return {
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },

        config = function()
            vim.g.rustaceanvim = {
                tools = {},

                server = {
                    on_attach = function(_, bufnr) require('config.keymaps').setup_rust_lsp(bufnr) end,
                },

                dap = {
                    adapter = require('rustaceanvim.config').get_codelldb_adapter(
                        vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
                        vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.so'
                    ),
                },
            }
        end,
    },
}
