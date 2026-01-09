vim.pack.add({
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

require("nvim-tree").setup({
  view = {
    width = 30,
  },
})
