return {
  "k-lar/dynomark.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {},
  vim.keymap.set('n', '<leader>v', ':Dynomark toggle<CR>', { noremap = true, silent = true })
}
