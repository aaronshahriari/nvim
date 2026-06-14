return function()
  vim.pack.add({
    { src = "https://git.barrettruth.com/barrettruth/diffs.nvim" }
  })
  vim.g.diffs = {
    integrations = {
      fugitive = true
    }
  }
end
