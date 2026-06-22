return function()
  vim.pack.add({
    { src = "<url>" },
  })
  local module = require("<plugin>")
  module.setup()
end
