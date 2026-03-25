-- Import all plugin specs
return {
    require 'plugins.colorscheme', -- load colors first
    require 'plugins.treesitter', -- syntax highlighting ready
    require 'plugins.todo-comments', -- highlights can use treesitter
    require 'plugins.neo-tree', -- buffer highlights and icons are ready
    require 'plugins.lsp', -- LSP attaches after treesitter
    require 'plugins.telescope', -- pickers using LSP will work
    require 'plugins.harpoon',
    require 'plugins.gitsigns', -- git features
    require 'plugins.guess-indent', -- indentation detection
    require 'plugins.which-key', -- keybinding hints
    require 'plugins.conform', -- autoformatting (LSP already loaded)
    require 'plugins.blink', -- completion/snippets
    require 'plugins.misc', -- other utilities
    require 'plugins.toggleterm', -- terminal
    require 'plugins.autopairs',
    require 'plugins.indent-blankline',
    require 'plugins.undotree',
    require 'plugins.editorconfig',
    require 'plugins.neogit',
    require 'plugins.rename',
    require 'plugins.dap',
    require 'plugins.rust',
}
