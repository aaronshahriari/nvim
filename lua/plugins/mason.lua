return function()
  vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
  })

  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
end
