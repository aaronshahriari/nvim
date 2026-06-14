return function()
  vim.pack.add({
    { src = "https://github.com/aaronshahriari/redis.nvim" },
  })
  local redis = require("redis-nvim")
  redis.setup()
end
