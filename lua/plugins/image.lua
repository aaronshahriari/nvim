return function()
  vim.pack.add({
    { src = "https://github.com/3rd/image.nvim" },
  })
  local module = require("image")
  module.setup()
end
