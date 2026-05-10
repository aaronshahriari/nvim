return function()
  vim.pack.add({
    { src = "https://github.com/github/copilot.vim" },
  })

  vim.g.copilot_filetypes = {
    ["*"] = false,
    python = true,
  }
end
