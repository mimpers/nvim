-- [[ Basic Autocommands ]]
--  Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 1 then vim.api.nvim_win_set_cursor(0, { row, col }) end
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function() require('harpoon'):list() end,
})
