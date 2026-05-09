return function()
  vim.pack.add({
    { src = "https://github.com/nvimdev/hlsearch.nvim" },
  })

  require("hlsearch").setup()
end
