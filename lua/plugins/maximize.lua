return function()
  vim.pack.add({
    { src = "https://github.com/declancm/maximize.nvim" },
  })
  local module = require("maximize")
  module.setup()

  vim.keymap.set("n", "<C-m>", function()
    module.toggle()
  end, { desc = "toggle maximize" })
end
