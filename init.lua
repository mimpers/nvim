-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.env.PATH = vim.env.PATH .. ':' .. os.getenv 'HOME' .. '/.cargo/bin'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.diagnostics'
require 'config.lazy'
