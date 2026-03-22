return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '▎', -- You can use "│", "┆", or "┊"
    },
    scope = {
      enabled = true, -- Highlights the current block you are in
      show_start = false,
      show_end = false,
    },
  },
}
